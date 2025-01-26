<script lang="ts">
import axios from 'axios';

export default {
    data() {
        return {
            // Données utilisateur
            name: "",
            surname: "",
            email: "",
            adresse: "", // Adresse saisie par l'utilisateur
            code: "", // Code postal saisi par l'utilisateur
            city: "",

            // Panier
            cart: [] as Array<{ id: number, name: string, price: number, quantity: number, image: string }>,
            isLoading: true,
        };
    },
    computed: {
        // Calcul du prix total du panier
        totalPrice() {
            return this.cart.reduce(
                (total, item) => total + item.price * item.quantity,
                0
            ).toFixed(2);
        },

        // Calcul du nombre total de produits
        totalQuantity() {
            return this.cart.reduce((total, item) => total + item.quantity, 0);
        },
    },
    methods: {
        // Récupère les informations utilisateur
        async fetchUserInfo() {
            try {
                const response = await axios.get('/api/user');
                const user = response.data;

                this.name = user.name || ""; // Nom de l'utilisateur
                this.surname = user.surname || ""; // Prénom de l'utilisateur
                this.email = user.email || ""; // Email de l'utilisateur
            } catch (error) {
                console.error('Erreur lors de la récupération des informations utilisateur :', error);
                alert("Impossible de charger les informations utilisateur.");
            }
        },

        // Récupère le panier
        async fetchCart() {
            try {
                const response = await axios.get('/api/cart');
                this.cart = response.data.data.map((item: { id: number, name: string, price: number, quantity: number, image: string }) => ({
                    id: item.id,
                    name: item.name,
                    price: item.price,
                    quantity: item.quantity,
                    image: item.image || '',
                }));
            } catch (error) {
                console.error('Erreur lors du chargement du panier :', error);
                alert("Impossible de charger votre panier.");
            }
        },

        // Soumet les données du checkout
        async handleSubmit() {
            if (!this.adresse || !this.code) {
                alert("Veuillez renseigner l'adresse et le code postal.");
                return;
            }

            try {
                const response = await axios.post('/api/checkout', {
                    address: this.adresse,
                    postal_code: this.code,
                    city: this.city,
                    cart: this.cart,
                    total_price: this.totalPrice,
                    total_quantity: this.totalQuantity,
                });
                alert('Commande validée avec succès ! ID de commande : ' + response.data.order_id);
                this.cart = []; // Réinitialise le panier après validation
                await this.fetchCart(); // Recharge le panier
                // Redirige l'utilisateur vers la page d'accueil
                this.$router.push('/dashboard');
            } catch (error) {
                console.error('Erreur lors de la validation de la commande :', error);
                alert("Une erreur est survenue lors de la validation de votre commande.");
            }
        },
    },
    async mounted() {
        // Charge les informations utilisateur et le panier lors du montage
        await this.fetchUserInfo();
        await this.fetchCart();
        this.isLoading = false;
    },
};
</script>

<template>
    <div class="flex bg-gray-100 min-h-screen justify-center">
        <!-- Information Utilisateur -->
        <div class="py-10 mr-10 w-96">
            <div class="w-full max-w-md p-8 space-y-6 bg-white rounded shadow-md">
                <h2 class="text-lg text-gray-800 font-semibold">Vos informations</h2>
                <form @submit.prevent="handleSubmit" class="space-y-4">
                    <div>
                        <label for="surname" class="block text-sm text-gray-800 font-semibold">Nom<span
                        class="text-red-700">*</span></label>
                        <input type="text" id="surname" v-model="surname"
                            class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500"
                            disabled />
                    </div>
                    <div>
                        <label for="name" class="block text-sm text-gray-800 font-semibold">Prénom<span
                        class="text-red-700">*</span></label>
                        <input type="text" id="name" v-model="name"
                            class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500"
                            disabled />
                    </div>
                    <div>
                        <label for="email" class="block text-sm text-gray-800 font-semibold">Email<span
                        class="text-red-700">*</span></label>
                        <input type="email" id="email" v-model="email"
                            class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500"
                            disabled />
                    </div>
                    <div>
                        <label for="adresse" class="block text-sm text-gray-800 font-semibold">Adresse<span
                        class="text-red-700">*</span></label>
                        <input type="text" id="adresse" v-model="adresse"
                            class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500" />
                    </div>
                    <div>
                        <label for="city" class="block text-sm text-gray-800 font-semibold">Ville<span
                        class="text-red-700">*</span></label>
                        <input type="text" id="city" v-model="city"
                            class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500" />
                    </div>
                    <div>
                        <label for="code" class="block text-sm text-gray-800 font-semibold">Code postal<span
                        class="text-red-700">*</span></label>
                        <input type="text" id="code" v-model="code"
                            class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500" />
                    </div>
                </form>
            </div>
        </div>
        <!-- Information Panier -->
        <div class="py-10 ml-10 w-96">
            <div class="container mx-auto max-w-4xl bg-white p-8 shadow-lg rounded-lg">
                <h2 class="text-lg text-gray-800 font-semibold">Détails de la commande</h2>
                <!-- Cart Items -->
                <div v-if="cart.length" class="space-y-4">
                    <div v-for="(item, __) in cart" :key="item.id"
                        class="flex items-center justify-between border-b pb-4">
                        <!-- Item Details -->
                        <div class="flex items-center space-x-4">
                            <img :src="item.image" alt="Product" class="w-16 h-16 object-cover rounded-md" />
                            <div>
                                <h2 class="text-gray-800 font-semibold">{{ item.name }}</h2>
                                <p class="text-sm text-gray-800 font-semibold">Prix: {{ item.price }}€</p>
                            </div>
                        </div>
                        <div class="flex items-center space-x-2">
                            <span class="px-3 py-1">x{{ item.quantity }}</span>
                        </div>
                        <p class="text-gray-800 font-semibold">
                            {{ (item.price * item.quantity).toFixed(2) }}€
                        </p>
                    </div>
                </div>
                <!-- Cart Summary -->
                <div v-if="cart.length" class="mt-6">
                    <div class="flex justify-between items-center">
                        <h3 class="text-lg font-semibold">Total:</h3>
                        <p class="text-xl font-bold text-gray-800">
                            {{ totalPrice }}€
                        </p>
                    </div>
                    <button @click="handleSubmit"
                        class="w-full px-4 py-2 text-white bg-primary rounded-md hover:bg-secondary focus:outline-none focus:ring focus:ring-blue-300 mt-6">
                        Payer
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>


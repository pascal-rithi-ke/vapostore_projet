<script lang="ts">
import axios from 'axios';
import { ref } from 'vue';

export default {
    data() {
        return {
            // Données utilisateur
            name: "",
            surname: "",
            email: "",
            adresse: "",
            code: "",
            city: "",

            // Panier
            cart: [] as Array<{ id: number, name: string, price: number, quantity: number, image: string }>,
            isLoading: true,

            // Popup
            showPopup: false,
            popupMessage: "",
            popupType: "success", // "success" ou "error"
        };
    },
    computed: {
        totalPrice() {
            return this.cart.reduce((total, item) => total + item.price * item.quantity, 0).toFixed(2);
        },
        totalQuantity() {
            return this.cart.reduce((total, item) => total + item.quantity, 0);
        },
    },
    methods: {
        async fetchUserInfo() {
            try {
                const response = await axios.get('/api/user');
                const user = response.data;

                this.name = user.name || "";
                this.surname = user.surname || "";
                this.email = user.email || "";
            } catch (error) {
                this.showPopupMessage("Erreur lors de la récupération des informations utilisateur.", "error");
            }
        },
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
                this.showPopupMessage("Erreur lors du chargement du panier.", "error");
            }
        },
        async handleSubmit() {
            if (!this.adresse || !this.code) {
                this.showPopupMessage("Veuillez renseigner l'adresse et le code postal.", "error");
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

                this.showPopupMessage(
                    `Commande validée avec succès ! ID de commande : ${response.data.order_id}`,
                    "success"
                );
                this.cart = [];
                await this.fetchCart();
                this.$router.push('/dashboard');
            } catch (error) {
                this.showPopupMessage("Une erreur est survenue lors de la validation de votre commande.", "error");
            }
        },
        showPopupMessage(message: string, type: "success" | "error") {
            this.popupMessage = message;
            this.popupType = type;
            this.showPopup = true;

            // Fermer la popup automatiquement après 3 secondes
            setTimeout(() => {
                this.showPopup = false;
            }, 3000);
        },
    },
    async mounted() {
        await this.fetchUserInfo();
        await this.fetchCart();
        this.isLoading = false;
    },
};
</script>

<template>
    <div class="min-h-screen bg-gray-100 py-10">
        <div class="container mx-auto grid grid-cols-1 md:grid-cols-2 gap-8">
            <!-- Section Informations Utilisateur -->
            <div class="bg-white p-6 rounded-lg shadow">
                <h2 class="text-lg font-semibold text-gray-800 mb-4">Vos informations</h2>
                <form @submit.prevent="handleSubmit" class="space-y-4">
                    <div>
                        <label for="surname" class="block text-sm font-semibold text-gray-800">Nom<span class="text-red-700">*</span></label>
                        <input type="text" id="surname" v-model="surname" class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500" disabled />
                    </div>
                    <div>
                        <label for="name" class="block text-sm font-semibold text-gray-800">Prénom<span class="text-red-700">*</span></label>
                        <input type="text" id="name" v-model="name" class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500" disabled />
                    </div>
                    <div>
                        <label for="email" class="block text-sm font-semibold text-gray-800">Email<span class="text-red-700">*</span></label>
                        <input type="email" id="email" v-model="email" class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500" disabled />
                    </div>
                    <div>
                        <label for="adresse" class="block text-sm font-semibold text-gray-800">Adresse<span class="text-red-700">*</span></label>
                        <input type="text" id="adresse" v-model="adresse" class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500" />
                    </div>
                    <div>
                        <label for="city" class="block text-sm font-semibold text-gray-800">Ville<span class="text-red-700">*</span></label>
                        <input type="text" id="city" v-model="city" class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500" />
                    </div>
                    <div>
                        <label for="code" class="block text-sm font-semibold text-gray-800">Code postal<span class="text-red-700">*</span></label>
                        <input type="text" id="code" v-model="code" class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500" />
                    </div>
                </form>
            </div>

            <!-- Section Détails du Panier -->
            <div class="bg-white p-6 rounded-lg shadow">
                <h2 class="text-lg font-semibold text-gray-800 mb-4">Détails de la commande</h2>
                <div v-if="cart.length" class="space-y-4">
                    <div v-for="item in cart" :key="item.id" class="flex items-center justify-between border-b pb-4">
                        <div class="flex items-center space-x-4">
                            <img :src="item.image" alt="Product" class="w-16 h-16 object-cover rounded-md" />
                            <div>
                                <h3 class="text-gray-800 font-semibold">{{ item.name }}</h3>
                                <p class="text-sm text-gray-600">Prix: {{ item.price }}€</p>
                            </div>
                        </div>
                        <p class="text-gray-800 font-semibold">x{{ item.quantity }}</p>
                        <p class="text-gray-800 font-semibold">
                            {{ (item.price * item.quantity).toFixed(2) }}€
                        </p>
                    </div>
                </div>
                <div class="mt-6">
                    <div class="flex justify-between items-center">
                        <h3 class="text-lg font-semibold">Total :</h3>
                        <p class="text-xl font-bold text-gray-800">{{ totalPrice }}€</p>
                    </div>
                    <button @click="handleSubmit" class="w-full mt-4 py-2 bg-primary text-white rounded-md hover:bg-secondary focus:outline-none focus:ring focus:ring-blue-300">
                        Valider le panier
                    </button>
                </div>
            </div>
        </div>

        <!-- Popup personnalisée -->
        <div v-if="showPopup" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 z-50">
            <div
                class="bg-white p-6 rounded-lg shadow-lg max-w-md w-full text-center"
                :class="popupType === 'success' ? 'border-green-500' : 'border-red-500'"
            >
                <p class="text-lg font-medium" :class="popupType === 'success' ? 'text-green-600' : 'text-red-600'">
                    {{ popupMessage }}
                </p>
                <button @click="showPopup = false" class="mt-4 px-6 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600">
                    OK
                </button>
            </div>
        </div>
    </div>
</template>

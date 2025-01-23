<script lang="ts">
import eCigarette from '../assets/e-cigarette.jpg';
import eLiquide from '../assets/e-liquide.png';
export default {
    data() {
        return {
            name: "",
            surname: "",
            email: "",
            adresse: "",
            numero: "",
            code: "",

            cart: [
                {
                    id: 1,
                    name: "Produt 1",
                    price: 29.99,
                    quantity: 1,
                    image: eCigarette
                },
                {
                    id: 2,
                    name: "Produt 2",
                    price: 49.99,
                    quantity: 2,
                    image: eLiquide
                },
            ],
        };
    },
    methods: {
        handleSubmit() {
            console.log("Name:", this.name);
            console.log("Surname:", this.surname);
            console.log("Email:", this.email);
            console.log("adresse:", this.adresse);
            console.log("numero:", this.numero);
            console.log("code:", this.code);
            // Ajoute ici la logique pour gérer l'inscription
        },
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
                        <label for="surname" class="block text-sm text-gray-800 font-semibold">Nom</label>
                        <input type="text" id="name" v-model="name" placeholder="Doe Updated"
                            class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500"
                            disabled />
                    </div>
                    <div>
                        <label for="name" class="block text-sm text-gray-800 font-semibold">Prénom</label>
                        <input type="text" id="name" v-model="name" placeholder="Jane"
                            class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500"
                            disabled />
                    </div>
                    <div>
                        <label for="email" class="block text-sm text-gray-800 font-semibold">Email</label>
                        <input type="email" id="email" v-model="email" placeholder="jane.doe@example.com"
                            class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500"
                            disabled />
                    </div>
                    <div>
                        <label for="adresse" class="block text-sm text-gray-800 font-semibold">Adresse</label>
                        <input type="text" id="adresse" v-model="adresse"
                            class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500"/>
                    </div>
                    <div>
                        <label for="numero" class="block text-sm text-gray-800 font-semibold">N° de rue ou bâtiment</label>
                        <input type="text" id="numero" v-model="numero"
                            class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500"/>
                    </div>
                    <div>
                        <label for="code" class="block text-sm text-gray-800 font-semibold">Code postale</label>
                        <input type="text" id="code" v-model="code" min="1"
                            class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500"/>
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
                    <div v-for="(item, index) in cart" :key="item.id"
                        class="flex items-center justify-between border-b pb-4">
                        <!-- Item Details -->
                        <div class="flex items-center space-x-4">
                            <img :src="item.image" alt="Product" class="w-16 h-16 object-cover rounded-md" />
                            <div>
                                <h2 class="text-gray-800 font-semibold">{{ item.name }}</h2>
                                <p class="text-sm text-gray-800 font-semibold">Prix: {{ item.price }}€</p>
                            </div>
                        </div>

                        <!-- Quantity Controls -->
                        <div class="flex items-center space-x-2">
                            <span class="px-3 py-1">x{{ item.quantity }}</span>
                        </div>

                        <!-- Subtotal -->
                        <p class="text-gray-800 font-semibold">
                            {{ (item.price * item.quantity).toFixed(2) }}€
                        </p>
                    </div>
                </div>

                <!-- Empty Cart -->
                <div v-else class="text-center text-gray-800 font-semibold">
                    <p>Votre Panier est vide</p>
                </div>

                <!-- Cart Summary -->
                <div v-if="cart.length" class="mt-6">
                    <div class="flex justify-between items-center">
                        <h3 class="text-lg font-semibold">Total:</h3>
                        <p class="text-xl font-bold text-gray-800">129.97€</p>
                    </div>
                    <button type="submit" class="w-full px-4 py-2 text-white bg-primary rounded-md hover:bg-secondary focus:outline-none focus:ring focus:ring-blue-300 mt-6">Payer</button>
                </div>
            </div>
        </div>
    </div>
</template>
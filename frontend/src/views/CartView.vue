<script lang="ts">
import eCigarette from '../assets/e-cigarette.jpg';
import eLiquide from '../assets/e-liquide.png';

export default {
    data() {
        return {
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
    computed: {
        totalPrice() {
            return this.cart.reduce(
                (total, item) => total + item.price * item.quantity,
                0
            );
        },
    },
    methods: {
        increaseQuantity(index: number) {
            this.cart[index].quantity++;
        },
        decreaseQuantity(index: number){
            if (this.cart[index].quantity > 1) {
                this.cart[index].quantity--;
            }
        },
        removeItem(index: number) {
            this.cart.splice(index, 1);
        },
    },
};
</script>

<template>
    <div class="min-h-screen bg-gray-100 py-10">
        <div class="container mx-auto max-w-4xl bg-white p-6 shadow-lg rounded-lg">
            <!-- Header -->
            <h1 class="text-2xl font-bold text-gray-800 mb-6">Panier</h1>

            <!-- Cart Items -->
            <div v-if="cart.length" class="space-y-4">
                <div v-for="(item, index) in cart" :key="item.id"
                    class="flex items-center justify-between border-b pb-4">
                    <!-- Item Details -->
                    <div class="flex items-center space-x-4">
                        <img :src="item.image" alt="Product" class="w-16 h-16 object-cover rounded-md" />
                        <div>
                            <h2 class="text-gray-800 font-semibold">{{ item.name }}</h2>
                            <p class="text-sm text-gray-600">Prix: {{ item.price }}€</p>
                        </div>
                    </div>

                    <!-- Quantity Controls -->
                    <div class="flex items-center space-x-2">
                        <button class="px-2 py-1 bg-gray-200 rounded-md hover:bg-gray-300"
                            @click="decreaseQuantity(index)">
                            -
                        </button>
                        <span class="px-3 py-1 border rounded-md">{{ item.quantity }}</span>
                        <button class="px-2 py-1 bg-gray-200 rounded-md hover:bg-gray-300"
                            @click="increaseQuantity(index)">
                            +
                        </button>
                    </div>

                    <!-- Subtotal -->
                    <p class="text-gray-800 font-semibold">
                        {{ (item.price * item.quantity).toFixed(2) }}€
                    </p>

                    <!-- Remove Item -->
                    <button class="text-red-500 hover:text-red-700" @click="removeItem(index)">
                        Supprimer
                    </button>
                </div>
            </div>

            <!-- Empty Cart -->
            <div v-else class="text-center text-gray-600">
                <p>Votre Panier est vide</p>
            </div>

            <!-- Cart Summary -->
            <div v-if="cart.length" class="mt-6">
                <div class="flex justify-between items-center">
                    <h3 class="text-lg font-semibold">Total:</h3>
                    <p class="text-xl font-bold text-gray-800">{{ totalPrice.toFixed(2) }}€</p>
                </div>
                <router-link to="checkout">
                    <button class="mt-4 w-full bg-primary text-white py-2 rounded-md hover:bg-secondary">
                        Valider le panier
                    </button>
                </router-link>
            </div>
        </div>
    </div>
</template>
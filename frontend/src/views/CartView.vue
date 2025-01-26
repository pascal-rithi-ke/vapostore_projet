<script lang="ts">
import axios from 'axios';

export default {
    data() {
        return {
            cart: [] as Array<{ id: number; name: string; price: number; quantity: number; image: string }>,
            isLoading: true,
            error: null as string | null,
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
        async fetchCart() {
            try {
                const response = await axios.get('/api/cart'); // Appel à l'API Laravel
                this.cart = response.data.data.map((item: { id: number; name: string; price: number; quantity: number; image: string }) => ({
                    id: item.id,
                    name: item.name,
                    price: item.price, // Récupéré depuis pivot dans l'API
                    quantity: item.quantity, // Récupéré depuis pivot dans l'API
                    image: item.image || '', // Image par défaut si elle n'existe pas
                }));
            } catch (err) {
                this.error = 'Erreur lors du chargement du panier.';
                console.error(err);
            } finally {
                this.isLoading = false;
            }
        },
        async increaseQuantity(productId: number) {
            const product = this.cart.find((item) => item.id === productId);
            if (product) {
                try {
                    await axios.post('/api/update-cart', {
                        product_id: productId,
                        quantity: product.quantity + 1,
                    });
                    product.quantity++;
                } catch (err) {
                    alert('Impossible de mettre à jour la quantité.');
                    console.error(err);
                }
            }
        },
        async decreaseQuantity(productId: number) {
            const product = this.cart.find((item) => item.id === productId);
            if (product && product.quantity > 1) {
                try {
                    await axios.post('/api/update-cart', {
                        product_id: productId,
                        quantity: product.quantity - 1,
                    });
                    product.quantity--;
                } catch (err) {
                    alert('Impossible de mettre à jour la quantité.');
                    console.error(err);
                }
            }
        },
        async removeItem(productId: number) {
            try {
                await axios.post('/api/remove-product', {
                    product_id: productId,
                });
                this.cart = this.cart.filter((item) => item.id !== productId);
            } catch (err) {
                alert('Impossible de supprimer le produit du panier.');
                console.error(err);
            }
        },
    },
    async mounted() {
        await this.fetchCart();
    },
};
</script>

<template>
    <div class="min-h-screen bg-gray-100 py-10">
        <div class="container mx-auto max-w-4xl bg-white p-6 shadow-lg rounded-lg">
            <h1 class="text-2xl font-bold text-gray-800 mb-6">Panier</h1>

            <!-- Loading -->
            <div v-if="isLoading" class="text-center text-gray-600">
                Chargement du panier...
            </div>

            <!-- Error -->
            <div v-if="error" class="text-center text-red-500">
                {{ error }}
            </div>

            <!-- Cart Items -->
            <div v-if="cart.length && !isLoading" class="space-y-4">
                <div v-for="(item, __) in cart" :key="item.id"
                    class="flex items-center justify-between border-b pb-4">
                    <div class="flex items-center space-x-4">
                        <img :src="item.image" alt="Product" class="w-16 h-16 object-cover rounded-md" />
                        <div>
                            <h2 class="text-gray-800 font-semibold">{{ item.name }}</h2>
                            <p class="text-sm text-gray-600">Prix: {{ item.price }}€</p>
                        </div>
                    </div>

                    <div class="flex items-center space-x-2">
                        <button class="px-2 py-1 bg-gray-200 rounded-md hover:bg-gray-300"
                            @click="decreaseQuantity(item.id)">
                            -
                        </button>
                        <span class="px-3 py-1 border rounded-md">{{ item.quantity }}</span>
                        <button class="px-2 py-1 bg-gray-200 rounded-md hover:bg-gray-300"
                            @click="increaseQuantity(item.id)">
                            +
                        </button>
                    </div>

                    <p class="text-gray-800 font-semibold">
                        {{ (item.price * item.quantity).toFixed(2) }}€
                    </p>

                    <button class="text-red-500 hover:text-red-700" @click="removeItem(item.id)">
                        Supprimer
                    </button>
                </div>
            </div>

            <div v-else-if="!isLoading" class="text-center text-gray-600">
                <p>Votre Panier est vide</p>
            </div>

            <!-- Cart Summary -->
            <div v-if="cart.length && !isLoading" class="mt-6">
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

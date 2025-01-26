<script lang="ts">
import axios from 'axios';

export default {
    data() {
        return {
            cart: [] as Array<{ id: number; name: string; price: number; quantity: number; image: string }>,
            pendingUpdates: {} as Record<number, { quantity: number | null }>, // Stocke les modifications (quantity=null pour suppression)
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
                const response = await axios.get('/api/cart');
                this.cart = response.data.data.map((item: { id: number; name: string; price: number; quantity: number; image?: string }) => ({
                    id: item.id,
                    name: item.name,
                    price: item.price,
                    quantity: item.quantity,
                    image: item.image || '',
                }));
            } catch (err) {
                this.error = 'Erreur lors du chargement du panier.';
                console.error(err);
            } finally {
                this.isLoading = false;
            }
        },

        increaseQuantity(productId: number) {
            const product = this.cart.find(item => item.id === productId);
            if (product) {
                product.quantity++;
                this.pendingUpdates[productId] = { quantity: product.quantity };
            }
        },

        decreaseQuantity(productId: number) {
            const product = this.cart.find(item => item.id === productId);
            if (product && product.quantity > 1) {
                product.quantity--;
                this.pendingUpdates[productId] = { quantity: product.quantity };
            }
        },

        removeFromCart(productId: number) {
            // Supprimer localement
            this.cart = this.cart.filter(item => item.id !== productId);

            // Marquer pour suppression lors de la synchronisation
            this.pendingUpdates[productId] = { quantity: null };
        },

        async syncCart() {
            const updates = Object.keys(this.pendingUpdates).map(productId => ({
                product_id: Number(productId),
                quantity: this.pendingUpdates[Number(productId)].quantity, // null pour suppression
            }));

            if (updates.length === 0) return; // Rien à synchroniser

            try {
                await axios.put('/api/update-cart-bulk', { updates });
                this.pendingUpdates = {}; // Réinitialiser les mises à jour locales
            } catch (err) {
                console.error('Erreur lors de la synchronisation du panier', err);
            }
        },
    },
    async mounted() {
        await this.fetchCart();

        // Synchronisation périodique toutes les 5 secondes
        setInterval(this.syncCart, 5000);
    },
    beforeDestroy() {
        // Synchronisation finale avant de quitter la page
        this.syncCart();
    },
};
</script>

<template>
    <div class="min-h-screen bg-gray-100 py-10">
        <div class="container mx-auto max-w-4xl bg-white p-6 shadow-lg rounded-lg">
            <h1 class="text-2xl font-bold text-gray-800 mb-6">Panier</h1>

            <div v-if="isLoading" class="text-center text-gray-600">
                Chargement du panier...
            </div>

            <div v-if="error" class="text-center text-red-500">
                {{ error }}
            </div>

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

                    <button class="text-red-500 hover:text-red-700" @click="removeFromCart(item.id)">
                        Supprimer
                    </button>
                </div>
            </div>

            <div v-else-if="!isLoading" class="text-center text-gray-600">
                <p>Votre Panier est vide</p>
            </div>

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


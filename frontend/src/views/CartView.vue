<script lang="ts">
import axios from "axios";

export default {
    data() {
        return {
            cart: [] as Array<{ id: number; name: string; price: number; quantity: number; image: string }>,
            pendingUpdates: {} as Record<number, { quantity: number | null }>, // Modifications en attente
            isLoading: true,
            error: null as string | null,
            showPopup: false, // État de la popup
            popupMessage: "", // Message de la popup
            popupCallback: null as (() => void) | null, // Action à exécuter
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
                const response = await axios.get("/api/cart");
                this.cart = response.data.data.map(
                    (item: { id: number; name: string; price: number; quantity: number; image?: string }) => ({
                        id: item.id,
                        name: item.name,
                        price: item.price,
                        quantity: item.quantity,
                        image: item.image || "",
                    })
                );
            } catch (err) {
                this.error = "Erreur lors du chargement du panier.";
                console.error(err);
            } finally {
                this.isLoading = false;
            }
        },

        increaseQuantity(productId: number) {
            const product = this.cart.find((item) => item.id === productId);
            if (product) {
                product.quantity++;
                this.pendingUpdates[productId] = { quantity: product.quantity };
            }
        },

        decreaseQuantity(productId: number) {
            const product = this.cart.find((item) => item.id === productId);
            if (product && product.quantity > 1) {
                product.quantity--;
                this.pendingUpdates[productId] = { quantity: product.quantity };
            }
        },

        confirmRemoveFromCart(productId: number) {
            const product = this.cart.find((item) => item.id === productId);
            if (!product) return;

            // Configure la popup
            this.popupMessage = `Êtes-vous sûr de vouloir supprimer "${product.name}" du panier ?`;
            this.showPopup = true;

            // Définir l'action à exécuter
            this.popupCallback = () => {
                this.removeFromCart(productId);
                this.showPopup = false;
            };
        },

        removeFromCart(productId: number) {
            this.cart = this.cart.filter((item) => item.id !== productId);
            this.pendingUpdates[productId] = { quantity: null };
        },

        async syncCart() {
            const updates = Object.keys(this.pendingUpdates).map((productId) => ({
                product_id: Number(productId),
                quantity: this.pendingUpdates[Number(productId)].quantity,
            }));

            if (updates.length === 0) return;

            try {
                await axios.put("/api/update-cart-bulk", { updates });
                this.pendingUpdates = {};
            } catch (err) {
                console.error("Erreur lors de la synchronisation du panier", err);
            }
        },
    },
    async mounted() {
        await this.fetchCart();
        setInterval(this.syncCart, 5000);
    },
    beforeDestroy() {
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

            <div v-if="cart.length && !isLoading" class="space-y-6">
                <div
                    v-for="item in cart"
                    :key="item.id"
                    class="flex items-start justify-between border-b pb-6"
                >
                    <!-- Image et nom du produit -->
                    <div class="flex items-center space-x-4">
                        <img :src="item.image" alt="Product" class="w-16 h-16 object-cover rounded-md" />
                        <div>
                            <h2 class="text-gray-800 font-semibold">{{ item.name }}</h2>
                            <p class="text-sm text-gray-600">Prix unitaire : {{ item.price }}€</p>
                        </div>
                    </div>

                    <!-- Quantité et actions -->
                    <div class="flex flex-col items-center space-y-2">
                        <div class="flex items-center space-x-2">
                            <button
                                class="px-2 py-1 bg-gray-200 rounded-md hover:bg-gray-300"
                                @click="decreaseQuantity(item.id)"
                            >
                                -
                            </button>
                            <span class="px-3 py-1 border rounded-md">{{ item.quantity }}</span>
                            <button
                                class="px-2 py-1 bg-gray-200 rounded-md hover:bg-gray-300"
                                @click="increaseQuantity(item.id)"
                            >
                                +
                            </button>
                        </div>
                        <p class="text-gray-800 font-semibold">
                            {{ (item.price * item.quantity).toFixed(2) }}€
                        </p>
                        <button
                            class="text-red-500 hover:text-red-700 text-sm"
                            @click="confirmRemoveFromCart(item.id)"
                        >
                            Supprimer
                        </button>
                    </div>
                </div>
            </div>

            <div v-else-if="!isLoading" class="text-center text-gray-600">
                <p>Votre Panier est vide</p>
            </div>

            <div v-if="cart.length && !isLoading" class="mt-6">
                <div class="flex justify-between items-center">
                    <h3 class="text-lg font-semibold">Total :</h3>
                    <p class="text-xl font-bold text-gray-800">{{ totalPrice.toFixed(2) }}€</p>
                </div>
                <router-link to="checkout">
                    <button class="mt-4 w-full bg-primary text-white py-2 rounded-md hover:bg-secondary">
                        Valider le panier
                    </button>
                </router-link>
            </div>
        </div>

        <!-- Popup personnalisée -->
        <div v-if="showPopup" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 z-50">
            <div class="bg-white rounded-lg shadow-lg p-6 max-w-md mx-auto">
                <p class="text-center text-gray-700 font-medium">{{ popupMessage }}</p>
                <div class="flex justify-center mt-4 space-x-4">
                    <button
                        @click="showPopup = false"
                        class="px-4 py-2 bg-gray-200 text-gray-800 rounded-lg shadow hover:bg-gray-300"
                    >
                        Annuler
                    </button>
                    <button
                        @click="popupCallback && popupCallback()"
                        class="px-4 py-2 bg-primary text-white rounded-lg shadow hover:bg-primary-600"
                    >
                        Confirmer
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>

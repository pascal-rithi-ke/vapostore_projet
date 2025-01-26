<script lang="ts">
import axios from "axios";
import { useAuthStore } from "../stores/auth";

axios.defaults.baseURL = "http://localhost:8000";
axios.defaults.withCredentials = true;

// Types pour les données
interface Product {
    id: number;
    name: string;
    price: number;
    pivot: {
        quantity: number;
        price: number;
    };
    image: string;
}

interface Order {
    id: number;
    total_price: number;
    created_at: string;
    cart: {
        products: Product[];
    };
}

export default {
    data() {
        return {
            orders: [] as Order[], // Type explicite pour les commandes
            isLoading: true,
            error: null as string | null,
        };
    },
    computed: {
        userData() {
            const authStore = useAuthStore();
            return authStore.user; // Utilise les données utilisateur depuis Pinia
        },
    },
    methods: {
        async fetchOrders() {
            try {
                const response = await axios.get("/api/orders");
                this.orders = response.data; // Les données récupérées sont typées comme `Order[]`
            } catch (error) {
                console.error("Erreur lors de la récupération des commandes :", error);
                this.error = "Impossible de charger vos commandes.";
            } finally {
                this.isLoading = false;
            }
        },
        async logout() {
            const authStore = useAuthStore();
            await authStore.logout(); // Déconnecte via le store
            this.$router.push("/login"); // Redirige vers la page de connexion
        },
    },
    async mounted() {
        await this.fetchOrders(); // Charge les commandes au montage du composant
    },
};
</script>

<template>
    <div>
        <div v-if="userData" class="p-6 bg-gray-100 min-h-screen">
            <h1 class="text-2xl font-bold mb-4">Dashboard</h1>

            <!-- Informations utilisateur -->
            <div class="bg-white shadow-md rounded-lg p-6 mb-6">
                <h2 class="text-xl font-semibold mb-2">Vos informations</h2>
                <p class="text-gray-700"><strong>Nom :</strong> {{ userData.name }}</p>
                <p class="text-gray-700"><strong>Prénom :</strong> {{ userData.surname }}</p>
                <p class="text-gray-700"><strong>Email :</strong> {{ userData.email }}</p>
                <button @click="logout" class="mt-4 bg-red-500 text-white py-2 px-4 rounded hover:bg-red-600">
                    Logout
                </button>
            </div>

            <!-- Commandes passées -->
            <div class="bg-white shadow-md rounded-lg p-6">
                <h2 class="text-xl font-semibold mb-2">Vos commandes passées</h2>
                <div v-if="isLoading" class="text-gray-500">Chargement des commandes...</div>
                <div v-if="error" class="text-red-500">{{ error }}</div>
                <div v-else-if="orders.length === 0" class="text-gray-700">Aucune commande trouvée.</div>
                <div v-else class="space-y-8">
                    <div v-for="order in orders" :key="order.id" class="border-b pb-6">
                        <!-- Commande -->
                        <div class="flex justify-between items-center mb-4">
                            <h3 class="text-lg font-bold text-gray-800">Commande #{{ order.id }}</h3>
                            <p class="text-gray-600">
                                <strong>Date :</strong> {{ new Date(order.created_at).toLocaleDateString() }}
                            </p>
                        </div>
                        <p class="text-gray-700 mb-4">
                            <strong>Total :</strong> {{ order.total_price }}€
                        </p>

                        <!-- Produits -->
                        <div class="space-y-4">
                            <div v-for="product in order.cart.products" :key="product.id"
                                class="flex items-center bg-gray-50 p-4 rounded-lg shadow-sm">
                                <img :src="product.image" alt="Image produit"
                                    class="w-16 h-16 object-cover rounded-md mr-4" />
                                <div class="flex-grow">
                                    <h4 class="text-gray-800 font-semibold">{{ product.name }}</h4>
                                    <p class="text-sm text-gray-600">
                                        Quantité : x{{ product.pivot.quantity }} | Prix unitaire : {{ product.pivot.price
                                        }}€
                                    </p>
                                </div>
                                <p class="text-gray-800 font-bold">
                                    {{ (product.pivot.price * product.pivot.quantity).toFixed(2) }}€
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
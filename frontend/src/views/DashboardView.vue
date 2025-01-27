<script lang="ts">
import axios from "axios";
import { useAuthStore } from "../stores/auth";
import { ref, reactive, computed } from "vue";

axios.defaults.baseURL = "https://vapostore-projet.onrender.com";
axios.defaults.withCredentials = true;

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
    setup() {
        const orders = ref<Order[]>([]); // Liste des commandes
        const isLoading = ref(true); // Indicateur de chargement
        const error = ref<string | null>(null); // Gestion des erreurs
        const isOrderOpen = reactive<Record<number, boolean>>({}); // État d'ouverture des commandes

        const authStore = useAuthStore();
        const userData = computed(() => authStore.user);

        // Récupère les commandes
        const fetchOrders = async () => {
            try {
                const response = await axios.get("/api/orders");
                orders.value = response.data;

                // Initialise l'état d'ouverture pour chaque commande
                orders.value.forEach((order) => {
                    isOrderOpen[order.id] = false;
                });
            } catch (err) {
                console.error("Erreur lors de la récupération des commandes :", err);
                error.value = "Impossible de charger vos commandes.";
            } finally {
                isLoading.value = false;
            }
        };

        // Basculer les détails d'une commande
        const toggleOrderDetails = (orderId: number) => {
            isOrderOpen[orderId] = !isOrderOpen[orderId];
        };

        // Déconnecte l'utilisateur
        const logout = async () => {
            await authStore.logout();
            window.location.href = "/login";
        };

        fetchOrders();

        return {
            orders,
            isLoading,
            error,
            isOrderOpen,
            toggleOrderDetails,
            logout,
            userData,
        };
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
                <div v-else class="space-y-4">
                    <div
                        v-for="order in orders"
                        :key="order.id"
                        class="border border-gray-300 rounded-lg p-4 bg-gray-50"
                    >
                        <!-- Commande -->
                        <div
                            @click="toggleOrderDetails(order.id)"
                            class="flex justify-between items-center cursor-pointer"
                        >
                            <h3 class="text-lg font-bold text-gray-800">Commande #{{ order.id }}</h3>
                            <p class="text-gray-600">
                                <strong>Date :</strong> {{ new Date(order.created_at).toLocaleDateString() }}
                            </p>
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                class="h-6 w-6 text-gray-500"
                                :class="{'rotate-180': isOrderOpen[order.id]}"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke="currentColor"
                            >
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l7-7 7 7" />
                            </svg>
                        </div>

                        <!-- Détails de la commande -->
                        <div v-if="isOrderOpen[order.id]" class="mt-4 space-y-4">
                            <p class="text-gray-700">
                                <strong>Total :</strong> {{ order.total_price }}€
                            </p>
                            <div v-for="product in order.cart.products" :key="product.id" class="flex items-center">
                                <img :src="product.image" alt="Image produit" class="w-12 h-12 object-cover rounded-md mr-4" />
                                <div>
                                    <h4 class="text-gray-800 font-semibold">{{ product.name }}</h4>
                                    <p class="text-sm text-gray-600">
                                        Quantité : x{{ product.pivot.quantity }} | Prix unitaire : {{ product.pivot.price }}€
                                    </p>
                                </div>
                                <p class="ml-auto text-gray-800 font-bold">
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

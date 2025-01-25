<script>
import axios from "axios";
import { useAuthStore } from "../stores/auth";

axios.defaults.baseURL = "http://localhost:8000";
axios.defaults.withCredentials = true;

export default {
    computed: {
        userData() {
            const authStore = useAuthStore();
            return authStore.user; // Utilise les données utilisateur depuis Pinia
        },
    },
    methods: {
        async logout() {
            const authStore = useAuthStore();
            await authStore.logout(); // Déconnecte via le store
            this.$router.push("/login"); // Redirige vers la page de connexion
        },
    },
};
</script>

<template>
    <div>
        <div v-if="userData" class="p-6 bg-gray-100 min-h-screen">
            <h1 class="text-2xl font-bold mb-4">Dashboard</h1>
            <div class="bg-white shadow-md rounded-lg p-6">
                <h2 class="text-xl font-semibold mb-2">Vos informations</h2>
                <p class="text-gray-700"><strong>Nom:</strong> {{ userData.name }}</p>
                <p class="text-gray-700"><strong>Prénom:</strong> {{ userData.surname }}</p>
                <p class="text-gray-700"><strong>Email:</strong> {{ userData.email }}</p>
                <button @click="logout" class="mt-4 bg-red-500 text-white py-2 px-4 rounded hover:bg-red-600">
                    Logout
                </button>
            </div>
        </div>
    </div>
</template>
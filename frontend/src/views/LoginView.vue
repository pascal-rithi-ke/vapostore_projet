<script>
import axios from "axios";
import { useAuthStore } from "../stores/auth"; // Importer le store auth
import { getCsrfToken } from '../utils/fct.ts';

axios.defaults.baseURL = "https://vapostore-projet.onrender.com";
axios.defaults.withCredentials = true;

export default {
    data() {
        return {
            email: "",
            password: "",
            errorMessage: "",
        };
    },
    methods: {
        async handleSubmit() {
            const authStore = useAuthStore(); // Accéder au store Pinia
            try {
                await getCsrfToken();
                // Effectuer la requête de connexion
                await axios.post("/api/login", {
                    email: this.email,
                    password: this.password,
                });

                // Mettre à jour l'état d'authentification dans Pinia
                await authStore.fetchAuthStatus();

                // Rediriger vers le tableau de bord
                this.$router.push("/dashboard");
            } catch (error) {
                if (axios.isAxiosError(error)) {
                    this.errorMessage = error.response?.data?.message || "Erreur de connexion";
                } else {
                    this.errorMessage = "Erreur de connexion";
                }
            }
        },
    },
};
</script>

<template>
    <div class="flex items-center justify-center min-h-screen bg-gray-100">
        <!-- Formulaire -->
        <div class="w-full max-w-md p-8 space-y-6 bg-white rounded shadow-md mx-4 sm:mx-8 lg:mx-8">
            <h1 class="text-2xl font-bold text-center text-gray-700">Connectez-vous</h1>
            <form @submit.prevent="handleSubmit" class="space-y-4">
                <div>
                    <label for="email" class="block text-sm text-gray-800 font-semibold">Email<span
                            class="text-red-700">*</span></label>
                    <input type="email" id="email" v-model="email" placeholder="Entrer votre email"
                        class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500"
                        required />
                </div>
                <div>
                    <label for="password" class="block text-sm text-gray-800 font-semibold">Mot de passe<span
                            class="text-red-700">*</span></label>
                    <input type="password" id="password" placeholder="Entrer votre mot de passe" v-model="password"
                        class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500"
                        required />
                </div>
                <button type="submit"
                    class="w-full px-4 py-2 text-white bg-primary rounded-md hover:bg-secondary focus:outline-none focus:ring focus:ring-blue-300">
                    Se connecter
                </button>
            </form>
            <p class="text-sm text-center hover:text-secondary">
                <router-link to="/register">
                    Pas encore de compte ? Inscrivez-vous
                </router-link>
            </p>
        </div>
    </div>
</template>

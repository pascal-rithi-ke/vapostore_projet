<script lang="ts">
import axios from "axios";

export default {
    data() {
        return {
            name: "",
            surname: "",
            email: "",
            password: "",
            confirmPassword: "",
            showPopup: false, // Contrôle l'affichage de la popup
            popupMessage: "", // Message à afficher dans la popup
            popupType: "success" as "success" | "error", // Type de popup : "success" ou "error"
        };
    },
    methods: {
        handleSubmit() {
            if (this.password !== this.confirmPassword) {
                this.showPopupMessage("Les mots de passe ne correspondent pas", "error");
                return;
            }

            axios
                .post("/api/register", {
                    name: this.name,
                    surname: this.surname,
                    email: this.email,
                    password: this.password,
                    password_confirmation: this.confirmPassword,
                })
                .then(() => {
                    this.showPopupMessage("Inscription réussie ! Vous serez redirigé vers la page de connexion.", "success");
                    setTimeout(() => {
                        this.$router.push("/login");
                    }, 3000); // Redirection après 3 secondes
                })
                .catch((error) => {
                    if (axios.isAxiosError(error)) {
                        this.showPopupMessage(error.response?.data?.message || "Erreur d'inscription", "error");
                    } else {
                        this.showPopupMessage("Erreur d'inscription", "error");
                    }
                });
        },
        showPopupMessage(message: string, type: "success" | "error") {
            this.popupMessage = message;
            this.popupType = type;
            this.showPopup = true;

            // Ferme la popup automatiquement après 3 secondes
            setTimeout(() => {
                this.showPopup = false;
            }, 3000);
        },
    },
};
</script>

<template>
    <div class="flex items-center justify-center min-h-screen bg-gray-100">
        <div class="w-full max-w-md p-8 space-y-6 bg-white rounded shadow-md mx-4 sm:mx-6 lg:mx-8">
            <h1 class="text-2xl font-bold text-center text-gray-700">Inscrivez-vous</h1>
            <form @submit.prevent="handleSubmit" class="space-y-4">
                <div>
                    <label for="surname" class="block text-sm text-gray-800 font-semibold">Nom<span class="text-red-700">*</span></label>
                    <input type="text" id="surname" v-model="surname" placeholder="Entrer votre nom"
                        class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500"
                        required />
                </div>
                <div>
                    <label for="name" class="block text-sm text-gray-800 font-semibold">Prénom<span class="text-red-700">*</span></label>
                    <input type="text" id="name" v-model="name" placeholder="Entrer votre prénom"
                        class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500"
                        required />
                </div>
                <div>
                    <label for="email" class="block text-sm text-gray-800 font-semibold">Email<span class="text-red-700">*</span></label>
                    <input type="email" id="email" v-model="email" placeholder="Entrer votre email"
                        class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500"
                        required />
                </div>
                <div>
                    <label for="password" class="block text-sm text-gray-800 font-semibold">Mot de passe<span class="text-red-700">*</span></label>
                    <input type="password" id="password" v-model="password" placeholder="Entrer votre mot de passe"
                        class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500"
                        required />
                </div>
                <div>
                    <label for="confirmPassword" class="block text-sm text-gray-800 font-semibold">Confirmer le mot de passe<span class="text-red-700">*</span></label>
                    <input type="password" id="confirmPassword" v-model="confirmPassword"
                        placeholder="Confirmer votre mot de passe"
                        class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500"
                        required />
                </div>
                <button type="submit"
                    class="w-full px-4 py-2 text-white bg-primary rounded-md hover:bg-secondary focus:outline-none focus:ring focus:ring-blue-300">
                    Inscription
                </button>
            </form>
            <p class="text-sm text-center hover:text-secondary">
                <router-link to="/login">
                    Vous avez déjà un compte ? Connectez-vous
                </router-link>
            </p>
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
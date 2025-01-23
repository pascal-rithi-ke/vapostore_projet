<script lang="ts">
export default {
    data() {
        return {
            name: "",
            surname: "",
            email: "",
            password: "",
            confirmPassword: "",
        };
    },
    methods: {
        handleSubmit() {
            if (this.password !== this.confirmPassword) {
                alert("Passwords do not match!");
                return;
            }
            console.log("Name:", this.name);
            console.log("Surname:", this.surname);
            console.log("Email:", this.email);
            console.log("Password:", this.password);
            // Ajoute ici la logique pour gérer l'inscription
        },
    },
};
</script>

<template>
    <div class="flex items-center justify-center min-h-screen bg-gray-100">
        <div class="w-full max-w-md p-8 space-y-6 bg-white rounded shadow-md">
            <h1 class="text-2xl font-bold text-center text-gray-700">Inscrivez vous</h1>
            <form @submit.prevent="handleSubmit" class="space-y-4">
                <div>
                    <label for="surname" class="block text-sm text-gray-800 font-semibold">Nom<span class="text-red-700">*</span></label>
                    <input type="text" id="name" v-model="name" placeholder="Entrer votre nom"
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
                    inscription
                </button>
            </form>
            <p class="text-sm text-center hover:text-secondary">
                <router-link to="/login">
                    Vous avez déjà un compte ? Connectez-vous
                </router-link>
            </p>
        </div>
    </div>
</template>
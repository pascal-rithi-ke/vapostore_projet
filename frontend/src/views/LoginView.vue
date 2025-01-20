<script>
export default {
    data() {
        return {
            email: "",
            password: "",
        };
    },
    methods: {
        handleSubmit() {
            console.log("Email:", this.email);
            console.log("Password:", this.password);
            // Ajoute ici la logique pour gérer la soumission
        },
    },
};
</script>

<template>
    <div class="flex items-center justify-center min-h-screen bg-gray-100">
        <div class="w-full max-w-md p-8 space-y-6 bg-white rounded shadow-md">
            <h1 class="text-2xl font-bold text-center text-gray-700">Connectez-vous</h1>
            <form @submit.prevent="handleSubmit" class="space-y-4">
                <div>
                    <label for="email" class="block text-sm font-medium text-gray-600">Email</label>
                    <input type="email" id="email" v-model="email" placeholder="Entrer votre email"
                        class="w-full px-4 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:ring focus:ring-blue-300 focus:border-blue-500"
                        required />
                </div>
                <div>
                    <label for="password" class="block text-sm font-medium text-gray-600">Mot de passe</label>
                    <input type="password" id="password" v-model="password" placeholder="Entrer votre mot de passe"
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
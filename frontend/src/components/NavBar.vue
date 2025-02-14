<script>
import Annonce from '../components/Annonce.vue';
import { ref, computed } from 'vue';
import { useAuthStore } from '../stores/auth.js';

export default {
    components: {
        Annonce,
    },

    setup() {
        const authStore = useAuthStore();

        const menuOpen = ref(false);
        const accountLink = computed(() => (authStore.isAuthenticated ? '/dashboard' : '/login'));

        return { authStore, accountLink, menuOpen };
    },
};
</script>

<template>
    <nav class="z-50 relative bg-white shadow-md">
        <div class="container mx-auto px-4 flex items-center justify-between h-16">
            <!-- Logo -->
            <router-link to="/">
                <div class="flex items-center">
                    <img src="../assets/logo.png" alt="Logo" class="h-8 mr-3" />
                </div>
            </router-link>

            <!-- Desktop Navigation -->
            <div class="hidden lg:flex items-center space-x-5 w-full">
                <!-- Barre de recherche -->
                <div class="flex-grow">
                    <input type="text" placeholder="Rechercher un produit"
                        class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:outline-none" />
                </div>
                <!-- Liens de navigation -->
                <ul class="flex items-center space-x-5">
                    <li class="group relative">
                        <button class="flex items-center">
                            Produits et services
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1" viewBox="0 0 20 20"
                                fill="currentColor">
                                <path fill-rule="evenodd"
                                    d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 011.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                    clip-rule="evenodd" />
                            </svg>
                        </button>
                        <ul class="absolute left-0 hidden w-40 bg-white shadow-md rounded-md group-hover:block">
                            <li><a href="#" class="block px-4 py-2 hover:bg-gray-100">E-Cigarettes</a></li>
                            <li><a href="#" class="block px-4 py-2 hover:bg-gray-100">E-Liquides</a></li>
                            <li><a href="#" class="block px-4 py-2 hover:bg-gray-100">Matériel</a></li>
                            <li><a href="#" class="block px-4 py-2 hover:bg-gray-100">DIY</a></li>
                            <li><a href="#" class="block px-4 py-2 hover:bg-gray-100">Accessoires</a></li>
                        </ul>
                    </li>
                    <li><router-link to="/presentation" class="hover:text-blue-500">À propos</router-link></li>
                </ul>
                <router-link :to="accountLink">
                    <button class="flex items-center">
                        <svg class="fill-gray-500 hover:fill-gray-700" width="30px" height="30px" viewBox="0 0 24 24"
                            xmlns="http://www.w3.org/2000/svg">
                            <circle fill="none" cx="12" cy="7" r="3" />
                            <path
                                d="M12 2C9.243 2 7 4.243 7 7s2.243 5 5 5 5-2.243 5-5-2.243-5-5-5zm0 8c-1.654 0-3-1.346-3-3s1.346-3 3-3 3 1.346 3 3-1.346 3-3 3zm9 11v-1c0-3.859-3.141-7-7-7h-4c-3.86 0-7 3.141-7 7v1h2v-1c0-2.757 2.243-5 5-5h4c2.757 0 5 2.243 5 5v1h2z" />
                        </svg>
                    </button>
                </router-link>
                <router-link v-if="authStore.isAuthenticated" to="/cart">
                    <button class="flex items-center relative">
                        <svg class="fill-gray-500 hover:fill-gray-700" width="32px" height="32px" viewBox="0 0 24 24"
                            fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd"
                                d="M14.3999 3.2C14.8417 2.86863 15.4685 2.95817 15.7999 3.4L18.4999 7H18.5031C20.3417 7 21.7478 8.6389 21.4682 10.4562L20.3913 17.4562C20.1661 18.9197 18.9069 20 17.4261 20H6.57366C5.09295 20 3.8337 18.9197 3.60855 17.4562L2.53162 10.4562C2.25204 8.63889 3.65808 7 5.49674 7H5.4999L8.1999 3.4C8.53127 2.95817 9.15808 2.86863 9.5999 3.2C10.0417 3.53137 10.1313 4.15817 9.7999 4.6L7.9999 7H15.9999L14.1999 4.6C13.8685 4.15817 13.9581 3.53137 14.3999 3.2ZM5.98825 9C5.99551 9.00008 6.00277 9.00008 6.01002 9H17.9898H18.0116H18.5031C19.116 9 19.5846 9.5463 19.4914 10.1521L18.4145 17.1521C18.3395 17.6399 17.9197 18 17.4261 18H6.57366C6.08009 18 5.66034 17.6399 5.58529 17.1521L4.50837 10.1521C4.41517 9.5463 4.88385 9 5.49674 9H5.98825Z" />
                        </svg>
                        <!-- Affiche le nombre d'item
                        <span
                            class="absolute top-0 right-0 transform translate-x-1/2 -translate-y-1/2 bg-red-500 text-white text-xs font-bold rounded-full w-5 h-5 flex items-center justify-center">
                            2
                        </span>
                        -->
                    </button>
                </router-link>
            </div>

            <div class="flex items-center justify-between">
                <!-- Panier -->
                <router-link v-if="authStore.isAuthenticated" to="/cart" class="lg:hidden mr-2">
                    <button class="flex items-center relative">
                        <svg class="fill-gray-500 hover:fill-gray-700" width="32px" height="32px" viewBox="0 0 24 24"
                            fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd"
                                d="M14.3999 3.2C14.8417 2.86863 15.4685 2.95817 15.7999 3.4L18.4999 7H18.5031C20.3417 7 21.7478 8.6389 21.4682 10.4562L20.3913 17.4562C20.1661 18.9197 18.9069 20 17.4261 20H6.57366C5.09295 20 3.8337 18.9197 3.60855 17.4562L2.53162 10.4562C2.25204 8.63889 3.65808 7 5.49674 7H5.4999L8.1999 3.4C8.53127 2.95817 9.15808 2.86863 9.5999 3.2C10.0417 3.53137 10.1313 4.15817 9.7999 4.6L7.9999 7H15.9999L14.1999 4.6C13.8685 4.15817 13.9581 3.53137 14.3999 3.2ZM5.98825 9C5.99551 9.00008 6.00277 9.00008 6.01002 9H17.9898H18.0116H18.5031C19.116 9 19.5846 9.5463 19.4914 10.1521L18.4145 17.1521C18.3395 17.6399 17.9197 18 17.4261 18H6.57366C6.08009 18 5.66034 17.6399 5.58529 17.1521L4.50837 10.1521C4.41517 9.5463 4.88385 9 5.49674 9H5.98825Z" />
                        </svg>
                    </button>
                </router-link>

                <!-- Burger Icon -->
                <button v-if="!menuOpen" @click="menuOpen = true" class="lg:hidden text-gray-700 focus:outline-none">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                        stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M4 6h16M4 12h16m-7 6h7" />
                    </svg>
                </button>
            </div>
        </div>

        <!-- Fullscreen Mobile Menu -->
        <div v-if="menuOpen"
            class="fixed inset-0 bg-black bg-opacity-90 flex flex-col justify-center items-center text-white z-50">
            <button @click="menuOpen = false" class="absolute top-6 right-6 text-white text-3xl focus:outline-none">
                ✕
            </button>
            <ul class="text-center space-y-8 text-2xl">
                <li>
                    <router-link @click="menuOpen = false" to="/" class="hover:underline">Accueil</router-link>
                </li>
                <li>
                    <router-link @click="menuOpen = false" to="/presentation" class="hover:underline">À
                        propos</router-link>
                </li>
                <li>
                    <router-link @click="menuOpen = false" :to="accountLink" class="hover:underline">
                        Mon Compte
                    </router-link>
                </li>
            </ul>
        </div>
    </nav>
    <Annonce />
</template>

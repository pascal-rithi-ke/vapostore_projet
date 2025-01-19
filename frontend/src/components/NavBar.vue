<script setup lang="ts">
import Annonce from '../components/Annonce.vue';
</script>

<template>
    <nav class="z-50 relative">
        <div class="container mx-auto px-4 flex items-center justify-between h-16">
            <!-- Logo -->
            <router-link to="/">
                <div class="flex items-center">
                    <img src="../assets/logo.png" alt="Logo" class="h-8 mr-3" />
                </div>
            </router-link>

            <!-- Search Bar -->
            <div class="hidden md:flex items-center space-x-2">
                <input type="text" placeholder="Rechercher un produit"
                    class="px-4 py-2 border border-gray-300 rounded-full w-96 focus:outline-none focus:ring focus:ring-blue-300" />
                <button class="text-gray-500 hover:text-gray-700">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd"
                            d="M12.9 14.32a8 8 0 111.414-1.414l4.387 4.386a1 1 0 01-1.414 1.414l-4.387-4.386zM8 14a6 6 0 100-12 6 6 0 000 12z"
                            clip-rule="evenodd" />
                    </svg>
                </button>
            </div>

            <!-- Navigation Links -->
            <ul class="hidden md:flex items-center space-x-6 text-gray-700 font-medium">
                <li class="group relative">
                    <button class="flex items-center">
                        Nos Produits et services
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1" viewBox="0 0 20 20"
                            fill="currentColor">
                            <path fill-rule="evenodd"
                                d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 011.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                clip-rule="evenodd" />
                        </svg>
                    </button>
                    <!-- Dropdown Menu -->
                    <ul class="absolute left-0 mt-2 hidden w-40 bg-white shadow-md rounded-md group-hover:block">
                        <li><a href="#" class="block px-4 py-2 hover:bg-gray-100">E-Cigarettes</a></li>
                        <li><a href="#" class="block px-4 py-2 hover:bg-gray-100">E-Liquides</a></li>
                        <li><a href="#" class="block px-4 py-2 hover:bg-gray-100">Matériel</a></li>
                        <li><a href="#" class="block px-4 py-2 hover:bg-gray-100">DIY</a></li>
                        <li><a href="#" class="block px-4 py-2 hover:bg-gray-100">Accessoires</a></li>
                    </ul>
                </li>
                <li class="group relative">
                    <button class="flex items-center">
                        Information
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1" viewBox="0 0 20 20"
                            fill="currentColor">
                            <path fill-rule="evenodd"
                                d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 011.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                clip-rule="evenodd" />
                        </svg>
                    </button>
                    <!-- Dropdown Menu -->
                    <ul class="absolute left-0 mt-2 hidden w-44 bg-white shadow-md rounded-md group-hover:block">
                        <li><router-link to="/presentation" class="block px-4 py-2 hover:bg-gray-100">Qui sommes nous ?</router-link></li>
                        <li><a href="#" class="block px-4 py-2 hover:bg-gray-100">Ouvrir un Vapostore</a></li>
                    </ul>
                </li>
            </ul>

            <!-- Account and Cart Icons -->
            <div class="flex items-center space-x-4">
                <router-link to="/login">
                    <button class="text-gray-500 hover:text-gray-700 flex items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" viewBox="0 0 20 20" fill="currentColor">
                            <path
                                d="M10 2a6 6 0 00-6 6v1.586l-.707.707a1 1 0 000 1.414l1.414 1.414a1 1 0 001.414 0L6 12.414V8a4 4 0 118 0v4.414l.293.293a1 1 0 001.414 0l1.414-1.414a1 1 0 000-1.414L16 9.586V8a6 6 0 00-6-6z" />
                        </svg>
                        <span class="ml-1 hidden md:inline">Compte</span>
                    </button>
                </router-link>
                <router-link to="/cart">
                    <button class="text-gray-500 hover:text-gray-700 flex items-center relative">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" viewBox="0 0 20 20" fill="currentColor">
                        <path
                        d="M6 2a1 1 0 000 2h1.293l.7 3.356a5.002 5.002 0 001.262 8.995l.223-.004a5 5 0 004.781-3.617l.259-1.036a1 1 0 00-.983-1.257H8a1 1 0 010-2h5.025a7.002 7.002 0 00-2.432-4.535l-.085-.07-.595-.496-.635-.526H6zm5 11a3 3 0 110-6 3 3 0 010 6z" />
                    </svg>
                    <span class="ml-1 hidden md:inline">Panier</span>
                    <span
                        class="absolute top-0 right-0 transform translate-x-1/2 -translate-y-1/2 bg-red-500 text-white text-xs font-bold rounded-full w-5 h-5 flex items-center justify-center">
                        2
                    </span>
                    </button>
                </router-link>
            </div>
        </div>
    </nav>
    <Annonce/>
</template>
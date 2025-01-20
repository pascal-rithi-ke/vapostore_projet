<script setup lang="ts">
import Annonce from '../components/Annonce.vue';

import UserLoginSVG from "../assets/user-login.svg?raw";
import CartShopSVG from "../assets/cart-shopping.svg?raw";
</script>

<template>
    <nav class="z-50 relative">
        <div class="container mx-auto px-4 flex items-center justify-between h-16 relative">
            <!-- Logo -->
            <router-link to="/">
                <div class="flex items-center">
                    <img src="../assets/logo.png" alt="Logo" class="h-8 mr-3" />
                </div>
            </router-link>

            <!-- Search Bar -->
            <div class="absolute inset-x-0 mx-auto flex items-center space-x-2 w-max">
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

            <!-- Navigation Links and Icons -->
            <div class="flex items-center space-x-5 text-gray-700 font-medium">
                <ul class="flex items-center space-x-5">
                    <li class="group relative">
                        <button class="flex items-center">
                            Produits et serivces
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1" viewBox="0 0 20 20"
                                fill="currentColor">
                                <path fill-rule="evenodd"
                                    d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 011.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                    clip-rule="evenodd" />
                            </svg>
                        </button>
                        <!-- Dropdown Menu -->
                        <ul
                            class="absolute left-0 mt-2 hidden w-40 bg-white shadow-md rounded-md group-hover:block">
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
                        <ul
                            class="absolute left-0 mt-2 hidden w-44 bg-white shadow-md rounded-md group-hover:block">
                            <li><router-link to="/presentation"
                                    class="block px-4 py-2 hover:bg-gray-100">Qui sommes nous ?</router-link></li>
                            <li><a href="#" class="block px-4 py-2 hover:bg-gray-100">Ouvrir un Vapostore</a></li>
                        </ul>
                    </li>
                </ul>

                <!-- Account and Cart Icons -->
                <router-link to="/login">
                    <button class="flex items-center">
                        <div v-html="UserLoginSVG"></div>
                    </button>
                </router-link>
                <router-link to="/cart">
                    <button class="flex items-center relative">
                        <div v-html="CartShopSVG"></div>
                        <!-- Affiche le nombre d'item -->
                        <span
                            class="absolute top-0 right-0 transform translate-x-1/2 -translate-y-1/2 bg-red-500 text-white text-xs font-bold rounded-full w-5 h-5 flex items-center justify-center">
                            2
                        </span>
                    </button>
                </router-link>
            </div>
        </div>
    </nav>
    <Annonce />
</template>
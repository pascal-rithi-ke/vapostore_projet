<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import axios from 'axios';

import normalizeName from '../utils/fct';

// Interface pour représenter un produit
interface Product {
    id: number;
    name: string;
    description: string;
    price: number;
    image: string;
}

// Liste des produits et états
const products = ref<Product[]>([]);
const categoryName = ref<string>('');
const loading = ref<boolean>(true); // État de chargement

const route = useRoute();

// Fonction pour récupérer les produits d'une catégorie
const fetchProducts = async () => {
    const { id, name } = route.params;
    categoryName.value = typeof name === 'string' ? name.replace(/_/g, ' ') : 'Inconnue'; // Transforme les underscores en espaces
    loading.value = true; // Début du chargement
    try {
        const response = await axios.get(`/api/products/type/${id}`);
        products.value = response.data;
    } catch (error) {
        console.error('Erreur lors du chargement des produits :', error);
    } finally {
        loading.value = false; // Fin du chargement
    }
};

// Charger les produits au montage
onMounted(fetchProducts);
</script>

<template>
    <div class="container mx-auto px-4 sm:px-6 lg:px-8 my-8">
        <!-- Breadcrumb -->
        <nav class="mb-4 text-sm text-gray-600">
            <router-link to="/" class="hover:underline">Accueil</router-link>
            <span class="mx-2">/</span>
            <span class="font-bold">{{ categoryName }}</span>
        </nav>

        <!-- Titre de la catégorie -->
        <h2 class="text-2xl sm:text-3xl font-bold mb-4 text-center sm:text-left">
            Nos Produits de la catégorie "{{ categoryName }}"
        </h2>

        <!-- Chargement -->
        <div v-if="loading" class="text-center">
            <p>Chargement des produits...</p>
        </div>

        <!-- Liste des produits -->
        <div v-else-if="products.length" class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-6">
            <div v-for="product in products" :key="product.id" class="bg-white text-center shadow-md rounded-lg p-4">
                <router-link :to="{
                    path: `/produit/${product.id}/name/${normalizeName(product.name)}`,
                    query: {
                        categoryId: route.params.id,
                        categoryName: route.params.name
                    }
                }">
                    <img
                        :src="product.image"
                        :alt="product.name"
                        class="w-full h-40 object-cover rounded-lg"
                    />
                    <h3 class="text-lg font-bold mt-2">{{ product.name }}</h3>
                    <p class="text-primary text-2xl font-bold mt-4">{{ product.price }} €</p>
                </router-link>
            </div>
        </div>

        <!-- Message si aucun produit n'est disponible -->
        <div v-else>
            <p class="text-gray-600 text-center">
                Désolé, nous n'avons actuellement pas de produits pour cette catégorie.
            </p>
        </div>
    </div>
</template>

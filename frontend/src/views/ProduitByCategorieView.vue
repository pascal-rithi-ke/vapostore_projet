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
    <div class="container mx-auto my-8">
        <nav class="mb-4 text-sm text-gray-600">
            <router-link to="/" class="hover:underline">Accueil</router-link>
            <span class="mx-2">/</span>
            <span class="font-bold">{{ categoryName }}</span>
        </nav>

        <h2 class="text-2xl font-bold mb-4">Nos Produits de la catégorie "{{ categoryName }}"</h2>

        <div v-if="loading" class="text-center">
            <p>Chargement des produits...</p>
        </div>

        <div v-else-if="products.length" class="flex flex-wrap gap-6">
            <div v-for="product in products" :key="product.id" class="bg-white text-center shadow-md rounded-lg w-64 p-4">
                <router-link :to="{
                    path: `/produit/${product.id}/name/${normalizeName(product.name)}`,
                    query: {
                        categoryId: route.params.id,
                        categoryName: route.params.name
                    }
                }">
                <img :src="product.image" :alt="product.name" class="w-full h-32 object-cover rounded-lg" />
                <h3 class="text-lg font-bold">{{ product.name }}</h3>
                <p class="text-primary text-2xl font-bold mt-4">{{ product.price }} €</p>
                </router-link>
            </div>
        </div>

        <div v-else>
            <p class="text-gray-600">Désolé, nous n'avons actuellement pas de produits pour cette catégorie.</p>
        </div>
    </div>
</template>

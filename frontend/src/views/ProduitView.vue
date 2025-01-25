<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import axios from 'axios';

interface Product {
    id: number;
    name: string;
    description: string;
    price: number;
    image: string;
}

const product = ref<Product | null>(null);
const loading = ref<boolean>(true);

const route = useRoute();

const fetchProduct = async () => {
    const { id } = route.params; // Récupère l'ID depuis la route
    loading.value = true; // Début du chargement
    try {
        const response = await axios.get(`/api/products/${id}`); // Appel API
        product.value = response.data; // Mise à jour des données
    } catch (error) {
        console.error('Erreur lors du chargement du produit :', error);
    } finally {
        loading.value = false; // Fin du chargement
    }
};

onMounted(fetchProduct);
</script>

<template>
    <div class="container mx-auto my-8">
        <!-- Indicateur de chargement -->
        <div v-if="loading" class="text-center">
            <p>Chargement en cours...</p>
        </div>

        <!-- Affichage des données du produit -->
        <div v-else-if="product">
            <img :src="product.image" :alt="product.name" class="w-64 h-64 object-cover rounded-lg" />
            <h2 class="text-2xl font-bold mb-4">{{ product.name }}</h2>
            <p>{{ product.description }}</p>
            <p class="text-primary text-2xl font-bold mt-4">{{ product.price }} €</p>
        </div>

        <!-- Message si le produit n'est pas trouvé -->
        <div v-else>
            <p>Produit non trouvé.</p>
        </div>
    </div>
</template>


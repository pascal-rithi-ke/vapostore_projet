<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import axios from 'axios';

interface Product {
    name: string;
    description: string;
    price: number;
    image: string;
}

const product = ref<Product | null>(null);
const route = useRoute();

const fetchProduct = async () => {
    const { id } = route.params;
    try {
        const response = await axios.get(`/api/products/${id}`);
        product.value = response.data;
    } catch (error) {
        console.error('Erreur lors du chargement du produit :', error);
    }
};

onMounted(fetchProduct);
</script>

<template>
    <div class="container mx-auto my-8">
        <div v-if="product">
            <img :src="product.image" :alt="product.name" class="w-80 h-80 object-cover rounded-lg shadow-md mx-auto" />
            <h2 class="text-2xl font-bold mb-4">{{ product.name }}</h2>
            <p>{{ product.description }}</p>
            <p class="text-primary text-2xl font-bold mt-4">{{ product.price }} €</p>
        </div>
        <p v-else>Produit non trouvé.</p>
    </div>
</template>

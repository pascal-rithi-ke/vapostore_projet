<script setup lang="ts">
import normalizeName from '../utils/fct';
import axios from 'axios';
import { ref, onMounted } from 'vue';

axios.defaults.baseURL = 'https://vapostore-projet.onrender.com';
axios.defaults.withCredentials = true;

interface Product {
  id: number;
  libelle: string;
  description: string;
  image: string;
}

const products = ref<Product[]>([]);

onMounted(async () => {
  try {
    const response = await axios.get('/api/type-products');
    products.value = response.data;
  } catch (error) {
    console.error('Error fetching products:', error);
  }
});

</script>

<template>
  <div class="container mx-auto my-8">
    <div class="text-left">
      <h2 class="text-2xl font-bold">Nos différents produits et services</h2>
      <div class="w-32 h-1 bg-secondary mt-2"></div>
    </div>
    <div class="flex flex-wrap justify-center gap-6 mt-8">
      <div v-for="(product, index) in products" :key="index" class="flex flex-col items-center">
        <router-link class="bg-white shadow-md rounded-lg overflow-hidden w-80" :to="`/produit/categorie/${product.id}/${normalizeName(product.libelle)}`">
          <img :src="product.image" :alt="product.libelle" class="w-full h-48 object-cover" />
          <div class="p-4 text-center">
            <h3 class="text-lg font-bold mb-2">{{ product.libelle }}</h3>
            <p class="text-gray-600">{{ product.description }}</p>
          </div>
        </router-link>
      </div>
    </div>
  </div>
</template>
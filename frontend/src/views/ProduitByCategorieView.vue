<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import axios from 'axios';

// Interface pour représenter un produit
interface Product {
    id: number;
    name: string;
    description: string;
    price: number;
    image: string;
}

// Liste des produits de la catégorie
const products = ref<Product[]>([]);

// Nom de la catégorie
const categoryName = ref<string>('');

// Accès à la route actuelle
const route = useRoute();

// Fonction pour récupérer les produits d'une catégorie
const fetchProducts = async () => {
    const { id } = route.params; // ID de la catégorie
    categoryName.value = (route.query.name as string) || "Inconnue"; // Nom de la catégorie, avec un fallback
    try {
        const response = await axios.get(`/api/products/type/${id}`); // Appel API
        products.value = response.data; // Mise à jour des produits
    } catch (error) {
        console.error('Erreur lors du chargement des produits :', error);
    }
};

// Charger les produits au montage du composant
onMounted(fetchProducts);
</script>

<template>
    <div class="container mx-auto my-8">
        <h2 class="text-2xl font-bold mb-4">Nos Produits de la catégorie "{{ categoryName }}"</h2>
        <!-- Liste des produits -->
        <div v-if="products.length" class="flex flex-wrap gap-6">
            <div v-for="product in products" :key="product.id" class="bg-white shadow-md rounded-lg w-64 p-4">
                <img :src="product.image" :alt="product.name" class="w-full h-32 object-cover rounded-lg" />
                <h3 class="text-lg font-bold">{{ product.name }}</h3>
                <router-link :to="`/produit/${product.id}`">
                    <button class="mt-4 px-4 py-2 bg-primary text-white rounded-lg hover:bg-secondary">
                        Voir plus
                    </button>
                </router-link>
                <p class="text-primary text-2xl font-bold mt-4">{{ product.price }} €</p>
            </div>
        </div>

        <!-- Message si aucun produit n'est trouvé -->
        <div v-else>
            <p class="text-gray-600">Désolé, nous n'avons actuellement pas de produits pour cette catégorie.</p>
        </div>
    </div>
</template>

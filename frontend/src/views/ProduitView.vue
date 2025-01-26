<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
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
const quantity = ref<number>(1);

const route = useRoute();
const router = useRouter();

const fetchProduct = async () => {
    const { id } = route.params; // Récupère l'ID du produit
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

const goBack = () => {
    router.go(-1); // Retourne à la page précédente
};

const addToCart = async () => {
    if (!product.value) return;

    try {
        await axios.post('/api/add-product', {
            product_id: product.value.id,
            quantity: quantity.value,
            price: product.value.price, // Assurez-vous que le produit a un champ 'price'
        });
        alert(`Produit ajouté au panier : ${product.value.name}`);
    } catch (error) {
        console.error('Erreur lors de l\'ajout au panier :', error);
        const errorMessage = (error as any).response?.data?.message || 'Impossible d\'ajouter le produit au panier.';
        alert(errorMessage);
    }
};

onMounted(fetchProduct);
</script>

<template>
    <div class="container mx-auto my-8">
        <!-- Fil d'Ariane -->
        <nav class="mb-4 text-sm text-gray-600">
            <router-link to="/" class="hover:underline">Accueil</router-link>
            <span class="mx-2">/</span>
            <router-link 
                :to="`/produit/categorie/${route.query.categoryId}/${route.query.categoryName}`" 
                class="hover:underline"
            >
                {{ typeof route.query.categoryName === 'string' ? route.query.categoryName.replace(/_/g, ' ') : 'Catégorie' }}
            </router-link>
            <span class="mx-2">/</span>
            <span class="font-bold">{{ product?.name || 'Produit' }}</span>
        </nav>

        <!-- Bouton Retour -->
        <button
            @click="goBack"
            class="mb-6 px-4 py-2 bg-gray-200 text-gray-800 rounded-lg shadow hover:bg-gray-300 focus:ring focus:ring-gray-300"
        >
            Retour
        </button>

        <!-- Indicateur de chargement -->
        <div v-if="loading" class="text-center">
            <p class="text-lg font-medium">Chargement en cours...</p>
        </div>

        <!-- Affichage des données du produit -->
        <div v-else-if="product" class="max-w-4xl mx-auto p-6 bg-white rounded-lg shadow-md">
            <div class="flex flex-col md:flex-row gap-6">
                <img :src="product.image" :alt="product.name" class="w-full md:w-64 h-64 object-cover rounded-lg" />

                <div class="flex-1">
                    <h2 class="text-3xl font-bold mb-4">{{ product.name }}</h2>
                    <p class="text-gray-700 mb-4">{{ product.description }}</p>
                    <p class="text-primary text-2xl font-bold">{{ product.price }} €</p>

                    <div class="mt-6 flex items-center gap-4">
                        <label for="quantity" class="text-sm font-medium">Quantité :</label>
                        <input 
                            id="quantity" 
                            type="number" 
                            v-model.number="quantity" 
                            min="1" 
                            class="w-20 p-2 border rounded-lg focus:ring focus:ring-primary-300" 
                        />
                        <button 
                            @click="addToCart" 
                            class="px-6 py-3 bg-primary text-white font-medium rounded-lg shadow hover:bg-primary-600 focus:ring focus:ring-primary-300"
                        >
                            Ajouter au panier
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Message si le produit n'est pas trouvé -->
        <div v-else class="text-center">
            <p class="text-lg font-medium text-red-500">Produit non trouvé.</p>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import axios from 'axios';

// Interface pour le produit
interface Product {
    id: number;
    name: string;
    description: string;
    price: number;
    image: string;
}

// Variables réactives
const product = ref<Product | null>(null);
const loading = ref<boolean>(true);
const quantity = ref<number>(1);
const showPopup = ref<boolean>(false); // État pour afficher/masquer la popup
const popupMessage = ref<string>(''); // Message de la popup

// Récupérer les informations de la route
const route = useRoute();

// Fonction pour récupérer un produit spécifique
const fetchProduct = async () => {
    const { id } = route.params;
    loading.value = true;
    try {
        const response = await axios.get(`/api/products/${id}`);
        product.value = response.data;
    } catch (error) {
        console.error('Erreur lors du chargement du produit :', error);
    } finally {
        loading.value = false;
    }
};

// Ajouter un produit au panier
const addToCart = async () => {
    if (!product.value) return;

    try {
        await axios.post('/api/add-product', {
            product_id: product.value.id,
            quantity: quantity.value,
            price: product.value.price,
        });
        popupMessage.value = `Produit ajouté au panier : ${product.value.name}`;
        showPopup.value = true;
    } catch (error) {
        console.error('Erreur lors de l\'ajout au panier :', error);
        const errorMessage = (error as any).response?.data?.message || 'Impossible d\'ajouter le produit au panier.';
        popupMessage.value = errorMessage;
        showPopup.value = true;
    }
};

// Charger le produit au montage
onMounted(fetchProduct);
</script>

<template>
    <div class="container mx-auto px-4 sm:px-6 lg:px-8 my-8">
        <!-- Breadcrumb -->
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

        <!-- Chargement -->
        <div v-if="loading" class="text-center">
            <p class="text-lg font-medium">Chargement en cours...</p>
        </div>

        <!-- Affichage des données du produit -->
        <div v-else-if="product" class="max-w-5xl mx-auto p-6 bg-white rounded-lg shadow-md">
            <div class="flex flex-col md:flex-row gap-8">
                <!-- Image du produit -->
                <img 
                    :src="product.image" 
                    :alt="product.name" 
                    class="w-full md:w-1/2 h-64 md:h-auto object-cover rounded-lg" 
                />

                <!-- Détails du produit -->
                <div class="flex-1">
                    <h2 class="text-3xl font-bold mb-4">{{ product.name }}</h2>
                    <p class="text-gray-700 mb-6">{{ product.description }}</p>
                    <p class="text-primary text-2xl font-bold mb-6">{{ product.price }} €</p>

                    <!-- Alignement quantité et prix -->
                    <div class="flex items-center justify-between mb-6">
                        <div>
                            <label for="quantity" class="text-sm font-medium">Quantité :</label>
                            <input 
                                id="quantity" 
                                type="number" 
                                v-model.number="quantity" 
                                min="1" 
                                class="w-20 p-2 border rounded-lg focus:ring focus:ring-primary-300 ml-2" 
                            />
                        </div>
                        <p class="text-primary text-2xl font-bold">{{ product.price * quantity }} €</p>
                    </div>

                    <!-- Bouton centré -->
                    <div class="text-center">
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

        <!-- Popup personnalisée -->
        <div v-if="showPopup" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 z-50">
            <div class="bg-white rounded-lg shadow-lg p-6 max-w-md mx-auto">
                <p class="text-center text-gray-700 font-medium">{{ popupMessage }}</p>
                <div class="text-center mt-4">
                    <button
                        @click="showPopup = false"
                        class="px-6 py-2 bg-primary text-white font-medium rounded-lg shadow hover:bg-primary-600 focus:ring focus:ring-primary-300"
                    >
                        OK
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>


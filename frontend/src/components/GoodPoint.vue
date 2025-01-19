<script setup lang="ts">
// Import des images
import VapoHome1 from "../assets/vapohome_1.png"
import VapoHome2 from "../assets/vapohome_2.png"
import VapoHome3 from "../assets/vapohome_3.png"
import VapoHome4 from "../assets/vapohome_4.png"

// Liste des types de produits
const productTypes = [
  { image: VapoHome1, title: "VAPOSTORE", description: "UNE ÉQUIPE DÉDIÉE" },
  { image: VapoHome2, title: "LIVRAISON 24H", description: "RAPIDE ET FIABLE" },
  { image: VapoHome3, title: "PAIEMENTS EN LIGNE", description: "100% SÉCURISÉS" },
  { image: VapoHome4, title: "BOUTIQUES", description: "PRÈS DE CHEZ VOUS" },
];
</script>

<template>
  <div class="container mx-auto my-12">
    <div class="text-left">
      <h2 class="text-2xl font-bold mb-2">Pourquoi nous choisir ?</h2>
      <div class="w-32 h-1 bg-secondary mt-2"></div>
    </div>

    <!-- Cartes des types de produits -->
    <div class="flex flex-wrap justify-center gap-6 mt-8">
      <div
        v-for="(product, index) in productTypes"
        :key="index"
        class="bg-white shadow-md rounded-lg overflow-hidden w-60 p-4 text-center"
      >
        <img :src="product.image" :alt="product.title" class="w-20 h-20 mx-auto mb-4" />
        <h3 class="text-lg font-bold text-primary mb-2">{{ product.title }}</h3>
        <p class="text-gray-600">{{ product.description }}</p>
        <hr class="mt-4 border-t-2 border-blue-500 w-10 mx-auto" />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import eCigarette from '../assets/e-cigarette.jpg';
import eLiquide from '../assets/e-liquide.png';
import materiel from '../assets/materiel.jpg';
import DIY from '../assets/DIY.jpg';
import accessoires from '../assets/accessoires.jpg';

const products = [
  { 
    name: "E-Cigarettes", 
    description: "Découvrez notre gamme de cigarettes électroniques, idéales pour débutants comme experts.", 
    image: eCigarette 
  },
  { 
    name: "E-Liquides", 
    description: "Une sélection variée d'e-liquides aux saveurs uniques pour satisfaire tous les goûts.", 
    image: eLiquide 
  },
  { 
    name: "Matériel", 
    description: "Retrouvez le matériel nécessaire pour une expérience de vape optimale.", 
    image: materiel 
  },
  { 
    name: "DIY", 
    description: "Créez vos propres e-liquides avec nos kits DIY et personnalisez votre expérience.", 
    image: DIY 
  },
  { 
    name: "Accessoires", 
    description: "Tous les accessoires indispensables pour votre cigarette électronique à portée de main.", 
    image: accessoires 
  },
];
</script>

<template>
  <div class="container mx-auto my-8">
    <div class="text-left">
      <h2 class="text-2xl font-bold">Nos différents produits et services</h2>
      <div class="w-32 h-1 bg-secondary mt-2"></div>
    </div>
    <div class="flex flex-wrap justify-center gap-6 mt-8">
      <!-- Carte Produit -->
      <div
        v-for="(product, index) in products"
        :key="index"
        class="bg-white shadow-md rounded-lg overflow-hidden w-80 flex flex-col items-center"
      >
        <img :src="product.image" :alt="product.name" class="w-full h-48 object-cover" />
        <div class="p-4 text-center">
          <h3 class="text-lg font-bold mb-2">{{ product.name }}</h3>
          <p class="text-gray-600">{{ product.description }}</p>
          <button class="mt-4 px-4 py-2 bg-primary text-white rounded-lg hover:bg-secondary">
            Découvrir
          </button>
        </div>
      </div>
    </div>
  </div>
</template>
<script setup lang="ts">
import NavBar from './components/NavBar.vue';
import Footer from './components/Footer.vue';
</script>

<template>
  <div>
    <NavBar />
    <router-view />
    <Footer />
  </div>
</template>

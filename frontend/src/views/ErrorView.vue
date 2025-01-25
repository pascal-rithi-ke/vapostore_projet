<template>
    <div class="flex flex-col items-center justify-center min-h-screen bg-gray-100">
        <h1 class="text-6xl font-extrabold text-gray-800 mb-4">404</h1>
        <p class="text-lg text-gray-600 mb-8">
            Oups ! La page que vous cherchez n'existe pas.
        </p>
        <router-link to="/" class="px-6 py-3 bg-primary text-white font-semibold rounded-md shadow hover:bg-secondary">
            Retour à l'accueil
        </router-link>
    </div>
</template>
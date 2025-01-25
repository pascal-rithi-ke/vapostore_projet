import { createRouter, createWebHistory, type RouteRecordRaw } from 'vue-router';
import { useAuthStore } from '../stores/auth.js';

import Home from '../views/HomeView.vue';
import ProduitByCategorie from '../views/ProduitByCategorieView.vue';
import Produit from '../views/ProduitView.vue';

import Login from '../views/LoginView.vue';
import Register from '../views/RegisterView.vue';
import Dashboard from '../views/DashboardView.vue';

import Cart from '../views/CartView.vue';
import Checkout from '../views/CheckoutView.vue';

import Presentation from '../views/Presentation.vue';

import Error from '../views/ErrorView.vue';

const routes: Array<RouteRecordRaw> = [
    {
        path: '/',
        name: 'Home',
        component: Home
    },
    {
        path: '/produit/:id/name/:name',
        name: 'Produit',
        component: Produit,
    },
    {
        path: '/produit/categorie/:id/:name',
        name: 'ProduitByCategorie',
        component: ProduitByCategorie,
    },
    {
        path: '/login',
        name: 'Login',
        component: Login
    },
    {
        path: '/dashboard',
        name: 'Dashboard',
        component: Dashboard,
        meta: {
            requiresAuth: true
        }
    },
    {
        path: '/register',
        name: 'Register',
        component: Register
    },
    {
        path: '/presentation',
        name: 'Presentation',
        component: Presentation
    },
    {
        path: '/cart',
        name: 'Cart',
        component: Cart,
        meta: {
            requiresAuth: true
        }
    },
    {
        path: '/checkout',
        name: 'Checkout',
        component: Checkout,
        meta: {
            requiresAuth: true
        }
    },
    /* Page d'erreur */
    {
        path: '/:pathMatch(.*)*',
        name: 'Error',
        component: Error
    },
]

const router = createRouter({
    history: createWebHistory(),
    routes
})

// Vérification de l'authentification avant chaque navigation
router.beforeEach(async (to, __, next) => {
    const authStore = useAuthStore();

    // Mets à jour l'état d'authentification (utile au chargement initial)
    await authStore.fetchAuthStatus();

    // Si la route nécessite une authentification et que l'utilisateur n'est pas connecté
    if (to.meta.requiresAuth && !authStore.isAuthenticated) {
        next("/login"); // Redirige vers la page de connexion
    } else {
        next(); // Continue la navigation
    }
});

export default router
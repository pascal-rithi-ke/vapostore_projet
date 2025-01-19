import { createRouter, createWebHistory, type RouteRecordRaw } from 'vue-router'

import Home from '../views/HomeView.vue'

import Login from '../views/LoginView.vue'
import Register from '../views/RegisterView.vue'

import Presentation from '../views/Presentation.vue'
import Cart from '../views/CartView.vue'

import Error from '../views/ErrorView.vue'

const routes: Array<RouteRecordRaw> = [
    {
        path: '/',
        name: 'Home',
        component: Home
    },
    {
        path: '/login',
        name: 'Login',
        component: Login
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
        component: Cart
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

export default router
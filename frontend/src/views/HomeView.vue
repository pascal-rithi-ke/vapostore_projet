<script>
import Carousel from '../components/Carousel.vue';
import GoodPoint from '../components/GoodPoint.vue';
import ProduitType from '../components/ProduitType.vue';

import axios from "axios";

axios.defaults.baseURL = "http://localhost:8000";
axios.defaults.withCredentials = true;
export default {
    data() {
        return {
            userData: null,
        };
    },
    created() {
        this.fetchUserData();
    },
    methods: {
        async fetchUserData() {
            try {
                const response = await axios.get('/api/user');
                this.userData = response.data;
            } catch (error) {
                console.error('Error fetching user data:', error);
            }
        },
        async logout() {
            try {
                await axios.post('/api/logout');
                this.userData = null;
            } catch (error) {
                console.error('Error logging out:', error);
            }
        },
    },
};
</script>

<template>
    <p v-if="userData">Bonjour {{ userData.name }}</p>
    <button v-if="userData" @click="logout">Logout</button>
    <Carousel />
    <div class="mx-40">
        <GoodPoint />
        <ProduitType />
    </div>
</template>

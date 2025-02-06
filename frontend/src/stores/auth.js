import { defineStore } from "pinia";
import axios from "axios";

axios.defaults.baseURL = "http://127.0.0.1:8000";
axios.defaults.withCredentials = true;

/**
 * @typedef {Object} AuthState
 * @property {boolean} isAuthenticated - si l'utilisateur est authentifié
 * @property {any} user - les informations de l'utilisateur
 */

/**
 * Auth store
 */
export const useAuthStore = defineStore("auth", {
    state: /** @returns {AuthState} */ () => ({
        isAuthenticated: false,
        user: null,
    }),
    actions: {
        async fetchAuthStatus() {
            try {
                const response = await axios.get("/api/user");
                console.log("Réponse utilisateur :", response.data);
                this.isAuthenticated = true;
                this.user = response.data;
            } catch (error) {
                console.error("Erreur lors de la récupération de l'état d'authentification :", error);
                this.isAuthenticated = false;
                this.user = null;
            }
        },        
        async logout() {
            try {
                await axios.post("/api/logout");
                this.isAuthenticated = false;
                this.user = null;
            } catch (error) {
                console.error("Erreur lors de la déconnexion :", error);
            }
        },
    },
});

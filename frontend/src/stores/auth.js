import { defineStore } from "pinia";
import axios from "axios";

axios.defaults.baseURL = "https://334a-2a01-e0a-a05-b240-6d34-e6ed-670e-dc4f.ngrok-free.app";
axios.defaults.withCredentials = true;
axios.defaults.headers.common["ngrok-skip-browser-warning"] = "true";

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
                //console.error("Erreur lors de la récupération de l'état d'authentification :", error);
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
                this.isAuthenticated = false;
                this.user = null;
            }
        },
    },
});

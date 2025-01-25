import { defineStore } from "pinia";
import axios from "axios";

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
                this.isAuthenticated = true;
                this.user = response.data;
            } catch (error) {
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

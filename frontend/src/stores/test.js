// stores/test.js
import { defineStore } from 'pinia';

export const useTestStore = defineStore('test', {
    state: () => ({
        message: 'Hello from Pinia!',
    }),
});

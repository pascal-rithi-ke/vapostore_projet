import axios from 'axios';

// Configuration globale d'axios
axios.defaults.baseURL = 'http://127.0.0.1:8000';
axios.defaults.withCredentials = true; // Assure que les cookies sont inclus
axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

export const normalizeName = (name: string): string => {
    return name
        .replace(/\//g, '') // Supprime les slashes
        .replace(/\s+/g, '_'); // Remplace les espaces par des underscores
};
export default normalizeName;

export const getCsrfToken = async () => {
    try {
        const response = await axios.get('/sanctum/csrf-cookie');
        console.log('CSRF token initialisé:', response);
    } catch (error) {
        console.error('Erreur lors de la récupération du token CSRF :', error);
    }
};

import axios from 'axios';

// Configuration globale d'axios
axios.defaults.baseURL = 'https://334a-2a01-e0a-a05-b240-6d34-e6ed-670e-dc4f.ngrok-free.app';
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

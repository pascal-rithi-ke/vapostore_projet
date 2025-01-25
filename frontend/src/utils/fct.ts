const normalizeName = (name: string): string => {
    return name
        .replace(/\//g, '') // Supprime les slashes
        .replace(/\s+/g, '_'); // Remplace les espaces par des underscores
};

export default normalizeName;
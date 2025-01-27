FROM php:8.2.4-fpm

# Installer les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configurer le répertoire de travail
WORKDIR /var/www/html

# Étape 2 : Ajouter Nginx
FROM nginx:latest

# Copier la configuration personnalisée de Nginx
COPY ./nginx.conf /etc/nginx/nginx.conf

# Copier les fichiers de l'application PHP dans le conteneur
COPY --from=0 /var/www/html /var/www/html

# Exposer le port 80 pour Nginx
EXPOSE 80

# Lancer Nginx et PHP-FPM
CMD ["nginx", "-g", "daemon off;"]

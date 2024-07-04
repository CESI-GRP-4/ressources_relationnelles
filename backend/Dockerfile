# Utiliser une image de base PHP avec Apache
FROM php:8.2.12-apache

# Installer les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    && docker-php-ext-install zip pdo pdo_mysql \
    && a2enmod rewrite

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copier les fichiers de l'application dans le conteneur
COPY . /var/www/html

# Copier le fichier .env
COPY .env /var/www/html/.env

# Copier le fichier .htaccess
COPY .htaccess /var/www/html/.htaccess

# Configurer les permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage

# Installer les dépendances PHP via Composer
RUN composer install --no-interaction --optimize-autoloader --prefer-dist

# Configurer Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Exposer le port 80 pour Apache
EXPOSE 80

# Commande pour démarrer Apache
CMD ["apache2-foreground"]

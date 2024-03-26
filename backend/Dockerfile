# Use an official PHP runtime with Apache, as a parent image
FROM php:8.2.12-apache

# Install PDO MySQL driver
RUN docker-php-ext-install pdo pdo_mysql

# Set the working directory in the container
WORKDIR /var/www/html

# Copy application source
COPY . .

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Expose port 80 to the Docker host, so we can access it from the outside.
EXPOSE 80

# The application's entrypoint is PHP's built-in server
CMD ["apache2-foreground"]

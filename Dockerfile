FROM php:8.1-apache

# Install required PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    php-mbstring \
    php-xml \
    php-curl \
    php-cli \
    php-zip \
    curl \
    && docker-php-ext-install pdo pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy app files
COPY . /var/www/html

# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Expose port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]

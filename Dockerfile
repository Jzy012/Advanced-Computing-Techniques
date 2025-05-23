# Use PHP 8.2 with Apache
FROM php:8.2-apache

# Enable required Apache modules
RUN a2enmod rewrite

# Install system dependencies (Tesseract + PHP extensions)
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    libtesseract-dev \
    unzip \
    git \
    zip \
    libzip-dev \
    && docker-php-ext-install pdo pdo_mysql zip

# Set working directory
WORKDIR /var/www/html

# Copy project files
COPY . /var/www/html

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install PHP dependencies
RUN composer install

# Set file permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

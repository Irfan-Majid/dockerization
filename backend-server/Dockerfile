FROM php:8.3-fpm

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    libicu-dev \
    curl \
    && docker-php-ext-configure gd --with-jpeg --with-freetype \
    && docker-php-ext-install -j$(nproc) pdo pdo_mysql mbstring zip gd intl bcmath xml exif

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

# Copy composer files first for better caching
COPY composer.json composer.lock ./
RUN composer install --no-interaction --no-scripts --no-dev --prefer-dist || true

# Copy application code
COPY . /var/www/html

RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache || true

EXPOSE 8000

# Use artisan serve so the container listens on port 8000 (internal)
CMD ["php","artisan","serve","--host=0.0.0.0","--port=8000"]

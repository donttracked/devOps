FROM php:8.1-apache AS builder
ENV COMPOSER_ALLOW_SUPERUSER=1
WORKDIR /app
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip
RUN docker-php-ext-install zip
RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php && php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
COPY ./composer.json /app
RUN composer install

FROM php:8.1-apache
EXPOSE 80
WORKDIR /var/www/html
COPY ./index.php /var/www/html
COPY ./my-site.conf /etc/apache2/sites-available/000-default.conf
RUN a2ensite 000-default.conf
COPY --from=builder /app/vendor /var/www/html/vendor
CMD ["apache2-foreground"]
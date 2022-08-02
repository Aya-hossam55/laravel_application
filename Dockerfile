FROM php:8.1.0-fpm



# Copy composer.lock and composer.json

COPY composer.lock composer.json /var/www/



# Set working directory

WORKDIR /var/www



# Install dependencies

RUN apt-get update && apt-get install -y \

    build-essential \

    libpng-dev \

    libjpeg62-turbo-dev \

    libfreetype6-dev \

    locales \

    zip \

    libzip-dev \

    jpegoptim optipng pngquant gifsicle \

    unzip \

    git \

    curl \

    lua-zlib-dev \

    libmemcached-dev \

    nginx



# Clear cache

RUN apt-get clean && rm -rf /var/lib/apt/lists/*



# Install extensions

RUN docker-php-ext-install  pdo_mysql zip exif pcntl gd shmop 


# Install composer

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer



# Add user for laravel application

#RUN groupadd -g 1000 www

#RUN useradd -u 1000 -ms /bin/bash -g www www



# Copy existing application directory contents

COPY . /var/www



# Copy existing application directory permissions

COPY --chown=root:root . /var/www

RUN chown -R root:root /var/www/storage

RUN chmod -R 777 /var/www/storage

RUN chmod -R 777 /var/www/storage/logs

RUN chmod o+w ./storage/ -R








# Change current user to root

USER root




# Expose port 9000 and start php-fpm server

EXPOSE 9000

CMD ["php-fpm"]

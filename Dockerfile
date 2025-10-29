# Use official PHP7.4 image with Apache. Note that PHP7.4 is deprecated, don't use it in production.
# The only reason to use this image is that Squirrelmail only lists support for PHP7 on their website.
FROM php:7.4-apache

LABEL maintainer="Christian Simon <simon@illucit.com>"

# Set Squirrelmail version to LTS release.
# Latest would be 1.5.2 as of October 29th, 2025
ENV SQUIRRELMAIL_VERSION=1.4.22

ENV SQUIRRELMAIL_URL "https://sourceforge.net/projects/squirrelmail/files/stable/${SQUIRRELMAIL_VERSION}/squirrelmail-webmail-${SQUIRRELMAIL_VERSION}.tar.gz/download?use_mirror=heanet"

# Install required PHP extensions and system dependencies
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
  libcurl4-gnutls-dev \
  libpng-dev \
  libjpeg-dev \
  libfreetype6-dev \
  libssl-dev \
  libzip-dev \
  libonig-dev \
  libc-client2007e-dev \
  libkrb5-dev \
  unzip \
  cron \
  re2c \
  python3 \
  tree \
  wget \
  && docker-php-ext-configure imap --with-imap-ssl --with-kerberos \
  && docker-php-ext-configure gd --with-jpeg --with-freetype \
  && docker-php-ext-install mysqli curl gd zip mbstring imap iconv \
  && rm -rf /var/lib/apt/lists/* 

# Configure PHP 
RUN echo 'register_globals = Off' > /usr/local/etc/php/conf.d/squirrelmail.ini \
  && echo 'magic_quotes_runtime = Off' >> /usr/local/etc/php/conf.d/squirrelmail.ini \
  && echo 'magic_quotes_gpc = Off' >> /usr/local/etc/php/conf.d/squirrelmail.ini \
  && echo 'file_upload = On' >> /usr/local/etc/php/conf.d/squirrelmail.ini \
  && echo 'error_reporting = E_ERROR' >> /usr/local/etc/php/conf.d/squirrelmail.ini

# Install Squirrelmail
RUN cd /var/www/html \
  && wget "${SQUIRRELMAIL_URL}" -O squirrelmail-webmail-${SQUIRRELMAIL_VERSION}.tar.gz \
  && tar -zxvf squirrelmail-webmail-${SQUIRRELMAIL_VERSION}.tar.gz --strip-components=1 \
  && rm squirrelmail-webmail-${SQUIRRELMAIL_VERSION}.tar.gz \
  && chown -R www-data:www-data .

VOLUME /var/squirrelmail

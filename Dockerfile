############################################################
# Dockerfile to build Catchall HTTP container images
# Based on php:7.0
############################################################

# Set the base image to php:7.0
FROM php:7.0-apache

# File Author / Maintainer
MAINTAINER Probably Rational Ltd.

#Set the work directory  
WORKDIR /var/www/html

# Installl a sweet ass profile
RUN curl -o ~/.bashrc https://gist.githubusercontent.com/hcaz/1f98157bd8ae8c647ffb3ab243d69fc8/raw/.bashrc

# Update the repository sources list
RUN apt update

# Install essentials
RUN apt install -y curl wget htop git nano cron

# Install Composer
RUN mkdir -p ~/.composer/vendor/bin
RUN curl -o installer.php https://getcomposer.org/installer && php installer.php --install-dir ~/.composer/vendor/bin && rm installer.php

# Clean up
RUN rm -rf /var/www/*

# Configure apache
RUN curl -o /etc/apache2/sites-available/000-default.conf https://gist.githubusercontent.com/hcaz/14ff9ec7efcfe09cd301ff60532dd883/raw/000-default.conf
RUN a2enmod status rewrite

# Copy in required files
COPY app/ /var/www/html/

# Add a crontab
RUN touch crontab.tmp && echo '*/5 * * * * curl -fsS --retry 3 https://hchk.io/$healthcheck > /dev/null' > crontab.tmp && crontab crontab.tmp && rm -rf crontab.tmp

# Make composer work globally ;)
RUN mv ~/.composer/vendor/bin/composer.phar ~/.composer/vendor/bin/composer

# Expose ports
EXPOSE 80

FROM php:7.0-cli
COPY app /app
WORKDIR /app
EXPOSE 80
CMD [ "php -S 0.0.0.0:80 -t /app/" ]

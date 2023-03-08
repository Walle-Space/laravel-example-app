FROM php:8-fpm

RUN apt-get update && apt-get install -y \
    nginx \
    supervisor \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY ./ /var/www/html

WORKDIR /var/www/html

# Configure nginx
COPY ./docker/config/nginx.conf /etc/nginx/nginx.conf

# Configure supervisord
COPY ./docker/config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# init laravel app
RUN chmod -R 777 /var/www/html/storage
RUN chmod -R 777 /var/www/html/bootstrap/cache

RUN chmod -R 777 /var/log/nginx

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
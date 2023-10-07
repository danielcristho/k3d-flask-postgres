FROM alpine:latest

RUN echo "UTC" > /etc/timezone
RUN apk add --no-cache zip unzip curl bash supervisor

RUN sed -i 's/bin\/ash/bin\/bash/g' /etc/passwd

WORKDIR /var/www/html

# Installing PHP & dependencies
RUN apk add --no-cache php82 \
    php82-common \
    php82-fpm \
    php82-pdo \
    php82-opcache \
    php82-zip \
    php82-phar \
    php82-iconv \
    php82-cli \
    php82-curl \
    php82-openssl \
    php82-mbstring \
    php82-tokenizer \
    php82-fileinfo \
    php82-json \
    php82-xml \
    php82-xmlwriter \
    php82-simplexml \
    php82-dom \
    php82-pdo_mysql \
    php82-pdo_sqlite \
    php82-tokenizer \
    php82-gd

RUN ln -s /usr/bin/php82 /usr/bin/php

RUN mkdir -p /run/php/
RUN touch /run/php/php8.2-fpm.pid

COPY ./fpm.ini /etc/php82/php-fpm.conf
COPY ./php.ini /etc/php82/php.ini

# Configure supervisor
RUN mkdir -p /etc/supervisor.d/
COPY ./supervisord.ini /etc/supervisor.d/supervisord.ini

# Download Moodle
RUN curl -L https://download.moodle.org/download.php/direct/stable310/moodle-latest-310.tgz | tar xz -C /var/www/html --strip-components=1
RUN rm -rf /var/www/html/*

# Configure Moodle
RUN chown -R nobody:nogroup /var/www/html
RUN chmod -R 755 /var/www/html

EXPOSE 9000
CMD ["supervisord", "-c", "/etc/supervisor.d/supervisord.ini"]
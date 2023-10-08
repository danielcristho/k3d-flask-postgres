FROM alpine:latest

RUN echo "UTC" > /etc/timezone
RUN apk add --no-cache zip unzip curl bash supervisor

RUN sed -i 's/bin\/ash/bin\/bash/g' /etc/passwd

WORKDIR /var/www/moodle

# Installing PHP & dependencies
RUN apk add --no-cache php82 \
    php82-common \
    php82-fpm \
    php82-pdo \
    php82-zip \
    php82-phar \
    php82-iconv \
    php82-cli \
    php82-curl \
    php82-pspell \
    php82-mbstring \
    php82-tokenizer \
    php82-fileinfo \
    php82-json \
    php82-xml \
    php82-dom \
    php82-pdo_mysql \
    php82-gd \
    php82-intl \
    php82-ldap

RUN ln -s /usr/bin/php82 /usr/bin/php

RUN mkdir -p /run/php/
RUN touch /run/php/php8.2-fpm.pid

COPY ./fpm.ini /etc/php82/php-fpm.conf
COPY ./php.ini /etc/php82/php.ini

# Configure supervisor
RUN mkdir -p /etc/supervisor.d/
COPY ./supervisord.ini /etc/supervisor.d/supervisord.ini

# Download Moodle
RUN  wget https://download.moodle.org/download.php/direct/stable38/moodle-latest-38.tgz && \
    tar xzvf moodle-latest-38.tgz && \
    mv moodle /var/www/moodle/app


# RUN curl -L https://download.moodle.org/download.php/direct/stable310/moodle-latest-310.tgz | tar xz -C /var/www/moodle --strip-components=1
# RUN rm -rf /var/www/moodle/*

# Configure Moodle
RUN chown -R nobody:nogroup /var/www/moodle
RUN chmod -R 755 /var/www/moodle

EXPOSE 9000
CMD ["supervisord", "-c", "/etc/supervisor.d/supervisord.ini"]
FROM dunglas/frankenphp:latest-php8.2-alpine

ARG USER=www-data

ENV VERSION=10.0.16 
ENV GLPI_LANG=en_US 
ENV MARIADB_HOST=mariadb-glpi 
ENV MARIADB_PORT=3306 
ENV MARIADB_DATABASE=glpi 
ENV MARIADB_USER=glpi 
ENV MARIADB_PASSWORD=glpi 
ENV GLPI_CONFIG_DIR=/etc/glpi/config 
ENV GLPI_VAR_DIR=/var/lib/glpi 
ENV GLPI_MARKETPLACE_DIR=${GLPI_VAR_DIR}/_marketplace 
ENV GLPI_DOC_DIR=${GLPI_VAR_DIR} 
ENV GLPI_CRON_DIR=${GLPI_VAR_DIR}/_cron 
ENV GLPI_DUMP_DIR=${GLPI_VAR_DIR}/_dumps 
ENV GLPI_GRAPH_DIR=${GLPI_VAR_DIR}/_graphs 
ENV GLPI_LOCK_DIR=${GLPI_VAR_DIR}/_lock 
ENV GLPI_LOG_DIR=${GLPI_VAR_DIR}/_log 
ENV GLPI_PICTURE_DIR=${GLPI_VAR_DIR}/_pictures 
ENV GLPI_PLUGIN_DOC_DIR=${GLPI_VAR_DIR}/_plugins 
ENV GLPI_RSS_DIR=${GLPI_VAR_DIR}/_rss 
ENV GLPI_SESSION_DIR=${GLPI_VAR_DIR}/_sessions 
ENV GLPI_TMP_DIR=${GLPI_VAR_DIR}/_tmp 
ENV GLPI_UPLOAD_DIR=${GLPI_VAR_DIR}/_uploads 
ENV GLPI_CACHE_DIR=${GLPI_VAR_DIR}/_cache

# Copy over all the config files
COPY conf.d/*.ini $PHP_INI_DIR/conf.d/
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY conf.d/Caddyfile /etc/caddy/Caddyfile

RUN install-php-extensions \
    curl \
    fileinfo \
    gd \
    json \
    mbstring \
    mysqli \
    session \
    zlib \
    simplexml \
    xml \
    intl \
    imap \
    ldap \
    openssl \
    xmlrpc \
    bz2 \
    exif \
    opcache \
    zip \
    redis
    
RUN \
    # Use "adduser -D ${USER}" for alpine based distros
    useradd -D ${USER}; \
    # Remove default capability
    setcap -r /usr/local/bin/frankenphp; \
    # Give write access to /data/caddy and /config/caddy
    chown -R ${USER}:${USER} /data/caddy && chown -R ${USER}:${USER} /config/caddy

RUN touch crontab.tmp \
    && echo '*/2 * * * * php /app/public/front/cron.php' > crontab.tmp \
    && crontab crontab.tmp \
    && rm -rf crontab.tmp

WORKDIR /app/public

ADD https://github.com/glpi-project/glpi/releases/download/${VERSION}/glpi-${VERSION}.tgz /tmp/

RUN tar -zxf /tmp/glpi-${VERSION}.tgz -C /tmp/ \
    && mv /tmp/glpi/* /app/public \
    && chown -R www-data:www-data /app/public \
    && rm -rf /tmp/glpi-${VERSION}.tgz
    
COPY scripts/glpi-*.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/glpi-*.sh \
&& /usr/local/bin/glpi-verify-dir.sh

RUN rm -rf /app/public/install/install.php

USER ${USER}

EXPOSE 9000/tcp
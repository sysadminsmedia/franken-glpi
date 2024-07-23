#!/bin/sh

cacheConfigure () {

    php bin/console cache:configure \
        --dsn redis://redis/0
}

cacheConfigure
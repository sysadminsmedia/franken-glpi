#!/bin/sh

# Requires root user

mariadb -h "$MARIADB_HOST" -u root -p"$MARIADB_ROOT_PASSWORD" -e "\"GRANT SELECT ON \`mysql\`.\`time_zone_name\` TO 'glpi'@'%'; FLUSH PRIVILEGES;\""
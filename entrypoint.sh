#!/bin/bash
set -e

# Set TimeZone
if [ ! -z "$TZ" ]; then
	echo ">> set timezone"
	cp /usr/share/zoneinfo/${TZ} /etc/localtime
	echo ${TZ} >  /etc/timezone
	date
	sed -i "s|;*date.timezone =.*|date.timezone = ${TZ}|i" /etc/php7/php.ini
fi

# Display PHP error's or not
if [[ "$PHP_ERRORS" == "1" ]] ; then
	echo ">> set display_errors"
	echo "display_errors = On" >> /etc/php7/conf.d/z_custom.ini
	sed -i "s|display_errors\s*=\s*Off|display_errors = On|i" /etc/php7/php.ini
fi

# Increase the memory_limit
if [ ! -z "$PHP_MEM_LIMIT" ]; then
	echo ">> set memory_limit"
	sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEM_LIMIT}M|i" /etc/php7/php.ini
fi

# exec CMD
echo ">> exec docker CMD"
echo "$@"
exec "$@"

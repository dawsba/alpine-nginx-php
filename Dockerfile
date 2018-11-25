# Pull base image
FROM alpine:3.8

# Label for Information about this Image.
LABEL maintainer="Tobias Hargesheimer <docker@ison.ws>" \
	description="AlpineLinux with NGINX Webserver and PHP7"

# Define variable
ENV LANG C.UTF-8
ENV TZ Europe/Berlin
ENV TERM=xterm
ENV WWW_USER=www

# Install
RUN addgroup -S $WWW_USER && adduser -D -S -h /var/cache/$WWW_USER -s /sbin/nologin -G $WWW_USER $WWW_USER && \
	apk --no-cache add \
	tzdata wget curl nano \
	supervisor \
	nginx \
	php7 php7-fpm php7-opcache php7-json\
	&& mkdir -p /run/nginx \
	&& mkdir -p /etc/ssl/nginx \
	&& mkdir -p /var/www/html \ 
	&& chown -R $WWW_USER:$WWW_USER /var/www/html \
	&& sed -i "s/ssl_session_cache shared:SSL:2m;/#ssl_session_cache shared:SSL:2m;/g" /etc/nginx/nginx.conf \
	&& sed -i "s/user nginx;/user ${WWW_USER};/g" /etc/nginx/nginx.conf \
	#&& sed -i "s/client_max_body_size 1m;/client_max_body_size 0;/g" /etc/nginx/nginx.conf \
	&& sed -i "s|;listen.mode\s*=\s*0660|listen.mode = 0660}|g" /etc/php7/php-fpm.d/www.conf \
	&& sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = ${WWW_USER}|g" /etc/php7/php-fpm.d/www.conf \
	&& sed -i "s|;listen.group\s*=\s*nobody|listen.group = ${WWW_USER}|g" /etc/php7/php-fpm.d/www.conf \
	&& sed -i "s|user\s*=\s*nobody|user = ${WWW_USER}|g" /etc/php7/php-fpm.d/www.conf \
	&& sed -i "s|group\s*=\s*nobody|group = ${WWW_USER}|g" /etc/php7/php-fpm.d/www.conf \
	&& ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log \
	&& ln -sf /dev/stderr /var/log/php7/error.log

# Copy files and folders into image
COPY config/nginx_default.conf /etc/nginx/conf.d/default.conf
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY source /var/www/html
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Define workdir
WORKDIR /var/www/html

# Define mountable directories
VOLUME ["/etc/nginx/conf.d/","/etc/ssl/nginx","/var/www/html"]

# Expose ports
EXPOSE 80 443

# Define main command
#ENTRYPOINT ["/entrypoint.sh"]

# Define default command
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

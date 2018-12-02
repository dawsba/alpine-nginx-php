# AlpineLinux with NGINX und PHP7 on x86_64

### Supported tags and respective `Dockerfile` links
-	[`latest` (*Dockerfile*)](https://github.com/Tob1asDocker/alpine-nginx-php/blob/master/Dockerfile)
-	[`extended` (*Dockerfile*)](https://github.com/Tob1asDocker/alpine-nginx-php/blob/master/Dockerfile-extended)

### Information:
AlpineLinux with NGINX und PHP7 on x86_64  
See https://wiki.alpinelinux.org/wiki/Nginx_with_PHP#PHP7_Installation for more information or to install more PHP packages!

### How to use this image
* ``` $ docker pull tobi312/alpine-nginx-php:TAG ```
* Optional: ``` $ mkdir -p /srv/html ```
* ``` $ docker run --name php -d -p PORT:PORT -v /srv/html:/var/www/html -e PHP_ERRORS=1 -e PHP_UPLOAD_MAX_FILESIZE=250 tobi312/alpine-nginx-php:TAG ``` 

### Environment Variables
* `TZ` (Default: Europe/Berlin)
* `PHP_ERRORS` (set 1 to enable)
* `PHP_MEM_LIMIT` (Value in MB)
* `PHP_POST_MAX_SIZE` (Value in MB)
* `PHP_UPLOAD_MAX_FILESIZE` (Value in MB)
* `PHP_MAX_FILE_UPLOADS` (number)

### This Image on
* [DockerHub](https://hub.docker.com/r/tobi312/alpine-nginx-php/)
* [GitHub](https://github.com/Tob1asDocker/alpine-nginx-php)

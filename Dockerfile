#Build from latest php
FROM php:apache

#Copy php.ini from config (in repo) to /usr/local/etc/php
COPY config /usr/local/etc/php

#Get bzip2 for later decompressing of phpBB download, php-pear beacuse pears are nice (or for zip)
RUN apt-get update && apt-get install -y bzip2 php-pear unzip

#install zip from pecl
RUN pecl install zip

#Add mysqli to php install
RUN docker-php-ext-install mysqli

#Get phpBB
WORKDIR "/var/www/html"
RUN  curl -L "https://www.phpbb.com/files/release/phpBB-3.2.0.tar.bz2" | tar xvj 

#CHMOD on config.php for installation
WORKDIR "/var/www/html/phpBB3"
RUN chmod 666 config.php

CMD apache2-foreground

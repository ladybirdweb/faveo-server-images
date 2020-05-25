# Installing Faveo Helpdesk Freelancer, paid and Enterprise on Ubuntu <!-- omit in toc -->


<img alt="Ubuntu" src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Logo-ubuntu_cof-orange-hex.svg/120px-Logo-ubuntu_cof-orange-hex.svg.png" width="120" height="120" />

Faveo can run on [Ubuntu 18.04 (Bionic Beaver)](http://releases.ubuntu.com/18.04/).

-   [Prerequisites](#prerequisites)
-   [Installation steps](#installation-steps)
    -   [1. Upload Faveo](#1-upload-faveo)
    -   [2. Setup the database](#2-setup-the-database)
    -   [3. Install Faveo](#3-gui-faveo-installer)
    -   [4. Configure cron job](#4-configure-cron-job)
    -   [5. Configure Apache webserver](#5-configure-apache-webserver)
    -   [6. Redis Installation](#redis-installation)
    -   [7. SSL Installation](#ssl-installation)
    -   [8. Final step](#final-step)


<a id="prerequisites" name="prerequisites"></a>
## Prerequisites

Faveo depends on the following:

-   **Nginx** 
-   **Git**
-   **PHP 7.3+** with the following extensions: curl, dom, gd, json, mbstring, openssl, pdo_mysql, tokenizer, zip
-   **Composer**
-   **MySQL 5.7+** or MariaDB **10.3+**

**LAMP Installation** follow the [instructions here](https://github.com/teddysun/lamp)
If you follow this step, no need to install Apache, PHP, MySQL separetely as listed below

**Nginx:** Use the below steps to install and start Nginx

```sh
sudo apt install nginx
systemctl start nginx
systemctl enable nginx
```

**Git:** Git should come pre-installed with your server. If it's not, install it with:

```sh
sudo apt update
sudo apt install -y git
```

**PHP 7.3+:**

First add this PPA repository:

```sh
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:ondrej/php
```

Then install php 7.3 with these extensions:

```sh
sudo apt update
sudo apt install -y php7.3 lib-apache2-mod-php php7.3-mysql \
    php7.3-cli php7.3-common php7.3-fpm php7.3-soap php7.3-gd \
    php7.3-json php7.3-opcache  php7.3-mbstring php7.3-zip \
    php7.3-bcmath php7.3-intl php7.3-xml php7.3-curl  \
    php7.3-imap php7.3-ldap php7.3-gmp \
```

<b>Setting Up ionCube</b>
```sh
wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz 
tar xvfz ioncube_loaders_lin_x86-64.tar.gz 
php -i | grep extension_dir
```
Copy ion cube loader to Directory.

```sh
cp ioncube/ioncube_loader_lin_7.3.so /usr/lib/php/20190902
sed -i '2 a zend_extension = "/usr/lib/php/20190902/ioncube_loader_lin_7.3.so"' /etc/php/7.3/apache2/php.ini
sed -i '2 a zend_extension = "/usr/lib/php/20190902/ioncube_loader_lin_7.3.so"' /etc/php/7.3/cli/php.ini
systemctl restart apache2.service
```

**Composer:** After you're done installing PHP, you'll need the [Composer](https://getcomposer.org/download/) dependency manager.

```sh
cd /tmp
curl -s https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer
rm -f composer-setup.php
```

(or you can follow instruction on [getcomposer.org](https://getcomposer.org/download/) page)

**Mysql:** 

The official Faveo installation uses Mysql as the database system and **this is the only official system we support**. While Laravel technically supports PostgreSQL and SQLite, we can't guarantee that it will work fine with Faveo as we've never tested it. Feel free to read [Laravel's documentation](https://laravel.com/docs/database#configuration) on that topic if you feel adventurous.


Install Mysql 5.7. Note that this only installs the package, but does not setup Mysql. This is done later in the instructions:

```sh
sudo apt update
sudo apt install -y mysql-server
```

Secure your mysql installation. Set a Password for mysql by running the command below

```sh
mysql_secure_installation 
```

**phpMyAdmin:** Install phpMyAdmin. This is optional step. phpMyAdmin gives a GUI to access and work with Database

```sh
sudo apt install phpmyadmin
```

<a id="installation-steps" name="installation-steps"></a>
## Installation steps

Once the softwares above are installed:


<a id="1-upload-faveo" name="1-upload-faveo"></a>
### 1. Upload Faveo
Please download Faveo Helpdesk from [https://billing.faveohelpdesk.com](https://billing.faveohelpdesk.com) and upload it to below directory

```sh
/var/www/faveo
```

<a id="2-setup-the-database" name="2-setup-the-database"></a>
### 2. Setup the database

Log in with the root account to configure the database.

```sh
mysql -u root -p
```

Create a database called 'faveo'.

```sql
CREATE DATABASE faveo;
```

Create a user called 'faveo' and its password 'strongpassword'.

```sql
CREATE USER 'faveo'@'localhost' IDENTIFIED BY 'strongpassword';
```

We have to authorize the new user on the faveo db so that he is allowed to change the database.

```sql
GRANT ALL ON faveo.* TO 'faveo'@'localhost';
```

And finally we apply the changes and exit the database.

```sql
FLUSH PRIVILEGES;
exit
```

<a id="3-gui-faveo-installer" name="3-gui-faveo-installer"></a>
### 3. Install Faveo

Now you can install Faveo via [GUI](https://support.faveohelpdesk.com/show/web-gui-installer) Wizard or [CLI](https://support.faveohelpdesk.com/show/cli-installer).

<a id="4-configure-cron-job" name="4-configure-cron-job"></a>
### 4. Configure cron job

Faveo requires some background processes to continuously run. The list of things Faveo does in the background is described [here](https://github.com/ladybirdweb/faveo-helpdesk/blob/master/app/Console/Kernel.php#L9).
Basically those crons are needed to receive emails
To do this, setup a cron that runs every minute that triggers the following command `php artisan schedule:run`.

Create a new `/etc/cron.d/faveo` file with:

```sh
echo "* * * * * sudo -u www-data php /var/www/faveo/artisan schedule:run" | sudo tee /etc/cron.d/faveo
```

### 5. Configure Nginx webserver

1. Give proper permissions to the project directory by running:

```sh
chown -R www-data:www-data /opt/faveo 
chmod -R 755 /opt/faveo 
chmod -R 755 /opt/faveo/
chmod -R 755 /opt/faveo/storage 
chmod -R 755 /opt/faveo/bootstrap 
```

2. Create a copy of Nginx default config file

```
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.back
wget -O /etc/nginx/nginx.conf https://support.faveohelpdesk.com/uploads/ubuntu16.04/faveo-nginx-conf.txt
```

3. Edit domain & create Nginx conf using Nano editor

```sh
nano /etc/nginx/conf.d/faveo-helpdesk.conf
```

Then, in the `nano` text editor window you just opened, copy the following 

```nginx

upstream faveo_php {
    server unix://opt/faveo/faveo-helpdesk/faveo_php.socket;
 }
      server {
      listen 80;
     listen 127.0.0.1:80;        
     # Edit the following line with the correct information.
     server_name %(SERVERNAME)s;
    error_log /var/log/nginx/faveo_error_log;
    access_log /var/log/nginx/faveo_access_log;
    root /opt/faveo/faveo-helpdesk/public;
    index index.php index.html index.htm;
    error_page 403 404 405 500 501 502 503 504 @error;
    try_files $uri $uri/ /index.php?$args;
    location @error {
           rewrite ^/(.*)$ /index.php?$1;
    }
            location ~ /\. { 
                    deny all;
    }
    location ~ /(artisan|composer.json|composer.lock|gulpfile.js|LICENSE|package.json|phpspec.yml|phpunit.xml|README.md|readme.txt|release-notes.txt|server.php)
 {
            deny all;
    }
    location ~ [^/]\.php(/|$) {
        fastcgi_split_path_info ^(.+?\.php)(/.*)$;
        if (!-f $document_root$fastcgi_script_name) {
            return 404;
        }
       include /etc/nginx/fastcgi_params;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_pass faveo_php; 
   }
 }
```

4. Remove default config file

```sh
rm -rf /etc/nginx/conf.d/default.conf
```

5. Create config file for PHP FPM using vim editor

```sh
nano /etc/php/7.3/fpm/pool.d/faveo_php.conf
```
Paste the below content in the conf file.

```
[faveo_php] 
user = www-data 
group = www-data 
listen = /opt/faveo/faveo-helpdesk/faveo_php.socket 
listen.owner = www-data listen.group = www-data 
pm = dynamic pm.max_children = 5 
pm.start_servers = 2 
pm.min_spare_servers = 1 
pm.max_spare_servers = 3 
chdir = / 
service mysql restart 
service nginx restart 
service php7.3-fpm restart 
```

<a id="redis-installation" name="redis-installation"></a>
### 6. Redis Installation

Redis is an open-source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.

This is an optional step and will improve system performance and is highly recommended.

[Redis installation documentation](/docs/installation/providers/enterprise/ubuntu-redis.md)

<a id="ssl-installation" name="ssl-installation"></a>
### 7. SSL Installation

Secure Sockets Layer (SSL) is a standard security technology for establishing an encrypted link between a server and a client. Let's Encrypt is a free, automated, and open certificate authority.

This is an optional step and will improve system security and is highly recommended.

[Let’s Encrypt SSL installation documentation](/docs/installation/providers/enterprise/ubuntu-apache-ssl.md)

<a id="final-step" name="final-step"></a>
### 8. Final step

The final step is to have fun with your newly created instance, which should be up and running to `http://localhost`.

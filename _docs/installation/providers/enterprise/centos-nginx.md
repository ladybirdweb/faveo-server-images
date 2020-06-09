# Installing Faveo Helpdesk Freelancer, paid and Enterprise on Cent OS <!-- omit in toc -->


<img alt="Ubuntu" src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Centos-logo-light.svg/300px-Centos-logo-light.svg.png" width="200"  />

Faveo can run on [Cent OS 7](https://www.centos.org/download/).

-   [Prerequisites](#prerequisites)

-   [Installation steps](#installation-steps)
    -   [1. Upload Faveo](#1-upload-faveo)
    -   [2. Setup the database](#2-setup-the-database)
    -   [3. Configure Nginx webserver](#5-configure-apache-webserver)
    -   [4. Install Faveo](#3-gui-faveo-installer)
    -   [5. Configure cron job](#4-configure-cron-job)
    -   [6. Redis Installation](#redis-installation)
    -   [7. SSL Installation](#ssl-installation)
    -   [8. Final step](#final-step)


<a id="prerequisites" name="prerequisites"></a>
## Prerequisites

Faveo depends on the following:

-   **Nginx** 
-   **PHP 7.3+** with the following extensions: curl, dom, gd, json, mbstring, openssl, pdo_mysql, tokenizer, zip
-   **MySQL 5.7+** or **MariaDB 10.3+**

### a. LAMP Installation

Follow the [instructions here](https://github.com/teddysun/lamp)
If you follow this step, no need to install Apache, PHP, MySQL separetely as listed below

Login as root user by typing the command below

```sh
sudo su
```
### b. Update your package list

```sh
yum update -y
```
### c. Install and enable Remi repository

```sh
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm 
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm 
sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm 
sudo yum install yum-utils
```
### d. Nginx

Use the below steps to install and start Nginx

```sh
yum install nginx
systemctl start nginx
systemctl enable nginx
```


### e. PHP 7.3+

Install php 7.3 with these extensions:

```sh
yum install -y curl openssl  
yum-config-manager --enable remi-php73
yum -y install php php-cli php-common php-fpm php-gd php-mbstring php-pecl-mcrypt php-mysqlnd php-odbc php-pdo php-xml  php-opcache php-imap php-bcmath php-ldap php-pecl-zip php-soap
yum remove php-mysql
```

**Setting Up ionCube**

```sh
wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
tar xfz ioncube_loaders_lin_x86-64.tar.gz
ls ioncube 
php -i | grep extension_dir
```
Copy ion cube loader to Directory.

```sh
cp ioncube/ioncube_loader_lin_7.3.so /usr/lib64/php/modules 
sed -i '2 a zend_extension = "/usr/lib64/php/modules/ioncube_loader_lin_7.3.so"' /etc/php.ini
sed -i "s/max_execution_time = .*/max_execution_time = 300/" /etc/php.ini
```

### f. Mysql

The official Faveo installation uses Mysql as the database system and **this is the only official system we support**. While Laravel technically supports PostgreSQL and SQLite, we can't guarantee that it will work fine with Faveo as we've never tested it. Feel free to read [Laravel's documentation](https://laravel.com/docs/database#configuration) on that topic if you feel adventurous.

Install Mysql 5.7. Note that this only installs the package, but does not setup Mysql. This is done later in the instructions:

```sh
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
rpm -ivh mysql-community-release-el7-5.noarch.rpm 
yum install mysql-server
systemctl start mysqld
```

Secure your mysql installation. Set a Password for mysql by running the command below

```sh
mysql_secure_installation 
```

**phpMyAdmin(Optional):** 
Install phpMyAdmin. This is optional step. phpMyAdmin gives a GUI to access and work with Database

```sh
yum install phpmyadmin
```


<a id="installation-steps" name="installation-steps"></a>
## Installation steps

Once the softwares above are installed:


<a id="1-upload-faveo" name="1-upload-faveo"></a>
### 1. Upload Faveo
Please download Faveo Helpdesk from [https://billing.faveohelpdesk.com](https://billing.faveohelpdesk.com) and upload it to below directory

```sh
/var/www/faveo/
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


<a id="5-configure-apache-webserver" name="5-configure-apache-webserver"></a>
### 3. Configure Nginx webserver

**a.** Give proper permissions to the project directory by running:

```sh
chown -R apache:apache /var/www/faveo 
chmod -R 755 /var/www/faveo 
chmod -R 755 /var/www/faveo/storage 
chmod -R 755 /var/www/faveo/bootstrap 
```

**b.** Edit domain & create Nginx conf using Nano editor

```sh
nano /etc/nginx/conf.d/faveo.conf
```

Then, in the `nano` text editor window you just open, copy the following 

```nginx
server {
    listen   80;
    server_name  example.com www.example.com;

# note that these lines are originally from the "location /" block
root   /var/www/faveo/public;
index index.php index.html index.htm;


location ~ \.php$ {
    try_files $uri =404;
    fastcgi_pass 127.0.0.1:9000;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include fastcgi_params;
}

location / {
            	try_files $uri $uri/ /index.php?$query_string;
}

location ~* \.html$ {
    expires -1;
}

location ~* \.(css|gif|jpe?g|png)$ {
    expires 1M;
    add_header Pragma public;
    add_header Cache-Control "public, must-revalidate, proxy-revalidate";
}

gzip on;
gzip_http_version 1.1;
gzip_vary on;
gzip_comp_level 6;
gzip_proxied any;
gzip_types application/atom+xml
           application/javascript
           application/json
           application/vnd.ms-fontobject
           application/x-font-ttf
           application/x-web-app-manifest+json
           application/xhtml+xml
           application/xml
           font/opentype
           image/svg+xml
           image/x-icon
           text/css
           #text/html -- text/html is gzipped by default by nginx
           text/plain
           text/xml;
gzip_buffers 16 8k;
gzip_disable "MSIE [1-6]\.(?!.*SV1)";
   }

```

**c.** Edit config file for PHP FPM using vim editor

```sh
nano /etc/php-fpm.d/www.conf
```
You will need replace these lines

```
listen.owner = nobody to listen.owner = apache

listen.group = nobody to listen.group = apache

Finally check if ;listen = 127.0.0.1:9000 is without ;
```

Restart PFM and NGINX
```sh
systemctl start php-fpm.service
systemctl enable php-fpm.service
systemctl restart nginx
```

<a id="3-gui-faveo-installer" name="3-gui-faveo-installer"></a>
### 4. Install Faveo

Now you can install Faveo via [GUI](https://support.faveohelpdesk.com/show/web-gui-installer) Wizard or [CLI](https://support.faveohelpdesk.com/show/cli-installer).

<a id="4-configure-cron-job" name="4-configure-cron-job"></a>
### 5. Configure cron job

Faveo requires some background processes to continuously run. 
Basically those crons are needed to receive emails
To do this, setup a cron that runs every minute that triggers the following command `php artisan schedule:run`.

Create a new `/etc/cron.d/faveo` file with:

```sh
echo "* * * * * apache /usr/bin/php /var/www/faveo/artisan schedule:run 2>&1" | sudo tee /etc/cron.d/faveo
```

<a id="redis-installation" name="redis-installation"></a>
### 6. Redis Installation

Redis is an open-source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.

This is an optional step and will improve system performance and is highly recommended.

[Redis installation documentation](/docs/installation/providers/enterprise/centos-redis.md)

<a id="ssl-installation" name="ssl-installation"></a>
### 7. SSL Installation

Secure Sockets Layer (SSL) is a standard security technology for establishing an encrypted link between a server and a client. Let's Encrypt is a free, automated, and open certificate authority.

This is an optional step and will improve system security and is highly recommended.

[Let’s Encrypt SSL installation documentation](/docs/installation/providers/enterprise/centos-nginx-ssl.md)

<a id="final-step" name="final-step"></a>
### 8. Final step

The final step is to have fun with your newly created instance, which should be up and running to `http://localhost`.

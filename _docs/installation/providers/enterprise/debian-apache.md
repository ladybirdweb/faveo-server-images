---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/debian-apache/
redirect_from:
  - /theme-setup/
last_modified_at: 2020-06-09
toc: true
---

# Installing Faveo Helpdesk Freelancer, paid and Enterprise on Debian <!-- omit in toc -->

<img alt="debian" src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Debian-OpenLogo.svg/109px-Debian-OpenLogo.svg.png" width="96" height="127" />

Faveo can run on Debian 10 (Buster).

-   [Prerequisites](#prerequisites)
-   [Installation steps](#installation-steps)
    -   [1. Upload Faveo](#1-upload-faveo)
    -   [2. Setup the database](#2-setup-the-database)
    -   [3. Configure Apache webserver](#5-configure-apache-webserver)
    -   [4. Install Faveo](#3-gui-faveo-installer)
    -   [5. Configure cron job](#4-configure-cron-job)
    -   [6. Final step](#final-step)

<a id="prerequisites" name="prerequisites"></a>
## Prerequisites

-   **Apache** (with mod_rewrite enabled) 
-   **PHP 7.3+** with the following extensions: curl, dom, gd, json, mbstring, openssl, pdo_mysql, tokenizer, zip
-   **MySQL 5.7+** or **MariaDB 10.3+**

### a. LAMP Installation
Follow the [instructions here](https://github.com/teddysun/lamp)
If you follow this step, no need to install Apache, PHP, MySQL separetely as listed below

An editor like vim or nano should be useful too.
Run the following commands as sudoers or Login as root user by typing the command below

```sh
sudo su
```
### b. Update the packages

```sh
apt update
```

### e. PHP 7.3+

Note: In Debian upon installing PHP packages apache2 will be automatically installed and started 

```sh
apt install -y php7.3 libapache2-mod-php7.3 php7.3-mysql \
    php7.3-cli php7.3-common php7.3-fpm php7.3-soap php7.3-gd \
    php7.3-json php7.3-opcache  php7.3-mbstring php7.3-zip \
    php7.3-bcmath php7.3-intl php7.3-xml php7.3-curl  \
    php7.3-imap php7.3-ldap php7.3-gmp 
```

Now enable apache2 to start upon reboot.

```sh
systemctl enable apache2
```
After installing PHP 7.3, run the commands below to open PHP default config file.
```sh
nano /etc/php/7.3/fpm/php.ini
```

Then make the changes on the following lines below in the file and save. The value below are great settings to apply in your environments.

```
file_uploads = On
allow_url_fopen = On
short_open_tag = On
memory_limit = 256M
cgi.fix_pathinfo = 0
upload_max_filesize = 100M
max_execution_time = 360
```

<b>Setting Up ionCube</b>
```sh
wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz 
tar xvfz ioncube_loaders_lin_x86-64.tar.gz 
```
Make the note of path and directory from the above command.

Copy ioncube loader to Directory. Replace your *yourpath* below with actual path that was shown in the last step

```sh
php -i | grep extension_dir
cp ioncube/ioncube_loader_lin_7.3.so /usr/lib/php/'replaceyourpath'
sed -i '2 a zend_extension = "/usr/lib/php/'replaceyourpath'/ioncube_loader_lin_7.3.so"' /etc/php/7.3/apache2/php.ini
sed -i '2 a zend_extension = "/usr/lib/php/'replaceyourpath'/ioncube_loader_lin_7.3.so"' /etc/php/7.3/cli/php.ini
systemctl restart apache2 
```

### d. MariaDB:

The official Faveo installation uses Mysql as the database system and **this is the only official system we support**. While Laravel technically supports PostgreSQL and SQLite, we can't guarantee that it will work fine with Faveo as we've never tested it. Feel free to read [Laravel's documentation](https://laravel.com/docs/database#configuration) on that topic if you feel adventurous.

Install MariaDB. Note that this only installs the package, but does not setup Mysql. This is done later in the instructions:

```sh
apt install -y mariadb-server
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

First make the database a bit more secure.

```sh
mysql_secure_installation
```

Next log in with the root account to configure the database.

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

We have to authorize the new user on the `faveo` db so that he is allowed to change the database.

```sql
GRANT ALL ON faveo.* TO 'faveo'@'localhost';
```

And finally we apply the changes and exit the database.

```sql
FLUSH PRIVILEGES;
exit
```

<a id="5-configure-apache-webserver" name="5-configure-apache-webserver"></a>
### 3. Configure Apache webserver

<b>1. Give proper permissions to the project directory by running:</b>

```sh
sudo chown -R www-data:www-data /var/www/faveo
cd /var/www/faveo/
sudo find . -type f -exec chmod 644 {} \;
sudo find . -type d -exec chmod 755 {} \;
```

<b>2. Enable the rewrite module of the Apache webserver:</b>

```sh
a2enmod rewrite
```

<b>3. Configure a new Faveo site in apache by doing:</b>

Pick a editor of your choice copy the following and replace '--DOMAINNAME--' with the Domainname mapped to your Server's IP or you can just comment the 'ServerName' directive if Faveo is the only website served by your server.

```sh
nano /etc/apache2/sites-available/faveo.conf
```

```html
<VirtualHost *:80>
    ServerName --DOMAINNAME--

    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/faveo/public

    <Directory /var/www/faveo/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

<b>4. Apply the new `.conf` file and restart Apache and PHP-FPM. You can do that by running:</b>

```sh
a2dissite 000-default.conf
a2ensite faveo.conf
systemctl restart apache2
systemctl restart php7.3-fpm
```

### <b>4. Install Faveo</b>

Now you can install Faveo via [GUI](/docs/installation/installer/gui) Wizard or [CLI](/docs/installation/installer/cli)


<a id="4-configure-cron-job" name="4-configure-cron-job"></a>
### <b>5. Configure cron job</b>

Faveo requires some background processes to continuously run. 
Basically those crons are needed to receive emails
To do this, setup a cron that runs every minute that triggers the following command `php artisan schedule:run`.

Create a new `/etc/cron.d/faveo` file with:

```sh
echo "* * * * * www-data /usr/bin/php /var/www/faveo/artisan schedule:run 2>&1" | sudo tee /etc/cron.d/faveo
```

<a id="redis-installation" name="redis-installation"></a>
### <b>6. Redis Installation</b>

Redis is an open-source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.

This is an optional step and will improve system performance and is highly recommended.

[Redis installation documentation](/docs/installation/providers/enterprise/debian-redis)

<a id="ssl-installation" name="ssl-installation"></a>
### <b>7. SSL Installation</b>

Secure Sockets Layer (SSL) is a standard security technology for establishing an encrypted link between a server and a client. Let's Encrypt is a free, automated, and open certificate authority.

This is an optional step and will improve system security and is highly recommended.

[Let’s Encrypt SSL installation documentation](/docs/installation/providers/enterprise/debian-apache-ssl)

<a id="final-step" name="final-step"></a>
### <b>6. Final step</b>

The final step is to have fun with your newly created instance, which should be up and running to `http://localhost`.

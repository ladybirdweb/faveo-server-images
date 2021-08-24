---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/ubuntu-apache/
redirect_from:
  - /theme-setup/
last_modified_at: 2020-06-09
toc: true
---

# Installing Faveo Helpdesk Freelancer, paid and Enterprise on Ubuntu <!-- omit in toc -->


<img alt="Ubuntu" src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Logo-ubuntu_cof-orange-hex.svg/120px-Logo-ubuntu_cof-orange-hex.svg.png" width="120" height="120" />

Faveo can run on [Ubuntu 16.04 (Xenial Xerus),Ubuntu 18.04 (Bionic Beaver), Ubuntu 20.04 (Focal Fosa)](http://releases.ubuntu.com/18.04/).

- [<b>Installation steps :</b>](#binstallation-steps-b)
  - [<b>Prerequisites :</b>](#bprerequisites-b)
    - [<b>1.a. LAMP Installation</b>](#b1a-lamp-installationb)
    - [<b>1.b. Update your package list</b>](#b1b-update-your-package-listb)
    - [<b>1.c. Apache</b>](#b1c-apacheb)
    - [<b>2.a Install some Utility packages</b>](#b2a-install-some-utility-packagesb)
    - [<b>2.b. PHP 7.3+</b>](#b2b-php-73b)
    - [<b>2.c. Setting Up ionCube</b>](#b2c-setting-up-ioncubeb)
    - [<b>2.e. Mysql</b>](#b2e-mysqlb)
  - [Once the softwares above are installed:](#once-the-softwares-above-are-installed)
    - [<b>3. Upload Faveo</b>](#b3-upload-faveob)
    - [<b>4. Setup the database</b>](#b4-setup-the-databaseb)
    - [<b>5. Configure Apache webserver</b>](#b5-configure-apache-webserverb)
    - [<b>6. Configure cron job</b>](#b6-configure-cron-jobb)
    - [<b>7. Redis Installation</b>](#b7-redis-installationb)
    - [<b>8. SSL Installation</b>](#b8-ssl-installationb)
    - [<b>9. Install Faveo</b>](#b9-install-faveob)
    - [<b>10. Final step</b>](#b10-final-stepb)

<a id="installation-steps" name="installation-steps"></a>
# <b>Installation steps :</b>

<a id="prerequisites" name="prerequisites"></a>
## <b>Prerequisites :</b>

Faveo depends on the following:

-   **Apache** (with mod_rewrite enabled) 
-   **PHP 7.3+** with the following extensions: curl, dom, gd, json, mbstring, openssl, pdo_mysql, tokenizer, zip
-   **MySQL 5.7+** or **MariaDB 10.3+**

### <b>1.a. LAMP Installation</b>
Follow the [instructions here](https://github.com/teddysun/lamp)
If you follow this step, no need to install Apache, PHP, MySQL separetely as listed below

Run the following commands as sudoers or Login as root user by typing the command below

```sh
sudo su
```

### <b>1.b. Update your package list</b>

```sh
apt update && apt upgrade -y
```

### <b>1.c. Apache</b>
Apache should come pre-installed with your server. If it's not, install it with:

```sh
apt install apache2
systemctl start apache2
systemctl enable apache2
```
### <b>2.a Install some Utility packages</b>

```sh
apt install -y git wget curl unzip nano 
```

### <b>2.b. PHP 7.3+</b>

First add this PPA repository:

```sh
apt-get install -y software-properties-common
add-apt-repository ppa:ondrej/php
```

Then install php 7.3 with these extensions:

```sh
apt update
apt install -y php7.3 libapache2-mod-php7.3 php7.3-mysql \
    php7.3-cli php7.3-common php7.3-fpm php7.3-soap php7.3-gd \
    php7.3-json php7.3-opcache  php7.3-mbstring php7.3-zip \
    php7.3-bcmath php7.3-intl php7.3-xml php7.3-curl  \
    php7.3-imap php7.3-ldap php7.3-gmp php7.3-redis
```
After installing PHP 7.3, run the commands below to open PHP default config file.

```sh
nano /etc/php/7.3/apache2/php.ini
```

Then make the changes on the following lines below in the file and save. The value below are great settings to apply in your environment.

```
file_uploads = On
allow_url_fopen = On
short_open_tag = On
memory_limit = 256M
cgi.fix_pathinfo = 0
upload_max_filesize = 100M
post_max_size = 100M
max_execution_time = 360
```

### <b>2.c. Setting Up ionCube</b>
```sh
wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz 
tar xvfz ioncube_loaders_lin_x86-64.tar.gz 
```
Make the note of path and directory from the above command.

Copy ion cube loader to Directory. Replace your *yourpath* below with actual path that was shown with the first command below.

```sh
php -i | grep extension_dir
cp ioncube/ioncube_loader_lin_7.3.so /usr/lib/php/'replaceyourpath'
sed -i '2 a zend_extension = "/usr/lib/php/'replaceyourpath'/ioncube_loader_lin_7.3.so"' /etc/php/7.3/apache2/php.ini
sed -i '2 a zend_extension = "/usr/lib/php/'replaceyourpath'/ioncube_loader_lin_7.3.so"' /etc/php/7.3/cli/php.ini
systemctl restart apache2 
```

### <b>2.e. Mysql</b>

The official Faveo installation uses Mysql as the database system and **this is the only official system we support**. While Laravel technically supports PostgreSQL and SQLite, we can't guarantee that it will work fine with Faveo as we've never tested it. Feel free to read [Laravel's documentation](https://laravel.com/docs/database#configuration) on that topic if you feel adventurous.

Install Mysql 5.7. Note that this only installs the package, but does not setup Mysql. This is done later in the instructions:

 <b> For Ubuntu 16.04 and Ubuntu 18.04</b>
```sh
apt install -y mysql-server-5.7
systemctl start mysql
systemctl enable mysql
```
 <b> For Ubuntu 20.04 </b>
```sh
apt install -y mariadb-server-10.3
systemctl start mariadb
systemctl enable mariadb
```


Secure your MySql installation by executing the below command. Set Password for mysql root user, remove anonymous users, disallow remote root login, remove the test databases and finally reload the privilege tables.
```sh
mysql_secure_installation 
```

**phpMyAdmin(Optional):** Install phpMyAdmin. This is optional step. phpMyAdmin gives a GUI to access and work with Database

```sh
apt install phpmyadmin
```


## Once the softwares above are installed:


<a id="3-upload-faveo" name="3-upload-faveo"></a>
### <b>3. Upload Faveo</b>
Please download Faveo Helpdesk from [https://billing.faveohelpdesk.com](https://billing.faveohelpdesk.com) and upload it to below directory

```sh
mkdir -p /var/www/faveo
cd /var/www/faveo
```
**3.a** <b>Extracting the Faveo-Codebase zip file</b>
```sh
unzip "Filename.zip" -d /var/www/faveo
```
 Give proper permissions to the project directory by running:

```sh
chown -R www-data:www-data /var/www/faveo
cd /var/www/faveo/
find . -type f -exec chmod 644 {} \;
find . -type d -exec chmod 755 {} \;
```
<a id="4-setup-the-database" name="4-setup-the-database"></a>
### <b>4. Setup the database</b>

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
### <b>5. Configure Apache webserver</b>

 **5.a.** <b>Configure a new faveo site in apache by doing:</b>

Pick a editor of your choice copy the following and replace '--DOMAINNAME--' with the Domainname mapped to your Server's IP or you can just comment the 'ServerName' directive if Faveo is the only website served by your server.
```sh
nano /etc/apache2/sites-available/faveo.conf
```

```apache
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
# Uncomment the below lines and replace the Server-IP and Domainame to configure IP to Domainname rewrite rule
#    RewriteEngine on
#    RewriteCond %{HTTP_HOST} ^--Server-IP--
#    RewriteRule (.*) http://--Domainname--
</VirtualHost>
```
**5.b.** <b>Enable the rewrite module and disable default site of the Apache webserver:</b>

```sh
a2enmod rewrite
a2dissite 000-default.conf
a2ensite faveo.conf
# Enable php7.3 fpm, and restart apache
a2enmod proxy_fcgi setenvif
a2enconf php7.3-fpm
```
 **5.c.** <b>Apply the new `.conf` file and restart Apache and PHP-FPM. You can do that by running:</b>

```sh
service php7.3-fpm restart
service apache2 restart
```

<a id="6-configure-cron-job" name="6-configure-cron-job"></a>
### <b>6. Configure cron job</b>

Faveo requires some background processes to continuously run. 
Basically those crons are needed to receive emails
To do this, setup a cron that runs every minute that triggers the following command `php artisan schedule:run`.Verify your php ececutable location and replace it accordingly in the below command.

Create a new `/etc/cron.d/faveo` file with:

```sh
echo "* * * * * www-data /usr/bin/php /var/www/faveo/artisan schedule:run 2>&1" | sudo tee /etc/cron.d/faveo
```

<a id="redis-installation" name="redis-installation"></a>
### <b>7. Redis Installation</b>

Redis is an open-source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.

This is an optional step and will improve system performance and is highly recommended.

[Redis installation documentation](/docs/installation/providers/enterprise/ubuntu-redis)

<a id="ssl-installation" name="ssl-installation"></a>
### <b>8. SSL Installation</b>

Secure Sockets Layer (SSL) is a standard security technology for establishing an encrypted link between a server and a client. Let's Encrypt is a free, automated, and open certificate authority.

This is an optional step and will improve system security and is highly recommended.

[Let’s Encrypt SSL installation documentation](/docs/installation/providers/enterprise/ubuntu-apache-ssl)

<a id="3-gui-faveo-installer" name="3-gui-faveo-installer"></a>
### <b>9. Install Faveo</b>
At this point if the domainname is propagated properly with your server's IP you can open Faveo in browser just by entering your domainname.
You can also check the Propagation update by Visiting this site www.whatsmydns.net.

Now you can install Faveo via [GUI](/docs/installation/installer/gui) Wizard or [CLI](/docs/installation/installer/cli)


<a id="final-step" name="final-step"></a>
### <b>10. Final step</b>

The final step is to have fun with your newly created instance, which should be up and running to `http://localhost` or the domain you have configured Faveo with.
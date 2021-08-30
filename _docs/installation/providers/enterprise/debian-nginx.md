---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/debian-nginx/
redirect_from:
  - /theme-setup/
last_modified_at: 2020-06-09
toc: true
---

# Installing Faveo Helpdesk Freelancer, paid and Enterprise on Debian <!-- omit in toc -->


<img alt="Debian" src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Debian-OpenLogo.svg/109px-Debian-OpenLogo.svg.png" width="120" height="120" />

Faveo can run on Debian 10(Buster).

- [<strong>Installation steps :</strong>](#installation-steps-)
    - [<strong>1. LAMP Installation</strong>](#1-lamp-installation)
    - [<strong>2. Update your package list</strong>](#2-update-your-package-list)
    - [<strong>3. Upload Faveo</strong>](#3-upload-faveo)
    - [<strong>4. Setup the database</strong>](#4-setup-the-database)
    - [<strong>5. Configure Nginx webserver</strong>](#5-configure-nginx-webserver)
    - [<strong>6. Configure cron job</strong>](#6-configure-cron-job)
    - [<strong>7. Redis Installation</strong>](#7-redis-installation)
    - [<strong>8. SSL Installation</strong>](#8-ssl-installation)
    - [<strong>9. Install Faveo</strong>](#9-install-faveo)
    - [<strong>10. Final step</strong>](#10-final-step)

<a id="installation-steps" name="installation-steps"></a>
# <strong>Installation steps :</strong>


Faveo depends on the following:

-   **Apache** (with mod_rewrite enabled) 
-   **PHP 7.3+** with the following extensions: curl, dom, gd, json, mbstring, openssl, pdo_mysql, tokenizer, zip
-   **MySQL 5.7+** or **MariaDB 10.3+**

### <strong>1. LAMP Installation</strong>
Follow the [instructions here](https://github.com/teddysun/lamp)
If you follow this step, no need to install Apache, PHP, MySQL separetely as listed below

Run the following commands as sudoers or Login as root user by typing the command below

```sh
sudo su
```

### <strong>2. Update your package list</strong>
```sh
apt update && apt upgrade -y
```

<b>2.a. Nginx</b>
Apache should come pre-installed with your server. If it's not, install it with:

```sh
apt install nginx
systemctl start nginx
systemctl enable nginx
```
<b>2.b. Install some Utility packages</b>

```sh
apt install -y git wget curl unzip nano 
```

<b>2.c. PHP 7.3+</b>
Note: In Debian upon installing PHP packages apache2 will be automatically installed. so it needs to be removed later. 

```sh
apt install -y php7.3 libapache2-mod-php7.3 php7.3-mysql \
    php7.3-cli php7.3-common php7.3-fpm php7.3-soap php7.3-gd \
    php7.3-json php7.3-opcache  php7.3-mbstring php7.3-zip \
    php7.3-bcmath php7.3-intl php7.3-xml php7.3-curl  \
    php7.3-imap php7.3-ldap php7.3-gmp php7.3-redis
```
Now remove the apache2 package
```sh
apt remove apache2
```
After installing PHP 7.3, run the commands below to open PHP default config file for Nginx…

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

<b>2.d.Setting Up ionCube</b>
```sh
wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz 
tar xvfz ioncube_loaders_lin_x86-64.tar.gz 
```
Make the note of path and directory from the above command.

Copy ion cube loader to Directory. Replace your *yourpath* below with actual path that was shown with the first command below.
```sh
php -i | grep extension_dir
cp ioncube/ioncube_loader_lin_7.3.so /usr/lib/php/'replaceyourpath'
sed -i '2 a zend_extension = "/usr/lib/php/'replaceyourpath'/ioncube_loader_lin_7.3.so"' /etc/php/7.3/fpm/php.ini
sed -i '2 a zend_extension = "/usr/lib/php/'replaceyourpath'/ioncube_loader_lin_7.3.so"' /etc/php/7.3/cli/php.ini
systemctl restart nginx 
systemctl restart php7.3-fpm
```

<b>2.e. Mysql</b>

The official Faveo installation uses Mysql as the database system and **this is the only official system we support**. While Laravel technically supports PostgreSQL and SQLite, we can't guarantee that it will work fine with Faveo as we've never tested it. Feel free to read [Laravel's documentation](https://laravel.com/docs/database#configuration) on that topic if you feel adventurous.

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



Once the softwares above are installed:


<a id="3-upload-faveo" name="3-upload-faveo"></a>
### <strong>3. Upload Faveo</strong>
Please download Faveo Helpdesk from [https://billing.faveohelpdesk.com](https://billing.faveohelpdesk.com) and upload it to below directory

```sh
mkdir /var/www/faveo
cd /var/www/faveo
```
<b>3.a Extracting the Faveo-Codebase zip file</b>

```sh
unzip "Filename.zip" -d /var/www/faveo
```

<a id="4-setup-the-database" name="4-setup-the-database"></a>
### <strong>4. Setup the database</strong>

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

### <strong>5. Configure Nginx webserver</strong>

 <b> 5.a. Give proper permissions to the project directory by running:</b>

```sh
chown -R www-data:www-data /var/www/faveo
cd /var/www/faveo/
find . -type f -exec chmod 644 {} \;
find . -type d -exec chmod 755 {} \;
```

 <b>5.b. Create a copy of Nginx default config file</b>
Finally, configure Nginx site configuration file for Faveo. This file will control how users access Faveo content. Run the commands below to create a new configuration file called faveo

```
nano /etc/nginx/sites-available/faveo
```
Then copy and paste the content below into the file and save it. Replace the highlighted line with your own domain name and directory root location.
```
server {
    listen 80;
    listen [::]:80;
    root /var/www/faveo/public;
    index  index.php index.html index.htm;
    server_name  example.com www.example.com;

     client_max_body_size 100M;

    location / {
        try_files $uri $uri/ /index.php?$query_string;       
    }

    location ~ \.php$ {
               include snippets/fastcgi-php.conf;
               fastcgi_pass unix:/var/run/php/php7.3-fpm.sock;
               fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
               include fastcgi_params;
    }
}
```
Save the file and exit.

<b> 5.c. Enable the Faveo and remove the default site</b>
After configuring the VirtualHost above delete the deafult Virtualhost and  enable the Faveo Virtualhost by running the commands below

```sh
rm -f /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/faveo /etc/nginx/sites-enabled/
systemctl restart nginx
systemctl restart php7.3-fpm
```

<a id="6-configure-cron-job" name="6-configure-cron-job"></a>
### <strong>6. Configure cron job</strong>

Faveo requires some background processes to continuously run. 
Basically those crons are needed to receive emails
To do this, setup a cron that runs every minute that triggers the following command `php artisan schedule:run`.

Create a new `/etc/cron.d/faveo` file with:

```sh
echo "* * * * * www-data /usr/bin/php /var/www/faveo/artisan schedule:run 2>&1" | sudo tee /etc/cron.d/faveo
```

<a id="redis-installation" name="redis-installation"></a>
### <strong>7. Redis Installation</strong>

Redis is an open-source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.

This is an optional step and will improve system performance and is highly recommended.

[Redis installation documentation](/docs/installation/providers/enterprise/debian-redis)

<a id="ssl-installation" name="ssl-installation"></a>
### <strong>8. SSL Installation</strong>

Secure Sockets Layer (SSL) is a standard security technology for establishing an encrypted link between a server and a client. Let's Encrypt is a free, automated, and open certificate authority.

This is an optional step and will improve system security and is highly recommended.

[Let’s Encrypt SSL installation documentation](/docs/installation/providers/enterprise/debian-nginx-ssl)

<a id="9-gui-faveo-installer" name="9-gui-faveo-installer"></a>
### <strong>9. Install Faveo</strong>
At this point if the domainname is propagated properly with your server’s IP you can open Faveo in browser just by entering your domainname. You can also check the Propagation update by Visiting this site www.whatsmydns.net.

Now you can install Faveo via [GUI](/docs/installation/installer/gui) Wizard or [CLI](/docs/installation/installer/cli)

<a id="final-step" name="final-step"></a>
### <strong>10. Final step</strong>

The final step is to have fun with your newly created instance, which should be up and running to `http://localhost` or the domain you have configured Faveo with.

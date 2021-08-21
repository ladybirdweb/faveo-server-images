---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/centos-apache/
redirect_from:
  - /theme-setup/
last_modified_at: 2020-06-09
toc: true
---
# Installing Faveo Helpdesk Freelancer, Paid and Enterprise on Cent OS <!-- omit in toc -->

<img alt="Cent OS Logo" src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Centos-logo-light.svg/300px-Centos-logo-light.svg.png" width="200"  />

Faveo can run on [Cent OS 7 ](https://www.centos.org/download/).

- [Prerequisites](#prerequisites)
  - [<b> 1. LAMP Installation</b>](#b-1-lamp-installationb)
  - [<b> 2.a Update your Packages and install some utility tools</b>](#b-2a-update-your-packages-and-install-some-utility-toolsb)
  - [<b>b. Install php-7.3 Packages </b>](#bb-install-php-73-packages-b)
  - [<b> For Cent-OS 7</b>](#b-for-cent-os-7b)
  - [<b>c. Install and run Apache</b>](#bc-install-and-run-apacheb)
  - [<b>d. Setting Up ionCube</b>](#bd-setting-up-ioncubeb)
  - [<b> e. Install and run Mysql/MariaDB</b>](#b-e-install-and-run-mysqlmariadbb)
  - [<b>For Cent-OS 7</b>](#bfor-cent-os-7b)
- [Installation steps](#installation-steps)
  - [1. Upload Faveo](#1-upload-faveo)
  - [1.a Extracting the Faveo-Codebase zip file](#1a-extracting-the-faveo-codebase-zip-file)
  - [2. Setup the database](#2-setup-the-database)
  - [3. Configure Apache webserver](#3-configure-apache-webserver)
  - [4. Configure cron job](#4-configure-cron-job)
  - [5. Redis Installation](#5-redis-installation)
  - [6. SSL Installation](#6-ssl-installation)
  - [7. Install Faveo](#7-install-faveo)
  - [8. Final step](#8-final-step)


<a id="prerequisites" name="prerequisites"></a>
## Prerequisites

Faveo depends on the following:

-   **Apache** (with mod_rewrite enabled) 
-   **PHP 7.3+** with the following extensions: curl, dom, gd, json, mbstring, openssl, pdo_mysql, tokenizer, zip
-   **MySQL 5.7+** or **MariaDB 10.3+**

### <b> 1. LAMP Installation</b>
Follow the [instructions here](https://github.com/teddysun/lamp)
If you follow this step, no need to install Apache, PHP, MySQL separetely as listed below


### <b> 2.a Update your Packages and install some utility tools</b>

Login as root user by typing the command below

```sh
sudo su
```
```sh
yum update -y && yum install unzip wget nano yum-utils curl openssl git -y
```

###  <b>b. Install php-7.3 Packages </b>
### <b> For Cent-OS 7</b>
```sh
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm 
yum install -y https://mirror.webtatic.com/yum/el7/webtatic-release.rpm 
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm 

yum-config-manager --enable remi-php73
yum -y install php php-cli php-common php-fpm php-gd php-mbstring php-pecl-mcrypt php-mysqlnd php-odbc php-pdo php-xml  php-opcache php-imap php-bcmath php-ldap php-pecl-zip php-soap php-redis
```

###  <b>c. Install and run Apache</b>
Install and Enable Apache Server

```sh
yum install -y httpd
systemctl start httpd
systemctl enable httpd
```

### <b>d. Setting Up ionCube</b>
```sh
wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
tar xfz ioncube_loaders_lin_x86-64.tar.gz
```
Copy ioncube loader to PHP modules Directory.

```sh
php -i | grep extension_dir
cp ioncube/ioncube_loader_lin_7.3.so /usr/lib64/php/modules 
sed -i '2 a zend_extension = "/usr/lib64/php/modules/ioncube_loader_lin_7.3.so"' /etc/php.ini
sed -i "s/max_execution_time = .*/max_execution_time = 300/" /etc/php.ini
```

### <b> e. Install and run Mysql/MariaDB</b>

The official Faveo installation uses Mysql as the database system and **this is the only official system we support**. While Laravel technically supports PostgreSQL and SQLite, we can't guarantee that it will work fine with Faveo as we've never tested it. Feel free to read [Laravel's documentation](https://laravel.com/docs/database#configuration) on that topic if you feel adventurous.

Note: Currently Faveo supports only Mysql-5.7 and MariaDB-10.3.
Note: The below steps only installs the package, but does not setup the database required by Faveo. This is done later in the instructions.
### <b>For Cent-OS 7</b>
```sh
yum install -y https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
yum install -y mysql-community-server
systemctl start mysqld
systemctl enable mysqld
```
Secure your MySql installation by executing the below command. Set Password for mysql root user,it will ask for password which is temporarily created by MySql-5.7 and it is required for changing the root password, we can get by running the below command and here in mysql-5.7 password validator will be enabled upon installation so you need provide a strong password combination of Uppercase, Lowercase, alphanumeric and special symbols, remove anonymous users, disallow remote root login, remove the test databases and finally reload the privilege tables.

```sh
grep "temporary password" /var/log/mysqld.log
mysql_secure_installation 
```

**phpMyAdmin(Optional):** Install phpMyAdmin. This is optional step. phpMyAdmin gives a GUI to access and work with Database

```sh
yum install -y phpmyadmin
```
At this point run the belove command to clear the yum cache.
```sh
yum clean all
```

<a id="installation-steps" name="installation-steps"></a>
## Installation steps

Once the softwares above are installed:


<a id="1-upload-faveo" name="1-upload-faveo"></a>
### 1. Upload Faveo
Please download Faveo Helpdesk from [https://billing.faveohelpdesk.com](https://billing.faveohelpdesk.com) and upload it to below directory

```sh
mkdir -p /var/www/faveo/
cd /var/www/faveo/
```
### 1.a Extracting the Faveo-Codebase zip file

```sh
unzip "Filename.zip" -d /var/www/faveo
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
### 3. Configure Apache webserver

**a.** <b>Give proper permissions to the project directory by running:</b>

```sh
chown -R apache:apache /var/www/faveo
cd /var/www/faveo
find . -type f -exec chmod 644 {} \;
find . -type d -exec chmod 755 {} \;
```
By default SELINUX will be Enforcing run the follwing comand to switch it to Permissive mode and restart the machine once in order to take effect.
```sh
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
reboot -f
```

**b.** <b>Enable the rewrite module of the Apache webserver:</b>

Check whether the Module exists in Apache modules directory.

```sh
ls /etc/httpd/modules | grep mod_rewrite
```
Check if the module is loaded
```sh
grep -i LoadModule /etc/httpd/conf/httpd.conf | grep rewrite
```
If the output af the above command is blank then add the below line in /etc/httpd/conf/httpd.conf

```sh
LoadModule rewrite_module modules/mod_rewrite.so
```

Finally change the httpd.conf AllowOverride value to none to All under <Directory /var/www/> section.
```sh
<Directory "/var/www">
    AllowOverride All 
    # Allow open access:
    Require all granted
</Directory>
```

**c.** <b>Configure a new faveo site in apache by doing:</b>

Pick a editor of your choice copy the following and replace '--DOMAINNAME--' with the Domain name mapped to your Server's IP or you can just comment the 'ServerName' directive if Faveo is the only website served by your server.
```sh
nano /etc/httpd/conf.d/faveo.conf
```



```apache

<VirtualHost *:80> 
ServerName --DOMAINNAME-- 
ServerAdmin webmaster@localhost 
DocumentRoot /var/www/faveo/public 
<Directory /var/www/faveo> 
AllowOverride All 
</Directory> 
ErrorLog /var/log/httpd/faveo-error.log 
CustomLog /var/log/httpd/faveo-access.log combined
</VirtualHost>
```

**d.** Apply the new `.conf` file and restart Apache. You can do that by running:

```sh
systemctl restart httpd.service
```


<a id="3-gui-faveo-installer" name="3-gui-faveo-installer"></a>


<a id="4-configure-cron-job" name="4-configure-cron-job"></a>
### 4. Configure cron job

Faveo requires some background processes to continuously run. 
Basically those crons are needed to receive emails
To do this, setup a cron that runs every minute that triggers the following command `php artisan schedule:run`. Verify your php ececutable location and replace it accordingly in the below command.

Create a new `/etc/cron.d/faveo` file with:

```sh
echo "* * * * * apache /bin/php /var/www/faveo/artisan schedule:run 2>&1" | sudo tee /etc/cron.d/faveo
```


<a id="redis-installation" name="redis-installation"></a>
### 5. Redis Installation

Redis is an open-source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.

This is an optional step and will improve system performance and is highly recommended.

[Redis installation documentation](/docs/installation/providers/enterprise/centos-redis)

<a id="ssl-installation" name="ssl-installation"></a>
### 6. SSL Installation

Secure Sockets Layer (SSL) is a standard security technology for establishing an encrypted link between a server and a client. Let's Encrypt is a free, automated, and open certificate authority.

This is an optional step and will improve system security and is highly recommended.

[Let’s Encrypt SSL installation documentation](/docs/installation/providers/enterprise/centos-apache-ssl)

<a id="final-step" name="final-step"></a>
### 7. Install Faveo

At this point if the domainname is propagated properly with your server's IP you can open Faveo in browser just by entering your domainname.
You can also check the Propagation update by Visiting this site www.whatsmydns.net.

Now you can install Faveo via [GUI](/docs/installation/installer/gui) Wizard or [CLI](/docs/installation/installer/cli).
### 8. Final step

The final step is to have fun with your newly created instance, which should be up and running to `http://localhost` or the domain you have configured Faveo with.

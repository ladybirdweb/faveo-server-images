---
layout: single
type: docs
permalink: /docs/installation/providers/community/cpanel/
redirect_from:
  - /theme-setup/
last_modified_at: 2020-06-09
toc: true
title: "Installing Faveo Helpdesk on cPanel"
---

Faveo is a self-hosted software where you can install the software by yourself on your own servers. While the installer provides step by step guide during the installation, it's important and helpful to have general knowledge about Web servers, PHP and MySQL.

Before getting started make sure your server meets following minimum requirement required to install and use Faveo as listed [here](docs/system-requirement/requirement/)

## Getting Started

Download the latest version of Faveo from [https://billing.faveohelpdesk.com](https://billing.faveohelpdesk.com) and upload the .zip files in the folder of your choice on your server.


## Steps for Faveo Installation in CPanel:

- Login to your CPanel with valid credentials.
- Navigate to File Manager and click on the Public_html.

<img alt="" src="https://lh6.googleusercontent.com/QvogNHnM9veEU-FO2RBah-5BlD0bqhL3Tp_2Td2R2aunRBxwEbbKfCkmbb9DhW9TT9IwkFh8RdDScutANFZ01rHFrx8O5V_EU71NSbDgTjsrGLulJcv5b74Tc_FeoYHlD1TwVbMu"  />

<img alt="" src="https://lh6.googleusercontent.com/Tix0BlPoyjxHnYHEnNnen6bYjA1MByWDrLa_wvDZn3Kvgy2O564JzXwoNLZG9ZbOazgCSspzx61OwchYdyVBWl1GIE_tPohKfeSWnB4ZIMbbRkAe-QUawpBdmSYFCRryag0-ZZ1C"  />

Once you land to the File Manager > Public-HTML, Click on the Folder icon at the top left of CPanel, to create a new folder where your faveo need to be hosted.
 
<img alt="" src="https://lh4.googleusercontent.com/K6s9RwFFuKwf_xJxh27op-I8yZVauLZckirVkeP0UBFbVpz9qIVUO6WM3x5OBKjePGDWo0LZERLK4xDKE5nMu6iccF92c_mmBEk7gDv14-MkM4aiO_Z0JPJCtmLtgpGzsrgtOPai"  />

Click on Folder which you have created and upload the software .zip file. (Or) You can also create a subdomain to upload the file.

You can click on the Upload button in CPanel. (Or) You can also upload the file from FTP. (File Zilla)
 
<img alt="" src="https://lh4.googleusercontent.com/KtwiXeXp0U5ps9-wBBsdfLPzQ_6bBEpifNBT-tUkYcYF0LVLey7G0AOZ6xcZ-RMBV0GQ9Tf0_6rMpob6fDzXBiiwAl4rErmNAszxSNJ7qRz7CNqS8WPs8fe_HP9FCsPy3_nSUFo4"  />

Select the .zip file of the software from your local system. Once it is uploaded click on the “Go back to home/….” and Right-click on the .zip file and extract it.

<img alt="" src="https://lh3.googleusercontent.com/-G70yy2sOPWNWW8e9mVqA1vSs0xRIrxr9AeWipZtoMtig9403C_JiJNChrfUiTjCRdDf1cTLnVLSYphV5d4HvSDBYMaYI3jkmfgtf0JkuGgdlw3PaaOWTjXGG2YKmQU-NLJkYuis"  />

<img alt="" src="https://lh3.googleusercontent.com/lS7h_sWqffJV9hHM7gFDaKN_rvoNNkxsKmIcylVfqIyEhm2KLbmR5srjo2EqCuCB1f920XPLt62QUdKZJN6oSbXZK8ASq4m2ZwIkZzRQQG43F_-2qqhbhyJh5TIYLk1dxGmUz_m0"  />

Once the file is extracted with the folder delete the .zip file.

<img alt="" src="https://lh6.googleusercontent.com/aakdQj86xOzfvi9wgGaRFN71TkpMIQRfAYCRx4I68XssU9fkkcvH9OJvzvd8tkIScnhkZONtedAFo6UWSTUY8nYCtI_YuNsjcW2kBjbadyKAj3kSVz2LExid9_XY_4xz7lpLkND4"  />

Double click on the extracted folder and select all the files, Right-click on it and you will get an option “Move” click on the option and move the files to the main folder. 

Creating a Database:

Navigate to CPanel > MySQL and Database and click on it.

<img alt="" src="https://lh4.googleusercontent.com/aLfs9EGYVnk3m2iPALGwmK_bOqns5mJSD2AQE-LOQDLioZWCBzx_dDsWWE2cuqjfLIspPj52U6QHHJ31AMfS_vkCIkjufhjEb_4LMN1vBYXUR1EJ4BXhyv5hhHsHOOVzEGXN9Lc-"  />

Once you land to the page Create a New Database.

<img alt="" src="https://lh5.googleusercontent.com/Wi-ZYJObYIE0LnjSx-tzu113Ze-J6raxZCNLPgK2Kbh5hrkMNjaLb9nhUSzS61ldK697OeBudr_ZcYKYMwIRjRzDgXHhlCqzMrS-OqqoyF5EWHz7uyHSU-W_9XzUjsd65SDlpFmI"  />

Create a new user for the database by registering the user name in the specified box.

<img alt="" src="https://lh6.googleusercontent.com/ZAAs160phqKUZReeOoUKoHgoArdebNwxMait4rAn5eFEXn1AsyOU29w2l8igfBHBTcLAjQS7hHCVIbPb6KjQP2dSb7VgCe5Z6HG9PXFyMFTz-6rhjR3EZF6s6XsM7Yu2oGZa8QMg"  />

You can register the Password of your own in the specified boxes. (Or) you can use the Password generator to generate a new password for the user.

Now click on the Create User button to create a user and set the access for the user.

<img alt="" src="https://lh6.googleusercontent.com/HFGhvCd3mWw8LlKhi2R8bQik4ZhL9K6Ui_8-FIxEd5sdDSlUiH3zhiwR_pp7kOBpjAEE4W9phbFu6DzV3B4JfQP3DvWvZsW5lFyRq1rKlM0cAbpLuazcwN7x8cqtoRZjscdXrM6M"  />

In Manage User Privileges, you can give access privileges (Choose All Privileges checkbox) ) to the newly created user and click on the Make Changes button save the details. Click on “Go back” to get the database page.

Now link the newly created user with the Database you have created, under Add New User to Database. Select the Database name from the list for which the user needs to be added and select the user name to add with the DB.

<img alt="" src="https://lh5.googleusercontent.com/IZIPudyrGRC92QQXVAQiIpTozEuJeseyj9r4q-23AvDu_etpKkp3tVzFgatr1D7NPqmVW_q1tPo9Hw_oh4d6lpJo9KhOp60Ba-nH-198LyIKEUxskkl1FjeajVS90vUS9HqUCg6x"  />

Once all this is done you can install the faveo via Web GUI. To know more about Faveo Web GUI Installation please refer the below-given link: https://support.faveohelpdesk.com/show/web-gui-installer

Note:

When you are installing Faveo in your own servers it's necessary to set the cron job schedulers in your servers (CPanel > Crons Jobs > Add New Cron Job) to perform certain tasks automatically in the system.

<img alt="" src="https://lh6.googleusercontent.com/SDTOXrj74XAcbuRVAFGhCwqXJ_y7WRG7GzRqy3x7FGMmpzmszahkM7udnnERWLkuCugdqwrNe5UXDWqk443GhIlM9VEV2yhhxk-N-ntJmgpmqIWAp3l1AK13Xpsth3hP1wxr-W8E"  />

You can also use an FTP application to transfer the files from the Local System and upload the files in CPanel and install it on your server. To do so Click on the FileZilla or any other FTP Applications.

<img alt="" src="https://lh3.googleusercontent.com/kIyQkN2XFgJjTSHn4vUk0KifPeS_wUwe5qqoRvCDpGxIyFesmz5KJ8w21fil0yXKNUtGP6Vf9YE8CNBFtiWusQ20iIR-G4QtDmyJzTKQNS9JNbUoGGod_8d0TgwqU4HX7MckU1QF"  />

Select the file and right-click on the file. You will get an upload option to upload the file. Click on it your files will be added to CPanel. Once uploaded login to your CPanel and extract the files follow the same steps given above for file extracting and installing the software.

Faveo can be also installed via a CLI installer. 


 <!-- omit in toc -->


<img alt="Ubuntu" src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Logo-ubuntu_cof-orange-hex.svg/120px-Logo-ubuntu_cof-orange-hex.svg.png" width="120" height="120" />

Faveo can run on [Ubuntu 18.04 (Bionic Beaver)](http://releases.ubuntu.com/18.04/).

-   [Prerequisites](#prerequisites)
-   [Installation steps](#installation-steps)
    -   [1. Upload Faveo](#1-upload-faveo)
    -   [2. Setup the database](#2-setup-the-database)
    -   [3. Configure Apache webserver](#5-configure-apache-webserver)
    -   [4. Install Faveo](#3-gui-faveo-installer)
    -   [5. Configure cron job](#4-configure-cron-job)
    -   [6. Redis Installation](#redis-installation)
    -   [7. SSL Installation](#ssl-installation)
    -   [8. Final step](#final-step)


<a id="prerequisites" name="prerequisites"></a>
## Prerequisites

Faveo depends on the following:

-   **Apache** (with mod_rewrite enabled) 
-   **Git**
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
apt update
apt upgrade -y
```

### c. Apache
Apache should come pre-installed with your server. If it's not, install it with:

```sh
apt install apache2
systemctl start apache2
systemctl enable apache2
```

### d. Git
Git should come pre-installed with your server. If it's not, install it with:

```sh
sudo apt update
sudo apt install -y git
```

### e. PHP 7.3+

First add this PPA repository:

```sh
apt-get install -y software-properties-common
add-apt-repository ppa:ondrej/php
```

Then install php 7.3 with these extensions:

```sh
sudo apt update
sudo apt install -y php7.3 libapache2-mod-php7.3 php7.3-mysql \
    php7.3-cli php7.3-common php7.3-fpm php7.3-soap php7.3-gd \
    php7.3-json php7.3-opcache  php7.3-mbstring php7.3-zip \
    php7.3-bcmath php7.3-intl php7.3-xml php7.3-curl  \
    php7.3-imap php7.3-ldap php7.3-gmp 
```
After installing PHP 7.3, run the commands below to open PHP default config file for Nginx…

```sh
sudo nano /etc/php/7.3/fpm/php.ini
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
date.timezone = America/Chicago
```

<b>Setting Up ionCube</b>
```sh
wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz 
tar xvfz ioncube_loaders_lin_x86-64.tar.gz 
php -i | grep extension_dir
```
Make the note of path and directory from the above command.

Copy ion cube loader to Directory. Replace your *yourpath* below with actual path that was shown in the last step

```sh
cp ioncube/ioncube_loader_lin_7.3.so /usr/lib/php/yourpath
sed -i '2 a zend_extension = "/usr/lib/php/yourpath/ioncube_loader_lin_7.3.so"' /etc/php/7.3/apache2/php.ini
sed -i '2 a zend_extension = "/usr/lib/php/yourpath/ioncube_loader_lin_7.3.so"' /etc/php/7.3/cli/php.ini
systemctl restart apache2 
```

<b>PHP.INI Changes</b>
After install PHP, run the commands below to open PHP-FPM default file.

```sh
sudo nano /etc/php/7.3/fpm/php.ini             
```

Then make the change the following lines below in the file and save.

```sh
file_uploads = On
allow_url_fopen = On
memory_limit = 256M
upload_max_filesize = 64M
max_execution_time = 360
date.timezone = America/Chicago
```
### f. Mysql

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

**phpMyAdmin(Optional):** Install phpMyAdmin. This is optional step. phpMyAdmin gives a GUI to access and work with Database

```sh
sudo apt install phpmyadmin
```


<a id="installation-steps" name="installation-steps"></a>
## Installation steps

Once the softwares above are installed:


<a id="1-upload-faveo" name="1-upload-faveo"></a>
### 1. Upload Faveo

You may install Faveo by simply cloning the repository. In order for this to work with Apache, you need to clone the repository in a specific folder:

```sh
cd /var/www/faveo
git clone https://github.com/ladybirdweb/faveo-helpdesk.git
```

You should check out a tagged version of Faveo since `master` branch may not always be stable. Find the latest official version on the [release page](https://github.com/ladybirdweb/faveo-helpdesk/releases)


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

#### a. Give proper permissions to the project directory by running:

```sh
sudo chown -R www-data:www-data /var/www/faveo
sudo chmod -R 775 /var/www/faveo/storage
```

#### b. Enable the rewrite module of the Apache webserver:

```sh
sudo a2enmod rewrite
```

#### c. Configure a new faveo site in apache by doing:

```sh
sudo nano /etc/apache2/sites-available/faveo.conf
```

Then, in the `nano` text editor window you just opened, copy the following - swapping the `**YOUR IP ADDRESS/DOMAIN**` with your server's IP address/associated domain:

```apache
<VirtualHost *:80>
    ServerName **YOUR IP ADDRESS/DOMAIN**

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

#### d. Apply the new `.conf` file and restart Apache. You can do that by running:

```sh
sudo a2dissite 000-default.conf
sudo a2ensite faveo.conf

# Enable php7.3 fpm, and restart apache
sudo a2enmod proxy_fcgi setenvif
sudo a2enconf php7.3-fpm
sudo service php7.3-fpm restart
sudo service apache2 restart
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
echo "* * * * * www-data /usr/bin/php7.3 /var/www/faveo/artisan schedule:run 2>&1" | sudo tee /etc/cron.d/faveo
```

<a id="redis-installation" name="redis-installation"></a>
### 6. Redis Installation

Redis is an open-source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.

This is an optional step and will improve system performance and is highly recommended.

[Redis installation documentation](/faveo-server-images/docs/installation/providers/enterprise/ubuntu-redis)

<a id="ssl-installation" name="ssl-installation"></a>
### 7. SSL Installation

Secure Sockets Layer (SSL) is a standard security technology for establishing an encrypted link between a server and a client. Let's Encrypt is a free, automated, and open certificate authority.

This is an optional step and will improve system security and is highly recommended.

[Let’s Encrypt SSL installation documentation](/faveo-server-images/docs/installation/providers/enterprise/ubuntu-apache-ssl)

<a id="final-step" name="final-step"></a>
### 8. Final step

The final step is to have fun with your newly created instance, which should be up and running to `http://localhost`.

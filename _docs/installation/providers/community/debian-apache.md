# Installing Faveo Helpdesk Community on Debian <!-- omit in toc -->

<img alt="Logo" src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Debian-OpenLogo.svg/109px-Debian-OpenLogo.svg.png" width="96" height="127" />

Faveo can run on Debian Buster.

-   [Prerequisites](#prerequisites)
-   [Installation steps](#installation-steps)
    -   [1. Clone the repository](#1-clone-the-repository)
    -   [2. Setup the database](#2-setup-the-database)
    -   [3. Configure Apache webserver](#5-configure-apache-webserver)
    -   [4. Install Faveo](#3-gui-faveo-installer)
    -   [5. Configure cron job](#4-configure-cron-job)
    -   [6. Final step](#final-step)

## Prerequisites

-   **Apache** (with mod_rewrite enabled) 
-   **Git**
-   **PHP 7.3+** with the following extensions: curl, dom, gd, json, mbstring, openssl, pdo_mysql, tokenizer, zip
-   **Composer(Optional)**
-   **MySQL 5.7+** or **MariaDB 10.3+**

**LAMP Installation** follow the [instructions here](https://github.com/teddysun/lamp)
If you follow this step, no need to install Apache, PHP, MySQL separetely as listed below

An editor like vim or nano should be useful too.

### a. Apache
Install Apache with:

```sh
sudo apt update
sudo apt install -y apache2
```

### b. Git
Install Git with:

```sh
sudo apt install -y git
```

### c. PHP

Install PHP 7.3 with these extensions:

```sh
sudo apt install -y php php-bcmath php-gd php-gmp php-curl php-intl \
    php-mbstring php-mysql php-xml php-zip
```

### d. Composer(Optional)
After you're done installing PHP, you'll need the Composer dependency manager.

```sh
sudo apt install -y composer
```

### e. MariaDB
The official Faveo installation uses Mysql as the database system and **this is the only official system we support**. While Laravel technically supports PostgreSQL and SQLite, we can't guarantee that it will work fine with Faveo as we've never tested it. Feel free to read [Laravel's documentation](https://laravel.com/docs/database#configuration) on that topic if you feel adventurous.

Install MariaDB. Note that this only installs the package, but does not setup Mysql. This is done later in the instructions:

```sh
sudo apt install -y mariadb-server
```

## Installation steps

Once the softwares above are installed:

### 1. Clone the repository

You may install Faveo by simply cloning the repository. Consider cloning the repository into any folder, example here in `/var/www/faveo` directory:

```sh
cd /var/www/
sudo git clone https://github.com/ladybirdweb/faveo-helpdesk.git
```

You should check out a tagged version of Faveo since `master` branch may not always be stable.
Find the latest official version on the [release page](https://github.com/ladybirdweb/faveo-helpdesk/releases)

```sh
cd /var/www/faveo
# Clone the desired version
sudo git checkout tags/v1.10.7
```

### 2. Setup the database

First make the database a bit more secure.

```sh
sudo mysql_secure_installation
```

Next log in with the root account to configure the database.

```sh
sudo mysql -uroot -p
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
### 3. Configure Apache webserver

**a.** Give proper permissions to the project directory by running:

```sh
sudo chown -R www-data:www-data /var/www/faveo
sudo chmod -R 775 /var/www/faveo/storage
```

**b.** Enable the rewrite module of the Apache webserver:

```sh
sudo a2enmod rewrite
```

**c.** Configure a new Faveo site in apache by doing:

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

4. Apply the new `.conf` file and reload Apache. You can do that by running:

```sh
sudo a2dissite 000-default.conf
sudo a2ensite faveo.conf
sudo systemctl reload apache2
```
### 4. Install Faveo

Now you can install Faveo via [GUI](https://support.faveohelpdesk.com/show/web-gui-installer) Wizard or [CLI](https://support.faveohelpdesk.com/show/cli-installer).


### 5. Configure cron job

Faveo requires some background processes to continuously run. The list of things Faveo does in the background is described [here](https://github.com/ladybirdweb/faveo-helpdesk/blob/master/app/Console/Kernel.php#L9).
Basically those crons are needed to receive emails
To do this, setup a cron that runs every minute that triggers the following command `php artisan schedule:run`.

Run the crontab command:

```sh
crontab -u www-data -e
```

Then, in the `crontab` editor window you just opened, paste the following at the end of the document:

```sh
* * * * * php /var/www/faveo/artisan schedule:run
```

### 6. Final step

The final step is to have fun with your newly created instance, which should be up and running to `http://localhost`.
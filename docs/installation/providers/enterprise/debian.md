# Installing Faveo Helpdesk Freelancer, paid and Enterprise on Debian <!-- omit in toc -->

<img alt="Logo" src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Debian-OpenLogo.svg/109px-Debian-OpenLogo.svg.png" width="96" height="127" />

Faveo can run on Debian Buster.

-   [Prerequisites](#prerequisites)
-   [Installation steps](#installation-steps)
    -   [1. Upload Faveo](#1-upload-faveo)
    -   [2. Setup the database](#2-setup-the-database)
    -   [3. Install Faveo](#3-gui-faveo-installer)
    -   [4. Configure cron job](#4-configure-cron-job)
    -   [5. Configure Apache webserver](#5-configure-apache-webserver)
    -   [Final step](#final-step)

<a id="prerequisites" name="prerequisites"></a>
## Prerequisites

-   **Apache** (with mod_rewrite enabled) or **Nginx** or **IIS**
-   **Git**
-   **PHP 7.3+** with the following extensions: curl, dom, gd, json, mbstring, openssl, pdo_mysql, tokenizer, zip
-   **Composer**
-   **MySQL 5.7+** or MariaDB **10.3+**

**LAMP Installation** follow the [instructions here](https://github.com/teddysun/lamp)
If you follow this step, no need to install Apache, PHP, MySQL separetely as listed below

An editor like vim or nano should be useful too.

**Apache:** Install Apache with:

```sh
sudo apt update
sudo apt install -y apache2
```

**Git:** Install Git with:

```sh
sudo apt install -y git
```

**PHP:**

Install PHP 7.3 with these extensions:

```sh
sudo apt install -y php php-bcmath php-gd php-gmp php-curl php-intl \
    php-mbstring php-mysql php-xml php-zip
```

**Composer:** After you're done installing PHP, you'll need the Composer dependency manager.

```sh
sudo apt install -y composer
```

**MariaDB:** Install MariaDB. Note that this only installs the package, but does not setup Mysql. This is done later in the instructions:

```sh
sudo apt install -y mariadb-server
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

<a id="3-gui-faveo-installer" name="3-gui-faveo-installer"></a>
### 3. GUI Faveo Installer

Follow the final installation steps [here](https://support.faveohelpdesk.com/show/web-gui-installer)


<a id="4-configure-cron-job" name="4-configure-cron-job"></a>
### 4. Configure cron job

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

<a id="5-configure-apache-webserver" name="5-configure-apache-webserver"></a>
### 5. Configure Apache webserver

1. Give proper permissions to the project directory by running:

```sh
sudo chown -R www-data:www-data /var/www/faveo
sudo chmod -R 775 /var/www/faveo/storage
```

2. Enable the rewrite module of the Apache webserver:

```sh
sudo a2enmod rewrite
```

3. Configure a new Faveo site in apache by doing:

```sh
sudo nano /etc/apache2/sites-available/faveo.conf
```

Then, in the `nano` text editor window you just opened, copy the following - swapping the `**YOUR IP ADDRESS/DOMAIN**` with your server's IP address/associated domain:

```html
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

<a id="final-step" name="final-step"></a>
### Final step

The final step is to have fun with your newly created instance, which should be up and running to `http://localhost`.

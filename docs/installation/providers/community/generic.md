# Installing Faveo Helpdesk Community (Generic) <!-- omit in toc -->

-   [Prerequisites](#prerequisites)
    -   [Types of databases](#types-of-databases)
-   [Installation steps](#installation-steps)
    -   [1. Clone the repository](#1-clone-the-repository)
    -   [2. Setup the database](#2-setup-the-database)
    -   [3. Install Faveo](#3-gui-faveo-installer)
    -   [4. Configure cron job](#4-configure-cron-job)
    -   [5. Configure Apache webserver](#5-configure-apache-webserver)
    -   [6. Optional: Setup the queues with Redis, Beanstalk or Amazon SQS](#6-optional-setup-the-queues-with-redis-beanstalk-or-amazon-sqs)
    -   [Final step](#final-step)

## Prerequisites

If you don't want to use Docker, the best way to setup the project is to use the same configuration that [Homestead](https://laravel.com/docs/homestead) uses. Basically, Faveo depends on the following:

-   **Apache** (with mod_rewrite enabled) or **Nginx** or **IIS**
-   **Git**
-   **PHP 7.3+** with the following extensions: curl, dom, gd, json, mbstring, openssl, pdo_mysql, tokenizer, zip
-   **Composer**
-   **MySQL 5.7+** or MariaDB **10.3+**

**LAMP Installation** follow the [instructions here](https://github.com/teddysun/lamp)
If you follow this step, no need to install Apache, PHP, MySQL separetely as listed below

**Git:** Git should come pre-installed with your server. If it doesn't please install

**PHP:** Install php7.3 minimum, with these extensions:

-   curl
-   bcmath
-   gd
-   gmp
-   iconv
-   intl
-   json
-   pdo_mysql
-   mbstring
-   mysqli
-   opcache
-   redis
-   sodium
-   xml
-   zip

**Composer:** After you're done installing PHP, you'll need the Composer dependency manager. It is not enough to just install Composer, you also need to make sure it is installed globally for Faveo's installation to run smoothly:

```sh
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer
php -r "unlink('composer-setup.php');"
```

**Mysql:** Install Mysql 5.7+

### Types of databases

The official Faveo installation uses mySQL as the database system and **this is the only official system we support**. While Laravel technically supports PostgreSQL and SQLite, we can't guarantee that it will work fine with Faveo as we've never tested it. Feel free to read [Laravel's documentation](https://laravel.com/docs/database#configuration) on that topic if you feel adventurous.

## Installation steps

Once the softwares above are installed:

### 1. Clone the repository

You may install Faveo by simply cloning the repository. In order for this to work with Apache, which is often pre-packaged with many common linux instances ([DigitalOcean](https://www.digitalocean.com/) droplets are one example), you need to clone the repository in a specific folder:
You may install Faveo by simply cloning the repository. In order for this to work with Apache, which is often pre-packaged with many common linux instances ([DigitalOcean](https://www.digitalocean.com/) droplets are one example), you need to clone the repository in a specific folder:

```sh
cd /var/www
git clone https://github.com/ladybirdweb/faveo-helpdesk.git
```

You should check out a tagged version of Faveo since `master` branch may not always be stable. Find the latest official version on the [release page](https://github.com/ladybirdweb/faveo-helpdesk/releases).

```sh
cd /var/www/faveo
git checkout tags/v1.10.7
```

### 2. Setup the database

Log in with the root account to configure the database.

```sh
mysql -u root -p
```

Create a database called 'faveo'.

```sql
CREATE DATABASE faveo;
```

or if you want to support all character (like emojis):

```sql
CREATE DATABASE faveo CHARACTER SET utf8 COLLATE utf8_general_ci;
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

### 3. GUI Faveo Installer

Follow the final installation steps [here](https://support.faveohelpdesk.com/show/web-gui-installer)


### 4. Configure cron job

Faveo requires some background processes to continuously run. The list of things Faveo does in the background is described [here](https://github.com/ladybirdweb/faveo-helpdesk/blob/master/app/Console/Kernel.php#L9).
Basically those crons are needed to receive emails
To do this, setup a cron that runs every minute that triggers the following command `php artisan schedule:run`.

1. Open crontab edit for the apache user:

```sh
crontab -u www-data -e
```

2. Then, in the text editor window you just opened, copy the following:

```
* * * * *   /usr/bin/php /var/www/faveo/artisan schedule:run
```

### 5. Configure Apache webserver

1. Give proper permissions to the project directory by running:

```sh
chgrp -R www-data /var/www/faveo
chmod -R 775 /var/www/faveo/storage
```

2. Enable the rewrite module of the Apache webserver:

```sh
a2enmod rewrite
```

2. Configure a new faveo site in apache by doing:

```sh
nano /etc/apache2/sites-available/faveo.conf
```

3. Then, in the `nano` text editor window you just opened, copy the following - swapping the `YOUR IP ADDRESS/DOMAIN` with your server's IP address/associated domain:

```html
<VirtualHost *:80>
    ServerName YOUR IP ADDRESS/DOMAIN

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

4. Apply the new `.conf` file and restart Apache. You can do that by running:

```sh
a2dissite 000-default.conf
a2ensite faveo.conf
service apache2 restart
```

<a id="setup-queues"></a>

### 6. Optional: Setup the queues with Redis, Beanstalk or Amazon SQS

Faveo can work with a queue mechanism to handle different events, so we don't block the main thread while processing stuff that can be run asynchronously, like sending emails. By default, Faveo does not use a queue mechanism but can be setup to do so.

We recommend that you do not use a queue mechanism as it complexifies the overall system and can make debugging harder when things go wrong.

This is why we suggest to use `QUEUE_CONNECTION=sync` in your .env file. This will bypass the queues entirely and will process requests as they come. In practice, unless you have thousands of users, you don't need to use an asynchronous queue.

That being said, if you still want to make your life more complicated, here is what you can do.

There are several choices for the queue mechanism:

-   Database (this will use the database used by the application to act as a queue)
-   Redis
-   Beanstalk
-   Amazon SQS

The simplest queue is the database driver. To set it up, simply change in your `.env` file the following `QUEUE_CONNECTION=sync` by `QUEUE_CONNECTION=database`.

To configure the other queues, refer to the [official Laravel documentation](https://laravel.com/docs/master/queues#driver-prerequisites) on the topic.

After configuring the queue, you'll have to run the queue worker, as described in the [Laravel documentation](https://laravel.com/docs/master/queues#running-the-queue-worker).

```sh
php artisan queue:work --sleep=3 --tries=3
```

Some process monitor such as [Supervisor](https://laravel.com/docs/master/queues#supervisor-configuration) could be useful to monitor the queue worker.

<a id="setup-access-tokens"></a>


### Final step

The final step is to have fun with your newly created instance, which should be up and running to `http://localhost`.

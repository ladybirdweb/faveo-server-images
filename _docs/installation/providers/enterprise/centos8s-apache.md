---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/centos8s-apache/
redirect_from:
  - /theme-setup/
last_modified_at: 2020-06-09
toc: true
---
# Installing Faveo Helpdesk Freelancer, Paid and Enterprise on CentOS-8-Stream OS 8 <!-- omit in toc -->

<img alt="CentOS-8-Stream OS Logo" src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Centos-logo-light.svg/300px-Centos-logo-light.svg.png" width="200"  />

Faveo can run on [CentOS-8-Stream 8 ](https://www.centos.org/download/).

- [<b>Installation steps:</b>](#binstallation-stepsb)
  - [<b>Prerequisites:</b>](#bprerequisitesb)
    - [<b> 1. LAMP Installation</b>](#b-1-lamp-installationb)
    - [<b> 2.a Update your Packages and install some utility tools</b>](#b-2a-update-your-packages-and-install-some-utility-toolsb)
    - [<b> 2.b. Install php-7.3 Packages </b>](#b-2b-install-php-73-packages-b)
    - [<b> 2.c. Install and run Apache</b>](#b-2c-install-and-run-apacheb)
    - [<b>2.d. Setting Up ionCube</b>](#b2d-setting-up-ioncubeb)
    - [<b> 2.e. Install and run Mysql/MariaDB</b>](#b-2e-install-and-run-mysqlmariadbb)
  - [Once the softwares above are installed:](#once-the-softwares-above-are-installed)
    - [<b>3. Upload Faveo</b>](#b3-upload-faveob)
    - [<b>4. Setup the database</b>](#b4-setup-the-databaseb)
    - [<b>5. Configure Apache webserver</b>](#b5-configure-apache-webserverb)
    - [<b> 6. Configure cron job</b>](#b-6-configure-cron-jobb)
    - [<b>7. Redis Installation</b>](#b7-redis-installationb)
    - [<b>8. SSL Installation</b>](#b8-ssl-installationb)
    - [<b>9. Install Faveo</b>](#b9-install-faveob)
    - [<b>10. Final step</b>](#b10-final-stepb)


<a id="prerequisites" name="prerequisites"></a>

<a id="installation-steps" name="installation-steps"></a>
# <b>Installation steps:</b>
## <b>Prerequisites:</b>

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

###  <b> 2.b. Install php-7.3 Packages </b>



```sh
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
yum install -y https://rpms.remirepo.net/enterprise/remi-release-8.rpm

dnf module install php:remi-7.3 -y
yum -y install php php-cli php-common php-fpm php-gd php-mbstring php-pecl-mcrypt php-mysqlnd php-odbc php-pdo php-xml  php-opcache php-imap php-bcmath php-ldap php-pecl-zip php-soap php-redis
```
###  <b> 2.c. Install and run Apache</b>
Install and Enable Apache Server

```sh
yum install -y httpd
systemctl start httpd
systemctl enable httpd
```



### <b>2.d. Setting Up ionCube</b>
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

### <b> 2.e. Install and run Mysql/MariaDB</b>

The official Faveo installation uses Mysql as the database system and **this is the only official system we support**. While Laravel technically supports PostgreSQL and SQLite, we can't guarantee that it will work fine with Faveo as we've never tested it. Feel free to read [Laravel's documentation](https://laravel.com/docs/database#configuration) on that topic if you feel adventurous.

Note: Currently Faveo supports only Mysql-5.7 and MariaDB-10.3.
Note: The below steps only installs the package, but does not setup the database required by Faveo. This is done later in the instructions.

In CentOS-8-Stream OS 8 mariadb-server-10.3 is available from the default Repo's.So instead of downloading and adding other Repos you could simply install MariadDB-10.3 by running the following commands.

```sh
yum install mariadb-server -y
systemctl start mariadb
systemctl enable mariadb
```

Secure your MySql installation by executing the below command. Set Password for mysql root user, remove anonymous users, disallow remote root login, remove the test databases and finally reload the privilege tables.

```sh
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


## Once the softwares above are installed:


<a id="1-upload-faveo" name="1-upload-faveo"></a>
### <b>3. Upload Faveo</b>
Please download Faveo Helpdesk from [https://billing.faveohelpdesk.com](https://billing.faveohelpdesk.com) and upload it to below directory

```sh
mkdir -p /var/www/faveo/
cd /var/www/faveo/
```
**3.a.** <b>Extracting the Faveo-Codebase zip file</b>

```sh
unzip "Filename.zip" -d /var/www/faveo
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

**5.a.** <b>Give proper permissions to the project directory by running:</b>

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

**5.b.** <b>Enable the rewrite module of the Apache webserver:</b>

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

**5.c.** <b>Configure a new faveo site in apache by doing:</b>

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


<a id="6-configure-cron-job" name="6-configure-cron-job"></a>
### <b> 6. Configure cron job</b>

Faveo requires some background processes to continuously run. 
Basically those crons are needed to receive emails
To do this, setup a cron that runs every minute that triggers the following command `php artisan schedule:run`. Verify your php ececutable location and replace it accordingly in the below command.

Create a new `/etc/cron.d/faveo` file with:

```sh
echo "* * * * * apache /bin/php /var/www/faveo/artisan schedule:run 2>&1" | sudo tee /etc/cron.d/faveo
```


<a id="redis-installation" name="redis-installation"></a>
### <b>7. Redis Installation</b>

Redis is an open-source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.

This is an optional step and will improve system performance and is highly recommended.

[Redis installation documentation](/docs/installation/providers/enterprise/centos8s-redis)

<a id="ssl-installation" name="ssl-installation"></a>
### <b>8. SSL Installation</b>

Secure Sockets Layer (SSL) is a standard security technology for establishing an encrypted link between a server and a client. Let's Encrypt is a free, automated, and open certificate authority.

This is an optional step and will improve system security and is highly recommended.

[Let’s Encrypt SSL installation documentation](/docs/installation/providers/enterprise/centos8s-apache-ssl)

<a id="final-step" name="final-step"></a>
### <b>9. Install Faveo</b>

At this point if the domainname is propagated properly with your server's IP you can open Faveo in browser just by entering your domainname.
You can also check the Propagation update by Visiting this site www.whatsmydns.net.

Now you can install Faveo via [GUI](/docs/installation/installer/gui) Wizard or [CLI](/docs/installation/installer/cli).
### <b>10. Final step</b>

The final step is to have fun with your newly created instance, which should be up and running to `http://localhost` or the domain you have configured Faveo with.

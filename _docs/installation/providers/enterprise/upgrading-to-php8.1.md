---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/upgrading-to-php8.1/
redirect_from:
  - /theme-setup/
last_modified_at: 2020-06-09
toc: true
---

# How to Upgrade from PHP 7.x to PHP 8.1 on Ubuntu, CentOS, RHEL, Debian, Windows Server <!-- omit in toc -->



## Introduction

This document will guide to install PHP-8.1 for Faveo Helpdesk.

This guide has been tested on: 
-   Ubuntu 18.04, 20.04, 22.04
-   Debian 10, 11
-   CentOS 7, 8 Stream, 9 Stream
-   Windows 2012, 2016, 2019

Before proceeding further check your current PHP version. To find out which version of PHP you are currently using, run this in the Terminal or Windows command prompt. 

```sh
php -v
```
If you are running PHP 7.x, you can continue with this guide to upgrade to PHP 8.1 

# For Ubuntu and Debian
Type the following command to remove the existing PHP version.

```sh
sudo apt-get purge php7.*
```
Press y and ENTER when prompted.

After uninstalling packages, it’s advised to run these two commands.
```sh
sudo apt-get autoclean
```
```sh
sudo apt-get autoremove
```
### Add Ondřej Surý’s PPA repository
If you are running Ubuntu 22.04 and above, you do not need to add this repository below. Instead, skip this step.

If you are running Ubuntu 20.04 or 18.04, the PHP 8.1 binary packages are only available in the Ondřej Surý PPA repository. Install below.
```sh
sudo add-apt-repository ppa:ondrej/php
```
You may see a welcome message.

Output:

```sh
Co-installable PHP versions: PHP 5.6, PHP 7.x and most requested extensions are included. Only Supported Versions of PHP (http://php.net/supported-versions.php) for Supported Ubuntu Releases (https://wiki.ubuntu.com/Releases) are provided. Don't ask for end-of-life PHP versions or Ubuntu release, they won't be provided.

Debian oldstable and stable packages are provided as well: https://deb.sury.org/#debian-dpa

You can get more information about the packages at https://deb.sury.org

IMPORTANT: The -backports is now required on older Ubuntu releases.

BUGS&FEATURES: This PPA now has a issue tracker:
https://deb.sury.org/#bug-reporting

CAVEATS:
1. If you are using php-gearman, you need to add ppa:ondrej/pkg-gearman
2. If you are using apache2, you are advised to add ppa:ondrej/apache2
3. If you are using nginx, you are advised to add ppa:ondrej/nginx-mainline
   or ppa:ondrej/nginx

PLEASE READ: If you like my work and want to give me a little motivation, please consider donating regularly: https://donate.sury.org/

WARNING: add-apt-repository is broken with non-UTF-8 locales, see
https://github.com/oerdnj/deb.sury.org/issues/56 for workaround:

# LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
 More info: https://launchpad.net/~ondrej/+archive/ubuntu/php
Press [ENTER] to continue or Ctrl-c to cancel adding it.
```
Press ENTER to add the repository.

If you are running Debian 10 or 11
```sh
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list
curl -fsSL  https://packages.sury.org/php/apt.gpg| sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/sury-keyring.gpg --yes
```

### Install PHP 8.1
Update the repository cache by running the below command
```sh
sudo apt-get update
```
Install PHP 8.1 along with necessary extensions required by Faveo Helpdesk.
```sh
sudo apt-get install -y php8.1 libapache2-mod-php8.1 php8.1-mysql \
            php8.1-cli php8.1-common php8.1-soap php8.1-gd \
            php8.1-opcache  php8.1-mbstring php8.1-zip \
            php8.1-bcmath php8.1-intl php8.1-xml php8.1-curl  \
            php8.1-imap php8.1-ldap php8.1-gmp php8.1-redis
```
Press Y and ENTER if prompted.
### Restart Apache.
```sh
sudo systemctl restart apache2
```
### If running Nginx, make sure to install FPM. (Optional only for Nginx Web Server)
```sh
sudo apt-get install php8.1-fpm
```
### Install and configure Ioncube 8.1 extension.
Download the latest Ioncube loader
```sh
wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz 
```
```sh
tar -xvf ioncube_loaders_lin_x86-64.tar.gz
```
Copy the ioncube_loader_lin_8.1.so to PHP Extensin directory.
```sh
ioncube/ioncube_loader_lin_8.1.so /usr/lib/php/20210902/
```
### Update the PHP Configuration files.
```sh
sed -i '2 a zend_extension = "/usr/lib/php/20210902/ioncube_loader_lin_8.1.so"' /etc/php/8.1/apache2/php.ini
sed -i '2 a zend_extension = "/usr/lib/php/20210902/ioncube_loader_lin_8.1.so"' /etc/php/8.1/cli/php.ini
sed -i '2 a zend_extension = "/usr/lib/php/20210902/ioncube_loader_lin_8.1.so"' /etc/php/8.1/fpm/php.ini

```
### Change PHP default settings.
```sh
sed -i 's/upload_max_filesize =.*/upload_max_filesize = 100M/g' /etc/php/8.1/apache2/php.ini
sed -i 's/post_max_size =.*/post_max_size = 100M/g' /etc/php/8.1/apache2/php.ini
sed -i 's/max_execution_time =.*/max_execution_time = 360/g' /etc/php/8.1/apache2/php.ini 
```
### Change PHP default settings if NGINX is configured.(Optional)
```sh
sed -i 's/upload_max_filesize =.*/upload_max_filesize = 100M/g' /etc/php/8.1/fpm/php.ini
sed -i 's/post_max_size =.*/post_max_size = 100M/g' /etc/php/8.1/fpm/php.ini
sed -i 's/max_execution_time =.*/max_execution_time = 360/g' /etc/php/8.1/fpm/php.ini 
```
```sh
sudo systemctl restart php8.1-fpm
sudo systemctl restart nginx
```
### Restart Apache.
```sh
sudo systemctl restart apache2
```

# For CentOS 7

In CentOS machines we can simply upgrade from lower version of PHP to Higher by switching the Repository. Run the below command to enable PHP 8.1 Remi repo.
```sh
sudo yum-config-manager --enable remi-php81
```
Now run the below command to update to PHP 8.1
```sh
sudo yum update -y
```
### Install and configure Ioncube 8.1 extension.
Downlaod the latest Ioncube loader
```sh
wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
tar xfz ioncube_loaders_lin_x86-64.tar.gz
```
Copy the ioncube_loader_lin_8.1.so to PHP Extensin directory.
```sh
cp ioncube/ioncube_loader_lin_8.1.so /usr/lib64/php/modules
```
Update the PHP configuration file
```sh
cp ioncube/ioncube_loader_lin_8.1.so /usr/lib64/php/modules 
sed -i 's:ioncube_loader_lin_7.3.so:ioncube_loader_lin_8.1.so:g' /etc/php.ini
sed -i "s/max_execution_time = .*/max_execution_time = 300/" /etc/php.ini
```








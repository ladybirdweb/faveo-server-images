---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/php-upgrade/
redirect_from:
  - /theme-setup/
last_modified_at: 2022-11-26
toc: true
title: Upgrade From PHP 7.3.x to PHP 8.1.x 
---

#  <!-- omit in toc -->

<img alt="PHP" src="https://upload.wikimedia.org/wikipedia/commons/2/27/PHP-logo.svg" width="200" />


# How to Upgrade from PHP 7.x to PHP 8.1 on Ubuntu, CentOS, RHEL, Debian, Windows Server <!-- omit in toc -->



## Introduction

This document will guide you to upgrade PHP-8.1 for Faveo Helpdesk.

- <strong>This guide has been tested on: </strong>
-   [<strong>Ubuntu 18.04, 20.04, 22.04  </strong>](#ubuntu&debian)
-   [<strong> Debian 10, 11 </strong>](#ubuntu&debian)
-   [<strong>CentOS 7, 8 Stream, 9 Stream </strong>](#centos)
-   [<strong>Shared Hosting (Cpanel) </strong>](#cpanel)
-   [<strong>Windows 2012, 2016, 2019 </strong>](#windows)

Before proceeding further check your current PHP version. To find out which version of PHP you are currently using, run this in the Terminal or Windows command prompt. 

```sh
php -v
```
If you are running PHP 7.x, you can continue with this guide to upgrade to PHP 8.1 
<a id="ubuntu&debian" name="ubuntu&debian"></a>
## For Ubuntu and Debian
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
Co-installable PHP versions: PHP 5.6, PHP 7.x, and most requested extensions are included. Only Supported Versions of PHP (http://php.net/supported-versions.php) for Supported Ubuntu Releases (https://wiki.ubuntu.com/Releases) are provided. Don't ask for end-of-life PHP versions or Ubuntu releases, they won't be provided.

Debian old stable and stable packages are provided as well: https://deb.sury.org/debian-dpa

You can get more information about the packages at https://deb.sury.org

IMPORTANT: The -backports are now required on older Ubuntu releases.

BUGS&FEATURES: This PPA now has an issue tracker:
https://deb.sury.org/bug-reporting

CAVEATS:
1. If you are using php-gearman, you need to add ppa:ondrej/pkg-gearman
2. If you are using apache2, you are advised to add ppa:ondrej/apache2
3. If you are using nginx, you are advised to add ppa:ondrej/nginx-mainline
   or ppa:ondrej/nginx

PLEASE READ: If you like my work and want to give me a little motivation, please consider donating regularly: https://donate.sury.org/

WARNING: add-apt-repository is broken with non-UTF-8 locales, see
https://github.com/oerdnj/deb.sury.org/issues/56 for a workaround:

LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
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
Install PHP 8.1 along with the necessary extensions required by Faveo Helpdesk.
```sh
sudo apt-get install -y php8.1 libapache2-mod-php8.1 php8.1-mysql \
            php8.1-cli php8.1-common php8.1-soap php8.1-gd \
            php8.1-opcache  php8.1-mbstring php8.1-zip \
            php8.1-bcmath php8.1-intl php8.1-xml php8.1-curl  \
            php8.1-imap php8.1-ldap php8.1-gmp php8.1-redis
```
Press Y and ENTER if prompted.
### Restart Apache
```sh
sudo systemctl restart apache2
```
### If running Nginx, make sure to install FPM. (Optional only for Nginx Web Server)
```sh
sudo apt-get install php8.1-fpm
```
### Install and configure Ioncube 8.1 extension
Download the latest Ioncube loader
```sh
wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz 
```
```sh
tar -xvf ioncube_loaders_lin_x86-64.tar.gz
```
Copy the ioncube_loader_lin_8.1.so to PHP Extension directory.
```sh
cp ioncube/ioncube_loader_lin_8.1.so /usr/lib/php/20210902/
```
### Update the PHP Configuration files
```sh
sed -i '2 a zend_extension = "/usr/lib/php/20210902/ioncube_loader_lin_8.1.so"' /etc/php/8.1/apache2/php.ini
sed -i '2 a zend_extension = "/usr/lib/php/20210902/ioncube_loader_lin_8.1.so"' /etc/php/8.1/cli/php.ini

```
### Change PHP default settings
```sh
sed -i 's/upload_max_filesize =.*/upload_max_filesize = 100M/g' /etc/php/8.1/apache2/php.ini
sed -i 's/post_max_size =.*/post_max_size = 100M/g' /etc/php/8.1/apache2/php.ini
sed -i 's/max_execution_time =.*/max_execution_time = 360/g' /etc/php/8.1/apache2/php.ini 
```
### Change PHP default settings if NGINX is configured (Optional)
```sh
sed -i 's/upload_max_filesize =.*/upload_max_filesize = 100M/g' /etc/php/8.1/fpm/php.ini
sed -i 's/post_max_size =.*/post_max_size = 100M/g' /etc/php/8.1/fpm/php.ini
sed -i 's/max_execution_time =.*/max_execution_time = 360/g' /etc/php/8.1/fpm/php.ini 
```
```sh
sudo systemctl restart php8.1-fpm
sudo systemctl restart nginx
```
### Restart Apache
```sh
sudo systemctl restart apache2
```
<a id="centos" name="centos"></a>
## For CentOS 7

In CentOS machines, we can simply upgrade from a lower version of PHP to a Higher one by switching the Repository. Run the below command to enable PHP 8.1 Remi repo.
```sh
sudo yum-config-manager --enable remi-php81
```
Now run the below command to update to PHP 8.1
```sh
sudo yum update -y
```
### Install and configure Ioncube 8.1 extension
Download the latest Ioncube loader
```sh
wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
tar xfz ioncube_loaders_lin_x86-64.tar.gz
```
Copy the ioncube_loader_lin_8.1.so to PHP Extension directory.
```sh
cp ioncube/ioncube_loader_lin_8.1.so /usr/lib64/php/modules
```
Update the PHP configuration file
```sh
sed -i 's:ioncube_loader_lin_7.3.so:ioncube_loader_lin_8.1.so:g' /etc/php.ini
sed -i "s/max_execution_time = .*/max_execution_time = 300/" /etc/php.ini
```
To make the changes effect please restart the webserver.
```
systemctl restart httpd (Incase of Apache)
systemctl restart nginx (Incase of Nginx)
systemctl restart php8.1-fpm (Incase of Nginx with php-fpm)
```

## For Centos 8 Stream and Rocky 8

In CentOS 8 stream and Rocky 8 machines, we can simply upgrade from a lower version of PHP to a Higher one by switching the Repository. Run the below command to disable PHP 7.3 and enable PHP 8.1 Remi repo.
```sh
sudo dnf module reset php:remi-7.3 -y
sudo dnf module enable php:remi-8.1 -y
```
Now run the below command to update to PHP 8.1
```sh
sudo yum update -y
```
### Install and configure Ioncube 8.1 extension
Download the latest Ioncube loader
```sh
wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
tar xfz ioncube_loaders_lin_x86-64.tar.gz
```
Copy the ioncube_loader_lin_8.1.so to PHP Extension directory.
```sh
cp ioncube/ioncube_loader_lin_8.1.so /usr/lib64/php/modules
```
Update the PHP configuration file
```sh
cp ioncube/ioncube_loader_lin_8.1.so /usr/lib64/php/modules 
sed -i 's:ioncube_loader_lin_7.3.so:ioncube_loader_lin_8.1.so:g' /etc/php.ini
sed -i "s/max_execution_time = .*/max_execution_time = 300/" /etc/php.ini
```
To make the changes effect please restart the webserver.
```
systemctl restart httpd (Incase of Apache)
systemctl restart nginx (Incase of Nginx)
systemctl restart php8.1-fpm (Incase of Nginx with php-fpm)
```
Note: After the update, if you came across an ioncube not loaded issue please reboot the machine.

<a id="cpanel" name="cpanel"></a>
## For Cpanel

- To enable PHP 8.1 in Cpanel the PHP version has to be installed in the server this is done through WHM, This can be done by contacting your Hosting Provider.
- After installing PHP 8.1 on the server we need to change the php version for the faveo domain, follow the below steps to do so.
- Login to the Cpanel and search for **MultiPHP Manager** as shown in the below snap.
<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/GUI-images/multi-php-manager.png?raw=true"/>
- After opening the MultiPHP Manager select the "checkbox" of the domain, change the PHP version from the drop-down to PHP 8.1 and click apply as shown in the below snap
<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/GUI-images/php-version-change-apply.png?raw=true"/>
Note: if you are not able to find the PHP version in the drop-down then it is not installed on the server Please contact your Hosting provider and install PHP-8.1 and try again.
<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/GUI-images/after-php-change.png?raw=true"/>
- Once PHP 8.1 is updated to the domain we need to update PHP version in cron as well to do so, search for cron jobs in the Cpanel search and click on it to open the cron jobs page as below.
<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/GUI-images/cron-search.png?raw=true"/>
<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/GUI-images/Screenshot%20from%202022-11-28%2011-30-14.png?raw=true"/>
- Once we get to the cronjobs page we need to edit the cron to use the php8.1 to do so we need to edit the cron job to use the domain-specific php path and save as shown in the below snap with the below commands.
<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/6bfb7af0993f57bb9c975aaf3978083b8c7353f1/_docs/installation/providers/enterprise/GUI-images/cron-before-change.png?raw=true"/>
<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/6bfb7af0993f57bb9c975aaf3978083b8c7353f1/_docs/installation/providers/enterprise/GUI-images/cron-after-change.png?raw=true"/>

      ```sh
      /usr/local/bin/php (we need to change this path to the below)
      /usr/local/bin/ea-php8.1
      ```

<a id="windows" name="windows"></a>
## For Windows Servers

-   <a href="https://windows.php.net/downloads/releases/archives/" target="_blank" rel="noopener">Click Here</a> to download "php-8.1.12-nts-Win32-vs16-x64.zip" file. Extract the zip file & "rename it to *php8.1*. Now move the renamed *php8.1* folder to *C:\php8.1*.
<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/6bfb7af0993f57bb9c975aaf3978083b8c7353f1/_docs/installation/providers/enterprise/windows-images/php-8.1.png?raw=true"/>
<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/6bfb7af0993f57bb9c975aaf3978083b8c7353f1/_docs/installation/providers/enterprise/windows-images/movphp8.1.png?raw=true"/>

- Open php8.1 folder, find php.ini-development & rename it to php.ini to make it php configuration file.
<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/6bfb7af0993f57bb9c975aaf3978083b8c7353f1/_docs/installation/providers/enterprise/windows-images/phpconfig.png?raw=true"/>

- Open php.ini using Notepad++, add the below lines at the end of this file & save the file:
Required configuration changes for Faveo Helpdesk.

```sh
error_log=C:\Windows\temp\PHP81x64_errors.log
upload_tmp_dir="C:\Windows\Temp"
session.save_path="C:\Windows\Temp"
cgi.force_redirect=0
cgi.fix_pathinfo=1
fastcgi.impersonate=1
fastcgi.logging=0
max_execution_time=300
date.timezone=Asia/Kolkata
extension_dir="C:\php8.1\ext\"
upload_max_filesize = 100M
post_max_size = 100M
memory_limit = 256M
```
Uncomment these extensions.

```sh
extension=bz2
extension=curl
extension=fileinfo
extension=gd2
extension=imap
extension=ldap
extension=mbstring
extension=mysqli
extension=soap
extension=sockets
extension=sodium
extension=openssl
extension=pdo_mysql
```
### Update the Environment Variable for PHP BinaryPermalink
<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/6bfb7af0993f57bb9c975aaf3978083b8c7353f1/_docs/installation/providers/enterprise/windows-images/env1.png?raw=true"/>
<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/6bfb7af0993f57bb9c975aaf3978083b8c7353f1/_docs/installation/providers/enterprise/windows-images/env2.png?raw=true"/>

- Now click on Path > Edit. Delete the old PHP 7.3 path and add PHP 8.1 path and click on ok.
<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/6bfb7af0993f57bb9c975aaf3978083b8c7353f1/_docs/installation/providers/enterprise/windows-images/php8.1-path.png?raw=true"/>

### Create FastCGI Handler Mapping
- Open Server Manager, locate Tools on the top right corner of the Dashboard, and Open Internet Information Services (IIS) Manager.
<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/6bfb7af0993f57bb9c975aaf3978083b8c7353f1/_docs/installation/providers/enterprise/windows-images/iis.png?raw=true"/>

- Now in the Left Panel of the IIS Manager select the server then you will find the Handler Mappings it will populate the available options to configure.
<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/6bfb7af0993f57bb9c975aaf3978083b8c7353f1/_docs/installation/providers/enterprise/windows-images/handlermap.png?raw=true"/>

- Open Handler Mappings, Select "FastCGI" Click on Edit in the Right Panel, and update the new "c:\php8.1\php-cgi.exe" path.
<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/6bfb7af0993f57bb9c975aaf3978083b8c7353f1/_docs/installation/providers/enterprise/windows-images/fastcgiphp8.1.png?raw=true"/>
- Click on "ok" and restart the IIS server once.

### Configure Ioncube PHP 8.1 loader

- <a href="https://downloads.ioncube.com/loader_downloads/ioncube_loaders_win_nonts_vc16_x86-64.zip" target="_blank" rel="noopener">Click Here</a> to download Ioncube Loader zip file, Extract the zip file.
- Copy the ioncube_loader_win_8.1.dll file from extracted Ioncube folder and paste it into the PHP extension directory C:\php8.1\ext.
- Add the below line in your php.ini file at the start to enable Ioncube.
```sh
zend_extension = "C:\php8.1\ext\ioncube_loader_win_8.1.dll"
```
- Click on "ok" and restart the IIS server once.






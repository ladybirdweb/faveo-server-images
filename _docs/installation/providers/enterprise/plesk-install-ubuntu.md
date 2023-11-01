---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/plesk-ubuntu/
redirect_from:
  - /theme-setup/
last_modified_at: 2023-10-18
last_modified_by: TamilSelvan_M
toc: true
title: Faveo Installation on Ubuntu with Plesk Panel
---

<style>p>code, a>code, li>code, figcaption>code, td>code {background: #dedede;}</style>

<img alt="Wamp" src="https://contabo.com/blog/wp-content/uploads/2019/11/Plesk-OBSIDIAN-logo_positive-1024x341.png" width="200"  /> 

[<strong>Faveo Installation on Windows with Xampp Server</strong>](#Faveo-Installation-on-Windows-with-Xampp-Server)

- [<strong>Installation steps:</strong>](#installation-steps)

  - [<strong> 1. Plesk Installation </strong>](#1)
  - [<strong> 2. Upload Faveo </strong>](#2)
  - [<strong> 3. Setting up the Database </strong>](#3)
  - [<strong> 4. Install Ioncube Loader </strong>](#3)
  - [<strong> 5. Install wkhtmltopdf </strong>](#4)
  - [<strong> 6. Configure the PHP 8.1 </strong>](#6)
  - [<strong> 7. Install Redis Extension </strong>](#7)
  - [<strong> 8. Cron in Task Scheduler </strong>](#8)
  - [<strong> 9. Self-Signed SSL </strong>](#9)
  - [<strong> 10. Install Faveo </strong>](#10)

<a id="1" name="1"></a>
## 1. Plesk Installation

- Follow the [instructions here](https://www.plesk.com/blog/various/install-plesk-linux/)

<a id="2" name="2"></a>
## 2. Install some Utility packages

```
apt install -y git wget curl unzip nano zip
```

### 2.a. PHP 8.1+

- First add this PPA repository:

```
add-apt-repository ppa:ondrej/php
```
Then install php 8.1 with these extensions:

```
apt update
apt install -y php8.1 libapache2-mod-php8.1 php8.1-mysql \
    php8.1-cli php8.1-common php8.1-fpm php8.1-soap php8.1-gd \
    php8.1-opcache  php8.1-mbstring php8.1-zip \
    php8.1-bcmath php8.1-intl php8.1-xml php8.1-curl  \
    php8.1-imap php8.1-ldap php8.1-gmp php8.1-redis
```

### 2.b. Install wkhtmltopdf

Wkhtmltopdf is an open source simple and much effective command-line shell utility that enables user to convert any given HTML (Web Page) to PDF document or an image (jpg, png, etc).

It uses WebKit rendering layout engine to convert HTML pages to PDF document without losing the quality of the pages. Its is really very useful and trustworthy solution for creating and storing snapshots of web pages in real-time.

### For Ubuntu 18.04 and 20.04

```
apt-get -y install wkhtmltopdf
```

### For Ubuntu 22.04

```
echo "deb http://security.ubuntu.com/ubuntu focal-security main" | sudo tee /etc/apt/sources.list.d/focal-security.list
        apt-get update; apt install libssl1.1 -y
        wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.focal_amd64.deb 
    
        dpkg -i wkhtmltox_0.12.6-1.focal_amd64.deb
        apt --fix-broken install -y
```

Once the softwares above are installed:

## 3. Upload Faveo

### Adding Domains

- Go to Websites & Domains, click Add Domain and follow on-screen instructions.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/plesk-images/add-domain.png" alt="" style=" width:600px">

- Click Add Domain.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/plesk-images/new-domain.png" alt="" style=" width:600px">

The new domain name is now shown in the list at the bottom of the screen.

### To upload a website using File Manager:

- Download the Faveo Helpdesk from [https://billing.faveohelpdesk.com](https://billing.faveohelpdesk.com)

Go to Websites & Domains > domain name > Files.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/plesk-images/upload-Faveo-zip.png" alt="" style=" width:600px">

- Click the httpdocs folder to open it, click Upload Files, select the archive file, and click Open.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/plesk-images/Extract-zip.png" alt="" style=" width:600px">

- Once the file has been uploaded, click the checkbox next to it and select the Extract Files option.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/plesk-images/Extract-files.png" alt="" style=" width:600px">


## 4. Setup the database

Click Databases from the left-side menu to create a new database

Click the Add Database button.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/plesk-images/add-database.png" alt="" style=" width:600px">

Fill out the details for the new database

- Provide the name of the new database.

- Select the correct server type (MySQL or MariaDB) from the Database server dropdown.

- You may keep the Related site's default value.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/plesk-images/add-a-database.png" alt="" style=" width:600px">

Once done with the database name, you will need to create the database user. Fill out the details for the Users.

If you want this new user to have access to all databases within your domain, you may want to put a checkmark on User has access to all databases within the selected subscription.

Click OK.

A confirmation will be displayed, and your new database is now added under your domain name.

## 5. Configure the PHP 8.1

### Switch PHP Versions

Step 1: In Plesk, go to Tools & Settings and click Updates (under Plesk).

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/plesk-images/updates.png" alt="" style=" width:600px">

Step 2: On the Updates and Upgrades page, click Add/Remove Components.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/plesk-images/add-remove-components.png" alt="" style=" width:600px">

Step 3: On the Add/Remove Components page, expand: 

- Web hosting > PHP interpreter versions section, if this is a Linux server.

- Select required PHP versions for installation/uninstallation and click Continue.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/plesk-images/install-php8-1.png" alt="" style=" width:600px">

Step 4: Go to Subscriptions > example.com > Websites & Domains > Hosting Settings > PHP version.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/plesk-images/php-version.png" alt="" style=" width:600px">

Step 5: Now select the PHP Version 8.1.X, then scroll down and press OK:

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/plesk-images/change-php-version.png" alt="" style=" width:600px">

### 5.a. Setting Up ionCube

Go to Tools & Settings > PHP Settings

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/plesk-images/php-settings.png" alt="" style=" width:600px">

Click on the required PHP handler, for example, 8.1.X FPM application

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/plesk-images/fpm-application.png" alt="" style=" width:600px">



<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/plesk-images/pecl-packages.png" alt="" style=" width:600px">


<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/plesk-images/pecl-installer.png" alt="" style=" width:600px">


## 6. Configure cron job



## 7. Redis Installation



## 8. SSL Installation



## 9. Install Faveo




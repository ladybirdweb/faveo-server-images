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

### Adding and Removing Domains

- Go to Websites & Domains, click Add Domain and follow on-screen instructions.

---- Images ----

- Click OK.

The new domain name is now shown in the list at the bottom of the screen.

### To upload a website using File Manager:

- Download the Faveo Helpdesk from [https://billing.faveohelpdesk.com](https://billing.faveohelpdesk.com)

Go to Websites & Domains > domain name > Files.

- Click the httpdocs folder to open it, click Upload Files, select the archive file, and click Open.

- Once the file has been uploaded, click the checkbox next to it and select the Extract Files option.


## 4. Setup the database



## 5. Configure the PHP 8.1

### Switch PHP Versions

Step 1: In Plesk, go to Tools & Settings and click Updates (under Plesk).

Step 2: On the Updates and Upgrades page, click Add/Remove Components.

Step 3: On the Add/Remove Components page, expand: 

- Web hosting > PHP interpreter versions section, if this is a Linux server.

- Select required PHP versions for installation/uninstallation and click Continue.

### 5.a. Setting Up ionCube



## 6. Configure cron job



## 7. Redis Installation



## 8. SSL Installation



## 9. Install Faveo




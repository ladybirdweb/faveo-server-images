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


## 2. Adding Domains

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


## 3.a. Configure the PHP 8.1

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

### 3.b. Setting Up ionCube

Go to Tools & Settings > PHP Settings

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/plesk-images/php-settings.png" alt="" style=" width:600px">

Click on the required PHP handler, for example, 8.1.X FPM application

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/plesk-images/fpm-application.png" alt="" style=" width:600px">

Go to Manage PECL Packages

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/plesk-images/pecl-packages.png" alt="" style=" width:600px">

Search "ioncube" and click install the ioncube loader

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/plesk-images/pecl-installer.png" alt="" style=" width:600px">


### 3.c. Install wkhtmltopdf

Wkhtmltopdf is an open source simple and much effective command-line shell utility that enables user to convert any given HTML (Web Page) to PDF document or an image (jpg, png, etc).

It uses WebKit rendering layout engine to convert HTML pages to PDF document without losing the quality of the pages. Its is really very useful and trustworthy solution for creating and storing snapshots of web pages in real-time.

```
apt-get -y install wkhtmltopdf
```



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


## 6. Scheduling Tasks

go to Tools & Settings > Scheduled Tasks (Cron jobs) > Add Task. 

---- Scheduled Tasks ----

---- Add Task ----

Fill in the Command text field with the cron command

```
/opt/plesk/php/8.1/bin/php /var/www/vhosts/-- DOMAIN NAME --/httpdocs/artisan schedule:run 2>&1
```

Click Add task and set specify Run parameter to Cron style.

Fill in the Run text field with cron-style time syntax

```
*****
```

---- schedule-a-task ----

## 7. Redis Installation

Redis is an open-source (BSD licensed), in-memory data structure store, used as a database, cache and message broker.

This is an optional step and will improve system performance and is highly recommended.

[Redis installation documentation](/docs/installation/providers/enterprise/plesk-redis)


## 8. SSL Installation

### Let's Encrypt

- Go to Websites & Domains > domain name and click SSL/TLS Certificates:

---- SSLTLS-Certificates ----

- At the bottom of the page, click Install in the section More options > Install a free basic certificate provided by Let's Encrypt:

---- install-ssl ----

Select the desired options for the certificate to be issued. We recommend enabling the checkboxes:

- Secure the domain name
- Include a "www" subdomain for the domain and each selected alias
- Secure webmail on this domain
- Assign the certificate to mail domain

Note: The specified Email address will be used to receive important notifications and warnings about the certificate sent by Let's Encrypt. Plesk by default takes the email from the owner of the domain to secure.

- Click Get it free

---- install-ssl-1 ----

## 9. Install Faveo

<a id="9Install-Faveo" 
name="9Install-Faveo"></a>

Now you can install Faveo via [GUI](/docs/installation/installer/gui) Wizard or [CLI](/docs/installation/installer/cli)


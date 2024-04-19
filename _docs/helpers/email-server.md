---
layout: single
type: docs
permalink: /docs/helpers/email-server/
redirect_from:
  - /theme-setup/
last_modified_at: 2024-04-19
last_modified_by: Mohammad_Asif
toc: true
title: "Setup Email Server for Faveo"
---
<img alt="ftp" src="https://cdn-icons-png.flaticon.com/512/6554/6554774.png" width="200"  />

# Introduction: 
Setting up your own email server on Ubuntu Server allows you to have complete control over your email communication without relying on third-party services. By following these instructions, you can bypass daily email limits and ensure reliable delivery for your business or personal needs.

Setting up your own email server on Ubuntu 22.04 involves several steps including installing and configuring the necessary software, setting up DNS records, and securing your server. Below are the instructions, commands, and DNS records you'll need:

## Step 1: Install Required Packages

```
sudo apt update && sudo apt upgrade
```

Set the Server Hostname.

```
sudo hostnamectl set-hostname mail.yourdomain.com
```
Install MySQL Server

```
sudo apt install mysql-server
```

Now install Postfix, Devcot and Roundcube

```
sudo apt install postfix dovecot-core dovecot-imapd dovecot-pop3d roundcube roundcube-core roundcube-mysql
```

During the installation, you will be prompted to configure Postfix. Choose "Internet Site" and enter your domain name when prompted. Setup the Database Password for roundcube as well in this step.

## Step 2: Configure Postfix
Edit Postfix Configuration:

```
sudo nano /etc/postfix/main.cf
```

Ensure the following settings are configured or adjusted:

```
myhostname = mail.yourdomain.com
mydomain = yourdomain.com
```

Restart Postfix
```
sudo systemctl restart postfix
```

## Step 3: Configure Dovecot
Edit Dovecot Configuration:
```
sudo nano /etc/dovecot/dovecot.conf
```

Ensure the following settings are configured or adjusted:

```
listen = *
mail_location = maildir:~/Maildir
```

---

Edit Dovecot Authentication Configuration:

```
sudo nano /etc/dovecot/conf.d/10-auth.conf
```

Ensure the following settings are configured or adjusted:

```
disable_plaintext_auth = no
auth_mechanisms = plain login
```

Restart Dovecot

```
sudo systemctl restart dovecot
```

## Step 4: Roundcube Installation and Configuration:

Download Roundcube:

```
cd /tmp
wget https://github.com/roundcube/roundcubemail/releases/download/1.5.2/roundcubemail-1.5.2-complete.tar.gz
```

Extract Roundcube:

```
tar -zxvf roundcubemail-1.5.2-complete.tar.gz
sudo mv roundcubemail-1.5.2 /var/www/html/roundcube
```

Create Roundcube Configuration File:

```
sudo cp /var/www/html/roundcube/config/config.inc.php.sample /var/www/html/roundcube/config/config.inc.php
```

Edit Roundcube Configuration:

```
sudo nano /var/www/html/roundcube/config/config.inc.php
```

Change password in the below line:
```
$config['db_dsnw'] = 'mysql://roundcube:PASSWORD@localhost/roundcube';
```

Set Permissions:

```
sudo chown -R www-data:www-data /var/www/html/roundcube
```

Access Roundcube via Browser:

Open a web browser and go to http://mail.yourdomain.com/roundcube to complete Roundcube setup.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/helpers/images/Roundcube.png" alt="" style=" width:600px ; height:250px ">



## Step 5. DNS Changes:

Here are the DNS records you need to create on your domain registrar's control panel:

### Required Records:

---

#### A Record:
Translate domain names (like "yourdomain.com") to IP addresses (like "111.22.333.44") for web browsing.

**Name:** mail.yourdomain.com

**Value:** 111.22.333.44 (Your server's IP address)

**TTL:** You can use the default TTL (usually 3600 seconds or 1 hour)

---

#### MX Record:
Direct incoming emails to the specific server that handles them.

**Priority:** Set a low priority (e.g., 10) initially 

**Name:** @ (or leave blank for the root domain)

**Value:** mail.yourdomain.com

**TTL:** You can use the default TTL

---

#### SPF Record:

Helps prevent email spoofing by identifying authorized mail servers for your domain.

**Name:** @ (or leave blank for the root domain)

**Value:** The generated SPF record string (e.g., "v=spf1 mx:mail.yourdomain.com ~all").

**TTL:** You can use the default TTL

---


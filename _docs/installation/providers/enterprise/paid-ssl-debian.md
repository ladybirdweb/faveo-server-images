---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/paid-ssl-debian/
redirect_from:
  - /theme-setup/
last_modified_at: 2024-09-12
last_modified_by: Mohammad_Asif
toc: true
title: Install Paid SSL for Faveo on Debian
---


<img alt="debian" src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Debian-OpenLogo.svg/109px-Debian-OpenLogo.svg.png" width="120" height="120" />

## Introduction

This document will guide on how to install Paid SSL certificates on Debian with apache2.


## Obtain SSL Certificate and CA Certificate

1. Obtain your SSL certificate (`your_domain.crt`) and private key (`your_domain.key`) from your SSL certificate provider.
2. If applicable, also obtain the CA certificate (`your_domain-CA.crt`) from your SSL provider.


## Setting up the Virtual host file for the Paid SSL certificate's.

- We need to enable some Modules for the ssl as below : 
```
sudo a2enmod ssl
systemctl restart apache2
```
- The above will install mod_ssl module and restart apache.
- Before creating the Virtual host file for SSL we need to copy the created SSL certificate's and Key file to the corresponding directory with below command, these commands should be runned from the SSL Directory.
```
cp your_domain.crt /etc/ssl/certs
cp your_domain.key /etc/ssl/private
cp your_domain-CA.crt /usr/local/share/ca-certificates/
```
- Then adding the Virtual host file, for that we need to create a file in webserver directory as <b> /etc/apache2/sites-available/faveo-ssl.conf.</b>
- Then need to copy the below configuration inside the faveo-ssl.conf file.

```
<IfModule mod_ssl.c>
    <VirtualHost *:443>
        ServerName --DOMAINNAME--
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/faveo/public

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        SSLEngine on

        SSLCertificateFile      /etc/ssl/certs/your_domain.crt
        SSLCertificateKeyFile   /etc/ssl/private/your_domain.key
        SSLCertificateChainFile /usr/local/share/ca-certificates/your_domain-CA.crt

        <FilesMatch "\.(cgi|shtml|phtml|php)$">
            SSLOptions +StdEnvVars
        </FilesMatch>
        <Directory /usr/lib/cgi-bin>
            SSLOptions +StdEnvVars
        </Directory>

    </VirtualHost>
</IfModule>
```

## After Creating the Virtual Host file we need to add the local host for the domain.
- Then need to update the CA certificate's to that run the below command.
```
sudo update-ca-certificates
```

- After adding the SSL certificates and virtual hosts we need to add the domain to the hosts file to the local host as below.
```
nano /etc/hosts
```
- In the above file add the below line replace the domain or the IP which is used for the faveo.
```
127.0.0.1  ---Domain or IP---
```
- After the above is done restart the webserver and php-fpm service.
```
service php8.1-fpm restart
service apache2 restart
```

- Now check the faveo on the Browser it will take you to probe page, if everything is good then you can proceed with the installation in Browser.
---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/paid-ssl-rocky/
redirect_from:
  - /theme-setup/
last_modified_at: 2024-11-20
last_modified_by: Mohammad_Asif
toc: true
title: Install Paid SSL for Faveo on Rocky
---

<img alt="Rocky Logo" src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Rocky_Linux_wordmark.svg/800px-Rocky_Linux_wordmark.svg.png" width="200"  />

## Introduction

This document will guide on how to install Paid SSL certificates on Rocky with apache2.


## Obtain SSL Certificate and CA Certificate

1. Obtain your SSL certificate (`your_domain.crt`) and private key (`your_domain.key`) from your SSL certificate provider.
2. If applicable, also obtain the CA certificate (`your_domain-CA.crt`) from your SSL provider.

## Setting up the Virtual host file for the Paid SSL certificate's.

- We need to enable some Modules for the ssl as below : 
```
dnf install mod_ssl
systemctl restart httpd
```
- The above will install mod_ssl module and restart apache.
- Before creating the Virtual host file for SSL we need to copy the created SSL certificate's and Key file to the corresponding directory with below command, these commands should be runned from the SSL Directory.
```
cp your_domain.crt /etc/pki/tls/certs
cp your_domain.key /etc/pki/tls/private
cp your_domain-CA.crt /etc/pki/ca-trust/source/anchors/
```
- Then adding the Virtual host file, for that we need to create a file in webserver directory as <b> /etc/httpd/conf.d/faveo-ssl.conf.</b>

```
nano /etc/httpd/conf.d/faveo-ssl.conf
```

- Then need to copy the below configuration inside the faveo-ssl.conf file.

```
<IfModule mod_ssl.c>
        <VirtualHost *:443>
                ServerAdmin ---DomainName or IP---

                DocumentRoot /var/www/faveo/public

                ErrorLog /var/log/httpd/faveo-error.log 
                CustomLog /var/log/httpd/faveo-access.log combined

                SSLEngine on

                SSLCertificateFile      /etc/pki/tls/certs/your_domain.crt
                SSLCertificateKeyFile /etc/pki/tls/private/your_domain.key

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

- Need to update the CA certificate's run the below command to update the CA certs.
```
update-ca-trust extract
```

- After adding the SSL certificates and virtual hosts we need to add the domain to the hosts file to the local host as below.
```
nano /etc/hosts
```
- In the above file add the below line replace the domain or the IP which is used for the faveo.
```
127.0.0.1  ---Domain or IP---
```
After the above is done restart the webserver and php-fpm service.
```
systemctl restart httpd
systemctl restart php-fpm.service
```

- Now check the faveo on the Browser it will take you to probe page, if everything is good then you can proceed with the installation in Browser.

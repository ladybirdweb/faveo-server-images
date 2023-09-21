
<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/litespeed-webserver-logo.png?raw=true" height="120" />

## Introduction

This document will list on how to install LetsEncrypt SSL on Ubuntu Running litespeed Web Server.

PS : Please replace example.com with your valid domain name which is mapped with your server

We will install following dependencies in order to make LetsEncrypt SSL work:

- certbot

### Downloading the LetsEncrypt client for Ubuntu

```
sudo apt update
sudo apt install certbot
```

### Setting up the SSL certificate

Certbot will handle the SSL certificate management quite easily, it will generate a new certificate for provided domain as a parameter.

In this case, example.com will be used as the domain for which the certificate will be issued:

```
certbot certonly --webroot -w /usr/local/lsws/Example/html/faveo -d example.com
```

You will then be prompted to answer the following questions.

- Enter Email address: Type in your email address
- Accept the terms of service: A
- Share your Email Address with EFF: Type Y for yes and N for No.
- Enter Domain name: Type your FQDN (fully qualified domain name) here
- Input the Web root: /usr/local/lsws/Example/html/faveo/

Once you have answered all the questions and validation process is complete, the certificate files will be saved in /etc/letsencrypt/live/**example.com**/ directory

**Output**

```cpp
Successfully received certificate.
Certificate is saved at: /etc/letsencrypt/live/example.com/fullchain.pem
Key is saved at:         /etc/letsencrypt/live/example.com/privkey.pem

```

Next, configure the Faveo site on your litespeed server to use the SSL certificate. Navigate to the Virtual Host configuration and open the SSL tab. Edit the SSL Private Key & Certificate.

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/ls-virtualhost-ssl.png?raw=true" />


Once completed, go to Listeners and add a new listener.

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/ls-listener-add-ssl.png?raw=true" />

Fill in the fields as follows:

```
Listener Name: SSL
IP Address: ANY
Post: 443
Binding:
Enable REUSEPORT: Not Set
Secure: Yes
```

Once all set, apply the new settings by clicking the save icon on the right.

Next, view the SSL listener to configure the Virtual host mapping.
Add a row in Virtual Host Mappings.
Choose the virtual host and type in your domain name. Save the settings from the save button on the top right corner.

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/ls-listener-ssl-add-domain.png?raw=true" />

Next, configure the Faveo site on your litespeed server to use the SSL certificate. Navigate to the SSL listener configuration and open the SSL tab. Edit the SSL Private Key & Certificate.

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/litespeed-images/ls-listener-ssl-add.png?raw=true" />

Once you’ve configured the SSL with your litespeed server, click the gracefully restart icon to apply the changes.

### SWITCH TO TERMINAL
```
sudo ufw allow 443/udp
sudo ufw status verbose
```

### TEST HTTP3/QUIC
[https://www.http3check.net/](https://www.http3check.net/)

### Setting up auto renewal of the certificate

#### CRON COMMANDS

```
sudo crontab -l
```

The above command will list the root cron jobs To create a new root cron, the command is:

```
sudo crontab -e
```

Scroll to the end and add the cron:

```
m h dom mon dow command
30 2 7 * * certbot renew --force-renewal
00 3 7 * * /usr/local/lsws/bin/lswsctrl reload
```

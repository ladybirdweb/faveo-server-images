
<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/openlitespeed-images/openlitespeed_logo_grey_bold.png?raw=true" width="200px" />

## Introduction

This document will list on how to install LetsEncrypt SSL on Ubuntu Running Openlitespeed Web Server.

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

Next, configure the Faveo site on your OpenLiteSpeed server to use the SSL certificate. Navigate to the Virtual Host configuration and open the SSL tab. Edit the SSL Private Key & Certificate.

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/openlitespeed-images/op-add-ssl-keys.png?raw=true" />

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/openlitespeed-images/op-ssl-keys.png?raw=true" />

Open the SSL tab. Edit the Security.

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/openlitespeed-images/op-ssl-security-1.png?raw=true" />

Fill in the fields as follows:

```
SSL Renegotiation Protection: Not Set
Enable Session Cache: Not Set
Enable Session Tickets: Not Set
ALPN: HTTP/2,HTTP/3 
Enable HTTP3/QUIC: Yes
```

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/openlitespeed-images/op-ssl-security-2.png?raw=true" />

Once completed, go to Listeners and add a new listener.

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/openlitespeed-images/op-ssl-listener.png?raw=true" />

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

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/openlitespeed-images/op-listener-enable-secure.png?raw=true" />

Next, view the SSL listener to configure the Virtual host mapping.

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/openlitespeed-images/op-ssl-listener.png?raw=true" />

Add a row in Virtual Host Mappings.

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/openlitespeed-images/op-add-virtual-host.png?raw=true" />

Choose the virtual host and type in your domain name. Save the settings from the save button on the top right corner.

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/openlitespeed-images/op-virtual-host-domains.png?raw=true" />

Next, configure the Faveo site on your OpenLiteSpeed server to use the SSL certificate. Navigate to the SSL listener configuration and open the SSL tab. Edit the SSL Private Key & Certificate.

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/openlitespeed-images/op-listener-ssl-1.png?raw=true" />

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/openlitespeed-images/op-listener-ssl-2.png?raw=true" />


Once you’ve configured the SSL with your OpenLiteSpeed server, click the gracefully restart icon to apply the changes.

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

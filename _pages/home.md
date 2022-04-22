---
layout: single
permalink: /
type: docs
author_profile: false
toc: true
---

Welcome to the Faveo installation documentation.
This documentation shows how to install Faveo Helpdesk on various platforms(OS)

# About Faveo
Faveo is a leading open source, self-hosted, on-premise help desk software. 

[Find out more >>](https://www.faveohelpdesk.com){: .btn .btn--info}

# Installing Faveo <!-- omit in toc -->

Faveo can be installed on a variety of platforms. The choice of the platform is yours.

- [About Faveo](#about-faveo)
  - [Requirements](#requirements)
  - [Installation instructions for specific platforms](#installation-instructions-for-specific-platforms)
    - [Installation instructions for Freelancer, paid and Enterprise editions](#installation-instructions-for-freelancer-paid-and-enterprise-editions)
    - [Installation instructions for Community edition](#installation-instructions-for-community-edition)
    - [Installation on a shared server](#installation-on-a-shared-server)
  - [Help](#help)
- [One click installers](#one-click-installers)
[Installation via scripts](#installation-via-scripts)


<a id="markdown-requirements" name="requirements"></a>
## Requirements

The best way to setup the project is to use the same configuration that [Homestead](https://laravel.com/docs/homestead) uses. 

Basically, Faveo depends on the following:

-   **Apache** (with mod_rewrite enabled) or **Nginx** or **IIS**
-   **Git**
-   **PHP 7.3.x** with the following extensions: curl, dom, gd, json, mbstring, openssl, pdo_mysql, tokenizer, zip
-   **Composer**(Optional)
-   **MySQL 5.7.x** or **MariaDB 10.3+**
-   **Redis** or **Beanstalk**(Optional)

For complete minimum requirement list [check here](/docs/system-requirement/requirement)


<a id="markdown-installation-instructions-for-specific-platforms" name="installation-instructions-for-specific-platforms"></a>
## Installation instructions for specific platforms

The preferred OS distribution is Cent OS 7, simply because all the development is made on it and we know it works. However, any OS that lets you install the above packages should work.

<a id="markdown-generic-linux-instructions-enterprise" name="generic-linux-instructions-enterprise"></a>
### Installation instructions for Freelancer, paid and Enterprise editions
* [Cent OS 8 Stream with Apache](/docs/installation/providers/enterprise/centos8s-apache)
* [Cent OS 8 Stream with NGINX](/docs/installation/providers/enterprise/centos8s-nginx)
* [Cent OS with Apache](/docs/installation/providers/enterprise/centos-apache)
* [Cent OS with NGINX](/docs/installation/providers/enterprise/centos-nginx)
* [Rocky OS with Apache](/docs/installation/providers/enterprise/rocky-apache)
* [Rocky OS with NGINX](/docs/installation/providers/enterprise/centos-nginx)
* [Ubuntu with Apache](/docs/installation/providers/enterprise/ubuntu-apache)
* [Ubuntu with NGINX](/docs/installation/providers/enterprise/ubuntu-nginx)
* [Debian with Apache](/docs/installation/providers/enterprise/debian-apache)
* [Debian with NGINX](/docs/installation/providers/enterprise/debian-nginx)
* [Windows](/docs/installation/providers/enterprise/windows)
* [CentOS Web Panel](/docs/installation/providers/enterprise/centos-web-panel)
* [WampServer](/docs/installation/providers/enterprise/wamp)
* [Docker](/docs/installation/providers/enterprise/faveo-helpdesk-docker/)
* [Kuberenetes](/docs/installation/providers/enterprise/faveo-helpdesk-k8s/)

<a id="markdown-generic-linux-instructions" name="generic-linux-instructions"></a>
### Installation instructions for Community edition

* [CentOS with Apache](/docs/installation/providers/community/centos-apache)
* [Ubuntu with Apache](/docs/installation/providers/community/ubuntu-apache)
* [Debian with Apache](/docs/installation/providers/community/debian-apache)

<a id="markdown-one-click-installer" name="markdown-one-click-installer"></a>
### One click installers 

Faveo Helpdesk Community can be installed using following installers
- **Softaculous** [https://www.softaculous.com/apps/customersupport/Faveo_Helpdesk](https://www.softaculous.com/apps/customersupport/Faveo_Helpdesk)
- **Fantastico** [https://www.netenberg.com/fantastico.php](https://www.netenberg.com/fantastico.php)

<a id="markdown-script-installer" name="markdown-script-installer"></a>
### Installation via scripts 
We have created script for simple, one click installtion of Faveo, this script supports Apache webserver on Ubuntu 18.04, 20.04, Centos 7, 8 Stream, Rocky 8, Debian 10 (Buster).

**For Faveo Helpdesk Installation script**
* click on the below link and download the file "faveo-autoscript.sh" once downloaded copy the file to the linux server where we need to install faveo.


* [Installation Script](/installation-scripts/FaveoInstallationScripts/faveo-autoscript.sh) 

* Once the file is copied to the faveo server we need to make the file excecutable by using the below command we will change the permission to excecute.
```
chmod +x faveo-autoscript.sh
```
* After changing the file permission we need to excecute the file by using the below command.
```
./faveo-autoscript.sh
```
* After excecuting the file it will ask for the below values please keep them ready before starting the script.
```
Domain             - (The domain propagated to the faveo server public IP)
Email
Faveo License code - (This can be obtained from https://billing.faveohelpdesk.com)
Faveo Order No     - (This can be obtained from https://billing.faveohelpdesk.com)
```

<a id="markdown-shared-sever" name="markdown-shared-sever"></a>
### Installation on a shared server

Faveo can also be installed on a shared server, though we highly recommend cloud, VPS or dedicated server for best performance and more control
* [cPanel](/docs/installation/providers/community/cpanel)

<a id="markdown-help" name="markdown-help"></a>
## Help

If you'd like professional help commercial support is available, email us through the [contact form](https://www.faveohelpdesk.com/contact-us/).
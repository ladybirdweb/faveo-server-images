# Faveo Server Images
This repository contains various scripts &amp; images to install Faveo Helpdesk on various platforms(OS)


# Installing Faveo (Generic) <!-- omit in toc -->

Faveo can be installed on a variety of platforms. The choice of the platform is yours.

- [Requirements](#requirements)
- [Installation instructions for specific platforms](#installation-instructions-for-specific-platforms)
  - [Linux installation instructions for Community version](#markdown-generic-linux-instructions)
  - [Linux installation instructions for Freelancer, paid and Enterprise version](#markdown-generic-linux-instructions-enterprise)
  - [One Click Installer](#markdown-one-click-installer)
  - [Installation via scripts](#markdown-script-installer)
  - [Installation on a shared server](#markdown-shared-sever)
- [Contributing](#markdown-contributing)
- [Help](#markdown-help)
- [References](#markdown-references)

<a id="markdown-requirements" name="requirements"></a>
## Requirements

If you don't want to use Docker, the best way to setup the project is to use the same configuration that [Homestead](https://laravel.com/docs/homestead) uses. Basically, Faveo depends on the following:

-   **Apache** (with mod_rewrite enabled) or **Nginx** or **IIS**
-   **Git**
-   **PHP 7.3.x** with the following extensions: curl, dom, gd, json, mbstring, openssl, pdo_mysql, tokenizer, zip
-   **Composer**(Optional)
-   **MySQL 5.7.x** or **MariaDB 10.3+**
-   **Redis** or **Beanstalk**(Optional)

For complete minimum requirement list [check here](/docs/system-requirement/readme.md)


<a id="markdown-installation-instructions-for-specific-platforms" name="installation-instructions-for-specific-platforms"></a>
## Installation instructions for specific platforms

The preferred OS distribution is Cent OS 8, simply because all the development is made on it and we know it works. However, any OS that lets you install the above packages should work.

<a id="markdown-generic-linux-instructions" name="generic-linux-instructions"></a>
### Installation instructions for Community version
* [Ubuntu with Apache](/docs/installation/providers/community/ubuntu-apache.md)
* [CentOS with Apache](/docs/installation/providers/community/centos-apache.md)

<a id="markdown-generic-linux-instructions-enterprise" name="generic-linux-instructions-enterprise"></a>
### Installation instructions for Freelancer, paid and Enterprise version
* [Cent OS with Apache](/docs/installation/providers/enterprise/centos-apache.md)
* [Cent OS with NGINX](/docs/installation/providers/enterprise/centos-nginx.md)
* [Ubuntu with Apache](/docs/installation/providers/enterprise/ubuntu-apache.md)
* [Ubuntu with NGINX](/docs/installation/providers/enterprise/ubuntu-nginx.md)
* [Windows 2019](/docs/installation/providers/enterprise/windows.md)

<a id="markdown-one-click-installer" name="markdown-one-click-installer"></a>
### One click installers 

Faveo Helpdesk Community can be installed using following installers
- **Softaculous** https://www.softaculous.com/apps/customersupport/Faveo_Helpdesk
- **Fantastico** https://www.netenberg.com/fantastico.php

<a id="markdown-script-installer" name="markdown-script-installer"></a>
### Installation via scripts 
We have created script for simple, one click installtion of Faveo.

**For Faveo Helpdesk Freelancer, paid and Enterprise version**

* [Cent OS 7](/installation-scripts/helpdesk/centos7/readme.md)
* [Ubuntu 18](/installation-scripts/helpdesk/ubuntu18/readme.md)

**For Faveo Helpdesk Community**
* [Cent OS 7](/installation-scripts/helpdesk-community/centos7/readme.md)
* [Ubuntu 18](/installation-scripts/helpdesk/ubuntu18-community/readme.md)

<a id="markdown-shared-sever" name="markdown-shared-sever"></a>
### Installation on a shared server

Faveo can also be installed on a shared server, though we highly recommend cloud, VPS or dedicated server for best performance and more control
* [cPanel](https://support.faveohelpdesk.com/show/faveo-installation-in-cpanel)

<a id="markdown-contributing" name="markdown-contributing"></a>
## Contributing

Create your own fork of Faveo master repositoray and use [git-flow](https://github.com/nvie/gitflow) to create a new feature. Once the feature is published in your fork, send a pull request to begin the conversation of integrating your new feature into Faveo.

<a id="markdown-help" name="markdown-help"></a>
## Help

Visit the [issue](https://github.com/ladybirdweb/faveo-server-images/issues) page. And if you'd like professional help commercial support is available, email us through the [contact form](http://www.faveohelpdesk.com/contact-us/).

<a id="markdown-references" name="markdown-references"></a>
## References

- **Faveo Helpdesk** https://github.com/ladybirdweb/faveo-helpdesk
- **Faveo Docker** https://github.com/ladybirdweb/faveo-docker
- **Faveo Probe** https://github.com/ladybirdweb/faveo-probe

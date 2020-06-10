---
layout: single
type: docs
permalink: /installation-scripts/helpdesk/ubuntu18/
redirect_from:
  - /theme-setup/
last_modified_at: 2020-06-09
toc: true
title: "Faveo Helpdesk Freelancer, Enterprise auto install script for Ubuntu 18.04.4"
---

Faveo automatic installation script is available for <b>Ubuntu 18.04.4</b> 

The installation script will install following 
-   **Apache** (with mod_rewrite enabled) 
-   **PHP 7.3+** with the following extensions: curl, dom, gd, json, mbstring, openssl, pdo_mysql, tokenizer, zip
-   **MySQL 5.7+** or **MariaDB 10.3+**

This script should be used only on fresh/new copy of Ubuntu 18.04.4

# Run the script

To run, copy/paste this into the command-line

```sh 
apt-get install wget -y
wget https://github.com/ladybirdweb/faveo-server-images/blob/master/installation-scripts/helpdesk/ubuntu18/autoinstall.sh
```

Change execution permission for file.

```sh
chmod +x Faveo-ubuntu-apache.sh
```

Execute the script

```sh
./Faveo-ubuntu-apache.sh
```

Follow the final installation steps [here](/docs/installation/installer/gui)

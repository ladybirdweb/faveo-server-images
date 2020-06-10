---
layout: single
type: docs
permalink: /installation-scripts/helpdesk-community/centos7/
redirect_from:
  - /theme-setup/
last_modified_at: 2020-06-09
toc: true
title: "Faveo Helpdesk Community auto install script for CentOS 7"
sidebar:
  nav: "docs"
---

Faveo automatic installation script is available for <b>CentOS 7</b> 

The installation script will install following 
-   **Apache** (with mod_rewrite enabled) 
-   **PHP 7.3+** with the following extensions: curl, dom, gd, json, mbstring, openssl, pdo_mysql, tokenizer, zip
-   **MySQL 5.7+** 

This script should be used only on fresh/new copy of CentOS 7

## Run the script

To run, copy/paste this into the command-line
    
```sh
yum -y install wget
wget https://github.com/ladybirdweb/faveo-server-images/blob/master/installation-scripts/helpdesk-community/centos7/autoinstall.sh
```

Change execution permission for file.

```sh
chmod +x Faveo-Centos-apache.sh
```

Execute the script

```sh
./Faveo-Centos-apache.sh
```

## Install Faveo

Now you can install Faveo via [GUI](/docs/installation/installer/gui) Wizard or [CLI](/docs/installation/installer/cli)
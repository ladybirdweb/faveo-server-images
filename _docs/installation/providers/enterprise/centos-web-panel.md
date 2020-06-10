---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/centos-web-panel/
redirect_from:
  - /theme-setup/
last_modified_at: 2020-06-09
toc: true
title: "Faveo Installation on CentOS Web Panel"
---

This document will list on how to install Faveo Helpdesk on a new Centos Web Panel on Centos server.

**Note:** Need Centos 7 fresh server to Install Centos Web Panel(CWP).  

## 1.Setup Hostname

To start the CWP installation, login into your server as root and make sure to set the correct hostname.

Important: The hostname and domain name must be different on your server (for example, if domain.com is your domain on your server, then use hostname.domain.com as your fully qualified hostname).

```sh
hostnamectl set-hostname hostname.domain.com
```

## 2. Installing CentOS Web Panel

```sh
yum -y update
yum -y install wget
cd /usr/local/src
wget https://faveohelpdesk.com/user-manual/faveohelpdesk-scripts/cwp.sh
chmod +x cwp.sh
./cwp.sh
```
<img alt="" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1591247846cwp.png"  />

Please be patient as the installation progress can take between 10 and 20 minutes to complete. Once the install has finished you should see a screen saying “CWP” installed and list of credentials required to access the panel. Make sure to copy or write down the information and keep it safe:

Once ready, press “ENTER” for server reboot. If the system does not reboot automatically simply type “reboot” to reboot the server.

 
```sh
reboot
```
 
After server reboot, login into server as root, once login you will see different welcome screen with information about the logged users and the current disk space usage.

Now log in to your CentOS Web Panel server using the link provided by the installer on your server.

- **CentOS WebPanel Admin GUI:** https://SERVER-IP:2031/
- **Username:** root
- **Password:** your-root-password

<img alt="Cent OS Logo" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1591248703Screenshot%20from%202020-06-04%2011-01-07.png"  />

<img alt="Cent OS Logo" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1591248805cwp2.png"  />

Now, your installed Centos Web panel

Now, you installed Centos Web panel. You can host Faveo in this Centos Web Panel.

Note- You should have Domain name its pointing to the same server.

Create user account under User Accounts> New account.


<img alt="Cent OS Logo" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1591272040cwp4.png"  />

CWP by default PHP 5.6 will be installed. You can install different PHP versions and their extensions in the panel.

Faveo needs PHP 7.3,and some extensions.

    PHP Settings> php_switch_v2
    
<img alt="Cent OS Logo" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1591357225Screenshot%20from%202020-06-05%2017-09-43.png"  />
    
And ioncube loader must be installed to run Faveo.  You can enable by using below options.

PHP Settings> php_addons

<img alt="Cent OS Logo" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1591357359Screenshot%20from%202020-06-05%2017-12-23.png"  />

    
After Account created, You can login to user panel by https://SERVER-IP:2083/

Faveo needs empty Database, Please create Database Name and User for Faveo.

SQL Services> Mysql Manager

<img alt="Cent OS Logo" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1591272884cwp6.png"  />

Click on File Management> File manager and upload Faveo file downloaded from https://billing.faveohelpdesk.com 

<img alt="Cent OS Logo" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1591278035Screenshot%20from%202020-06-04%2019-10-18.png"  />

<img alt="Cent OS Logo" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1591278060Screenshot%20from%202020-06-04%2019-10-48.png"  />

After uploading Zip file, please extract it.

Please hit domain name in the browser and follow the web GUI guide https://support.faveohelpdesk.com/show/web-gui-installer

## Cron Job configuration

Please set cron for Faveo to fetch mails

<img alt="Cent OS Logo" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1591279511Screenshot%20from%202020-06-04%2019-34-55.png"  />

In Addition to that please Enable server Backup, Firewall and SSL Configuration.

## Backup configuration 

CWP settings > Backup configuration

<img alt="Cent OS Logo" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1591279511Screenshot%20from%202020-06-04%2019-34-55.png"  />
    
## SSL Configuration.

Webserver Settings > SSL Certificates

<img alt="Cent OS Logo" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1591336632Screenshot%20from%202020-06-05%2011-23-56.png"  />
    
## Firewall Configuration

Security > CSF firewall
    
<img alt="Cent OS Logo" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1591323259Screenshot%20from%202020-06-04%2019-36-20.png"  />
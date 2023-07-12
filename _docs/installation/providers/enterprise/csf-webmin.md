---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/csf-webmin/
redirect_from:
  - /theme-setup/
last_modified_at: 2023-07-12
last_modified_by: Mohammad_Asif
toc: true
title: "ConfigServer Security & Firewall  installation on Webmin"
---
<img alt="Windows" src="https://community.time4vps.com/uploads/editor/p2/mxdl93nqqtxy.png" width="500"  />


  - [<strong> Preliminary requirements</strong>](#Preliminary-requirements)
  - [<strong>1. CSF installation</strong>](#1CSF-installation)
  - [<strong>2. CSF module installation in Webmin</strong>](#2CSF-module-installation-in-Webmin)
  - [<strong>3. CSF configuration</strong>](#3CSF-configuration)


ConfigServer Security & Firewall (CSF)  is a Stateful Packet Inspection (SPI) firewall, login/intrusion detection, and security application for Linux servers provided by ConfigServer. Login Failure Daemon (LFD) is a daemon process that runs on our servers, which uses CSF for server security.

ConfigServer Security & Firewall (CSF) is a suite of scripts that provides:

- A straight-forward SPI iptables firewall script
- A daemon process that checks for Login Authentication
- A Control Panel configuration interface

<a id="Preliminary-requirements" name="Preliminary-requirements"></a>

### <strong>Preliminary requirements</strong>

- Ubuntu 22.04 Webmin" template installed on server
- *perl-libwww-perl*  installed on the server
```
apt-get install libwww-perl -y
```

- Fully updates server software
```
sudo apt update
```

<a id="1CSF-installation" name="1CSF-installation"></a>

### <strong>1. CSF installation</strong>

Installation of CSF is quite straightforward:

```
cd /usr/src
```

```
wget https://download.configserver.com/csf.tgz
```

```
tar -xzf csf.tgz
```

```
cd csf
```

```
sh install.sh
```

<a id="2CSF-module-installation-in-Webmin" name="2CSF-module-installation-in-Webmin"></a>

### <strong>2. CSF module installation in Webmin</strong>

CSF module installation is done through Webmin interface so first, you should log in to your Webmin instance. By default, the address is:

```
http://your-server-ip:10000
```

After successfully login you should select *Webmin* and *Webmin Configuration*:

<img src="https://community.time4vps.com/uploads/editor/iz/pjb88drmelmd.png" alt="" style=" width:350px ; height:200px"/>

In *Webmin Configuration* select *Webmin Modules*:

<img src="https://community.time4vps.com/uploads/editor/75/ah6qrakw95ij.png" alt="" style=" width:500px ; height:250px"/>

In *Webmin modules* select *From local files* and specify the path to module archive and isntall module.

<img src="https://community.time4vps.com/uploads/editor/39/7tr2ct4zgtr6.png" alt="" style=" width:500px ; height:250px"/>

> **NOTE:**
> If you are using "Authentic Theme 18.10" you should remove "csf.min.js" file because of a bug.

```
rm /usr/libexec/webmin/authentic-theme/extensions/csf.min.js -f
```

<a id="3CSF-configuration" name="3CSF-configuration"></a>

### <strong>3. CSF configuration</strong>

After successfully installation you can now configure your ConfigServer Security & Firewall. Select *System* and *ConfigServer Security & Firewall* in your Webmin instance:

<img src="https://community.time4vps.com/uploads/editor/5h/0wx98dvaa200.png" alt="" style=" width:350px ; height:200px"/>

You should now use the *Module config* button at the top left corner of the module:


<img src="https://images.time4vps.com/images/2020/02/28/8d1950d6a6e500213ae02be5b6f4650b.png" alt="" style=" width:500px ; height:250px"/>


First, we will turn of testing mode:

<img src="https://community.time4vps.com/uploads/editor/i6/bmrazrq3bwko.png" alt="" style=" width:500px ; height:100px"/>

And then we should restrict syslog/rsyslog access:

<img src="https://community.time4vps.com/uploads/editor/oa/7skmrd3f18r6.png" alt="" style=" width:500px ; height:100px"/>

After these changes press the button *Change* at the bottom of the page and *Restart csf+lfd* afterward.



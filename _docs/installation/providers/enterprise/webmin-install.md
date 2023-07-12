---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/webmin-install/
redirect_from:
  - /theme-setup/
last_modified_at: 2023-07-12
last_modified_by: Mohammad_Asif
toc: true
title: "Webmin Installation on Linux Server"
---
  - [<strong>1. Setup</strong>](#1Setup)
  - [<strong>2. Install</strong>](#2Install)

Webmin is a free, open-source application for Linux server administration. Webmin enables you to manage your Linux system's hardware and software, native and third-party applications, Webmin itself, and even log in with a web-based text terminal for those command-line purists.

<a id="1Setup" name="1Setup"></a>

### <strong>1. Setup</strong>

The simplest and best way to get Webmin is to use automatic *setup-repos.sh* script to configure official repositories on your *RHEL* or *Debian* derivative systems. It can be done in two easy steps:
```
curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh
```

```
sh setup-repos.sh
```

This script will automatically setup our repository and install our GPG keys on your system, and provide webmin package for installation and easy upgrades in the future. The supported and tested systems are Red Hat Enterprise Linux, Alma, Rocky,  or Debian, Ubuntu.

If you receive an error like *Hash algorithm SHA1 not available* on newer versions of RHEL or related Linux distributions, you may need to run *update-crypto-policies --set DEFAULT:SHA1* before re-running *setup-repos.sh*.

<a id="2Install" name="2Install"></a>

### <strong>2. Install</strong>

If Webmin repository was setup using our *setup-repos.sh* as described above then Webmin can be installed as easy as:

RHEL and derivatives
```
dnf install webmin
```

Debian and derivatives
```
apt-get install webmin
```

Webmin is installed on your server, you can log in to your Webmin instance. By default, the address is:

```
http://your-server-ip:10000
```

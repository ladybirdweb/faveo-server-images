---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/network-discovery/
redirect_from:
  - /theme-setup/
last_modified_at: 2023-09-20
last_modified_by: Mohammad_Asif
toc: true
title: Installing Faveo Network Discovery Tool on Linux Distributions.
---

[<strong>Introduction :</strong>](#introduction:) 

Faveo Network Discovery is a self-hosted software that can be installed on your local on-premisis Linux Servers. While this installation document provides a step-by-step guide during the installation, it’s essential and helpful to have general knowledge about Web Servers, PHP and MySQL.

---

[<strong>NOTE :</strong>](#note:) *The Installation steps for Faveo Network Discovery Tool  are same as that of **Faveo Helpdesk**. You only need to follow the below instructions in addition to the Faveo Helpdesk documentation.*

---

Faveo Network Discovery Tool can run on the following Linux Distributions:

- [<strong>Installation steps :</strong>](#installation-steps-) 
    - [<strong>1. Rocky Linux 9</strong>](#1-rocky-linux-9)
    - [<strong>2. Alma Linux 9:</strong>](#2-alma-linix-9)
    - [<strong>3. RHEL 9</strong>](#3-rhel-9)
    - [<strong>4. Ubuntu 20.04 & 22.04</strong>](#4-ubuntu-20.04-&-22.04)
    - [<strong>5. Debian 11</strong>](#5-debian-11)
 


---


<a id="1-rocky-linux-9" name="1-rocky-linux-9"></a>

### <strong>1. Rocky Linux 9</strong>

Package Installation:

```
sudo dnf upgrade --refresh -y
sudo dnf install -y nmap arp-scan net-tools
```

Sudo Configuration:

```
visudo
```

Add the following lines to allow the apache user to run arp-scan and nmap without a password:

```
apache ALL=NOPASSWD: /usr/sbin/arp-scan
apache ALL=NOPASSWD: /usr/bin/nmap
```

<a href="https://docs.faveohelpdesk.com/docs/installation/providers/enterprise/rocky9-apache/" target="_blank" rel="noopener">Click Here</a> to follow further installation steps.

---


<a id="2-alma-linix-9" name="2-alma-linix-9"></a>

### <strong>2. Alma Linux 9</strong>

Package Installation:

```
sudo dnf upgrade --refresh -y
sudo dnf install -y nmap arp-scan net-tools
```

Sudo Configuration:

```
visudo
```

Add the following lines to allow the apache user to run arp-scan and nmap without a password:

```
apache ALL=NOPASSWD: /usr/sbin/arp-scan
apache ALL=NOPASSWD: /usr/bin/nmap
```

<a href="https://docs.faveohelpdesk.com/docs/installation/providers/enterprise/alma9-apache/" target="_blank" rel="noopener">Click Here</a> to follow further installation steps.

---


<a id="3-rhel-9" name="3-rhel-9"></a>

### <strong>3. RHEL 9</strong>

Package Installation:

```
sudo dnf upgrade --refresh -y
sudo dnf install -y nmap arp-scan net-tools
```

Sudo Configuration:

```
visudo
```

Add the following lines to allow the apache user to run arp-scan and nmap without a password:

```
apache ALL=NOPASSWD: /usr/sbin/arp-scan
apache ALL=NOPASSWD: /usr/bin/nmap
```

<a href="https://docs.faveohelpdesk.com/docs/installation/providers/enterprise/rhel9-apache/" target="_blank" rel="noopener">Click Here</a> to follow further installation steps.

---


<a id="4-ubuntu-20.04-&-22.04" name="4-ubuntu-20.04-&-22.04"></a>

### <strong>4. Ubuntu 20.04 & 22.04</strong>

Package Installation (for each version):

```
sudo apt update && sudo apt upgrade -y
sudo apt install -y nmap arp-scan net-tools
```

Sudo Configuration:

```
visudo
```

Add the following lines to allow the www-data user to run arp-scan and nmap without a password for each Ubuntu version:

```
www-data ALL=NOPASSWD: /usr/sbin/arp-scan
www-data ALL=NOPASSWD: /usr/bin/nmap
```

<a href="https://docs.faveohelpdesk.com/docs/installation/providers/enterprise/ubuntu-apache/" target="_blank" rel="noopener">Click Here</a> to follow further installation steps.

---



<a id="5-debian-11" name="5-debian-11"></a>

### <strong>5. Debian 11</strong>

Package Installation:

```
sudo apt update && sudo apt upgrade -y
sudo apt install -y nmap arp-scan net-tools
```

Sudo Configuration:

```
visudo
```

Add the following lines to allow the www-data user to run arp-scan and nmap without a password:

```
www-data ALL=NOPASSWD: /usr/sbin/arp-scan
www-data ALL=NOPASSWD: /usr/bin/nmap
```

<a href="https://docs.faveohelpdesk.com/docs/installation/providers/enterprise/debian-apache/" target="_blank" rel="noopener">Click Here</a> to follow further installation steps.

---

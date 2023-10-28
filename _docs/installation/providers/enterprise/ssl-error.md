---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/ssl-error/
redirect_from:
  - /theme-setup/
last_modified_at: 2023-10-16
last_modified_by: Mohammad_Asif
toc: true
title: Resolve SSL Certificates Error for Faveo Probe Page.
---

[<strong>Introduction :</strong>](#introduction:)

This document provides instructions on how to resolve the SSL certificate Issue for Faveo Helpdesk.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/ssl-error/faveo-probe.png" alt="" style=" width:800px">


Faveo Helpdesk validates SSL certificates at the CLI level using the PHP cURL extension. 

In some cases, the **root** and **Intermediate** certificates will not be available in the OS  Trusted CA library which leads Faveo to consider the certificates provided by the CA not to be trusted. 

---

[<strong>Solution :</strong>](#solution:)

This can be resolved by manually adding the **root** and **Intermediate** certificates of the CA to the OS and updating the Trusted CA library.

## For Linux Operating Systems
Open the URL in your browser, click on the Padlock 🔒, a dropdown will open, click on *Connection is Secure > Certificate is valid > Details*.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/ssl-error/ssl-error1.gif" alt="" style=" width:800px">

Export the First and Second Certificates and name them *root.txt* and *inter.txt* respectively.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/ssl-error/ssll-error2.gif" alt="" style=" width:800px">

Open the two files by any text editor and copy them to the OS Trusted CA library with .crt extensions and update the CA store. 

---

### For Debian Based Systems
Copy the **root** and **Intermediate** certificates to **/usr/local/share/ca-certificates/** location.

Make a file root.crt and save the contents of root.txt to it that was saved on the local desktop.

```
nano /usr/local/share/ca-certificates/root.crt
```

Make a file inter.crt and save the contents of inter.txt to it that was saved on the local desktop.

```
nano /usr/local/share/ca-certificates/inter.crt
```

Update CA Store
```
sudo update-ca-certificates
```

Restart Apache Webserver
```
systemctl restart apache2
```

### For RedHat Based Systems
Install the ca-certificates package.

```
yum install ca-certificates
```

Copy the **root** and **Intermediate** certificates to **/etc/pki/ca-trust/source/anchors/** location.

Make a file root.crt and save the contents of root.txt to it that was saved on the local desktop.

```
nano /etc/pki/ca-trust/source/anchors/root.crt
```

Make a file inter.crt and save the contents of inter.txt to it that was saved on the local desktop.

```
nano /etc/pki/ca-trust/source/anchors/inter.crt
```

Update CA Store
```
update-ca-trust extract
```
Restart Apache Webserver
```
systemctl restart httpd.service
```

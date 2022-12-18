---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/script-installers/
redirect_from:
  - /theme-setup/
last_modified_at: 2022-12-05
toc: true
---

# Faveo Helpesk Installation via Scripts <!-- omit in toc -->

## Installing Faveo Helpdesk via Bash Script for:
- Ubuntu 20.04, 22.04
- Debian 11
- RHEL 9
- Rocky 9

Prerequisites:
- "wget" tool installed.
- sudo or root user privilege

* [Click here](/installation-scripts/FaveoInstallationScripts/faveo-autoscript.sh) to download the "install.sh" or use wget to download using the below command. 
 
```sh
wget https://github.com/ladybirdweb/faveo-server-images/raw/master/installation-scripts/FaveoInstallationScripts/install.sh
```

Once the file is downlaoded to the faveo server provide executable permission to the script.
```
chmod +x install.sh
```
Excecute the script.
```
./install.sh
```
When prompted input the following details.
```
Domain             - (The domain propagated to the faveo server public IP)
Email
Faveo License code - (This can be obtained from https://billing.faveohelpdesk.com)
Faveo Order No     - (This can be obtained from https://billing.faveohelpdesk.com)
```
<b>Note:</b> This script will install all the dependencies and requirements for Faveo Helpdesk to run that includes configuring supervisor and redis. The supervisor jobs will fail initially until the GUI part of the installation is completed. Run the below command to restart the supervisor daemon.

```sh
(Debian or Ubuntu)
systemctl restart supervisor
(RHEL or Rocky)
systemctl restart supervisord
```
Run the below to check the status of each Jobs
```sh
supervisorctl status
```






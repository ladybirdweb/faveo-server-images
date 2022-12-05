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

## Installing faveo Helpdesk via Bash Script on Ubuntu 22.04,20.04

Prerequisites:
- "wget" tool installed.
- sudo or root user privilege

* [Click here](/installation-scripts/FaveoInstallationScripts/faveo-autoscript.sh) to download the "faveo-autoscript.sh" or use wget to download using the below command. 
 
```sh
wget https://github.com/ladybirdweb/faveo-server-images/raw/master/installation-scripts/FaveoInstallationScripts/faveo-autoscript.sh
```

* Once the file is downlaoded to the faveo server provide executable permission to the script.
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
<b>Note:</b> This script will configured everything requried for Faveo Helpdesk to run that includes configuring supervisor and redis. The supervisor jobs will fail initially until the GUI part of the installation is completed. Run the below command to restart the supervisor daemon.

```sh
systemctl restart supervisor
```
Run the below to check the status of each Jobs
```sh
supervisorctl status
```






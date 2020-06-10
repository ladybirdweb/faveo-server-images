---
layout: single
type: docs
permalink: /installation-scripts/helpdesk/ubuntu18/
redirect_from:
  - /theme-setup/
last_modified_at: 2020-06-09
toc: true
---


# Faveo Helpdesk Freelancer, Enterprise auto install script

Automatic-installation script is available for <b>FRESH Ubuntu 18.04.4</b> installs at
https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk/ubuntu18/autoinstall.sh

# Run the script

To run, copy/paste this into the command-line

```sh 
apt-get install wget -y
wget https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk/ubuntu18/autoinstall.sh
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

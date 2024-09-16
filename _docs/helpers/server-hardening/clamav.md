---
layout: single
type: docs
permalink: /docs/helpers/server-hardening/clamav
redirect_from:
  - /theme-setup/
last_modified_at: 2024-09-12
last_modified_by: Mohammad_Asif
toc: true
title: "Installing ClamAV and Setting Up a Cron Job"
---

This guide provides step-by-step instructions for installing and configuring ConfigServer Security & Firewall (CSF) on a server.

<img alt="clamav" src="https://raw.githubusercontent.com/micahsnyder/clamav-documentation/main/src/images/logo.png" width="100"  />


### <strong>1.Install ClamAV</strong>

#### For Ubuntu and Debian

Update your package list:

```
sudo apt update
```
Install ClamAV and ClamAV Daemon:

```
sudo apt install clamav clamav-daemon -y
```

Update the ClamAV virus database

Stop the clamav-freshclam service (used to update the virus database)
```
sudo systemctl stop clamav-freshclam
```

Update the virus database manually:
```
sudo freshclam
```

Start the clamav-freshclam service again

```
sudo systemctl start clamav-freshclam
```

Enable & start the “clamav-daemon” service
```
sudo systemctl enable clamav-daemon
sudo systemctl start clamav-daemon
```
#### For AlmaLinux, Rocky Linux, and RHEL

Update your package list:

```
sudo dnf update
```
Install EPEL repository (if not already installed):

```
sudo dnf install epel-release
```

Install ClamAV:

```
sudo dnf install clamav clamav-update
```

Update the ClamAV virus database

Stop the clamav-freshclam service (used to update the virus database)
```
sudo systemctl stop clamav-freshclam
```

Update the virus database manually:
```
sudo freshclam
```

Start the clamav-freshclam service again

```
sudo systemctl start clamav-freshclam
```

Enable & start the “clamav-daemon” service
```
sudo systemctl enable clamd@scan
sudo systemctl start clamd@scan
```
### <strong>2. Set Up Directories</strong>

Create a directory for storing infected files:
```
sudo mkdir -p /var/virus-infected
```
Ensure the directory has the correct permissions for the clamscan operation:
```
sudo chmod 700 /var/virus-infected
```

### <strong>3. Set Up a Cron Job</strong>

Set up a cron job to automate the scanning process:

Open the crontab editor

```
sudo crontab -e
```
Add the following line to schedule the ClamAV scan every hour:
```
0 * * * * clamscan -r /var/www/faveo --move=/var/virus-infected
```

This line will run the clamscan command every hour, scanning the /var/www/faveo directory and moving infected files to /var/virus-infected.

Save and exit the editor.

### Create the Log Directory (if it doesn't exist)

Create the log directory:

```
sudo mkdir -p /var/log/clamav
```

This setup ensures ClamAV is installed, configured to scan the specified directory regularly, and moves any infected files to a dedicated directory.
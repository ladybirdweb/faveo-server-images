---
layout: single
type: docs
permalink: /docs/helper/enable-ssh/
redirect_from:
  - /theme-setup/
last_modified_at: 2024-10-04
last_modified_by: Mohammad_Asif
toc: true
title: "Enable SSH on Linux, Mac and Windows Devices"
---

This document explains how to enable SSH on various operating systems for Faveo Network Discovery, allowing data collection from these devices.

# 1. Linux

## a. For Debian-based Systems

1. Install OpenSSH Server:
```
sudo apt install openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
```

2. Enable SSH in the Firewall (if the firewall is enabled):
```
sudo ufw allow ssh
sudo ufw enable
sudo ufw status
```

3. Check if `OpenSSH `Server` is Installed:
```
sudo dpkg -l | grep openssh-server
sudo apt list --installed | grep openssh-server
systemctl status ssh
```

## b. For RHEL-based Systems

1. Install OpenSSH Server:
```
sudo yum install openssh-server
sudo systemctl enable sshd
sudo systemctl start sshd
```

2. Enable SSH in the Firewall (if the firewall is enabled):
```
sudo firewall-cmd --permanent --zone=public --add-service=ssh
sudo firewall-cmd --reload
```

3. Check if OpenSSH Server is Installed:
- To verify if openssh-server is installed and running, use:

```
systemctl status sshd
rpm -qa | grep openssh-server
```

# 2. Mac

## Method 1: Enable SSH via System Preferences

1. Open System Settings: Click the `Apple logo` in the top-left corner, and select `System Settings` (or `System Preferences` in older macOS versions).

2. Go to Sharing: In System Settings, scroll down and click `General`, then select `Sharing`. On older macOS versions, just click `Sharing`.

3. Enable Remote Login:

- In the `Sharing` section, look for `Remote Login`.

- Check the box next to `Remote Login` to enable SSH.

4. Allow Access: Choose whether to allow access for `All users` or only specific users.


## Method 2: Enable SSH via Terminal

1. Open Terminal: Launch the Terminal app (`Applications > Utilities`).

2. Run the following command to enable SSH
```
sudo systemsetup -setremotelogin on
```

3. Verify SSH is enabled:
```
sudo systemsetup -getremotelogin
```
If it returns `Remote Login: On`, SSH is enabled.

## Method 3: Check SSH Status
To check if the SSH service is running:
```
sudo launchctl list | grep ssh
```

Once enabled, you can SSH into your Mac using:
```
ssh your_username@your_mac_ip_address
```

# 3. Windows

## Method 1: Enable SSH via PowerShell

1. Check if OpenSSH is Installed:

Open PowerShell with administrative privileges and run:
```
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
```

2. Install OpenSSH Server (if not present):
```
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```

3. Start the SSH Server:

To start the SSH server (sshd), run:
```
Start-Service sshd
```

4. Check SSH Service Status:
```
Get-Service sshd
```

5. Enable SSH at Startup:
```
Set-Service -Name sshd -StartupType 'Automatic'
```

6. Check Firewall Rules:

Ensure that the firewall allows SSH traffic:
```
Get-NetFirewallRule -Name *ssh*
```

7. Add a Firewall Rule (if needed):
```
New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
```

Once enabled, you can use SSH from other devices using the following command:
```
ssh your_username@your_windows_ip_address
```





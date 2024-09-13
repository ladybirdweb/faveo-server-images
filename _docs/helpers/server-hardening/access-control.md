---
layout: single
type: docs
permalink: /docs/helpers/server-hardening/access-control
redirect_from:
  - /theme-setup/
last_modified_at: 2024-09-13
last_modified_by: Mohammad_Asif
toc: true
title: "Configuring SSH Access Controls in Linux Servers"
---

<img alt="ssh" src="https://www.redeszone.net/app/uploads-redeszone.net/2020/04/clave-ssh-windows.jpg?x=480&y=375&quality=40" width="200" height="90" />

This guide explains how to configure SSH access controls on Linux servers using `/etc/hosts.allow` and `/etc/hosts.deny`. It also covers additional SSH daemon settings to enhance security. The steps apply to both APT-based (Ubuntu, Debian) and YUM-based (Alma,Centos,Rocky,RHEL) systems.

## Prerequisites

OpenSSH server is already installed and running on your server.

## Introduction to /etc/hosts.allow and /etc/hosts.deny

**/etc/hosts.allow:** Controls which hosts (IP addresses or hostnames) are permitted to access specific services, including SSH.

**/etc/hosts.deny:** Controls which hosts are denied access to specific services.
The system checks hosts.allow first. If a match is found, access is granted. If no match is found, it checks hosts.deny.

## 1. Configure /etc/hosts.allow

This file specifies which IP addresses or subnets are allowed to access the SSH service.

#### Allow Specific IP Addresses

To allow SSH access from specific IP addresses (e.g., 192.168.1.100 and 192.168.1.101):
```
sudo nano /etc/hosts.allow
```

Add the following line:
```
sshd: 192.168.1.100, 192.168.1.101
```
> **Note:** These IPs can be Internal (Private) or External (Public) IPs

#### Allow a Subnet

To allow access from an entire subnet (e.g., 192.168.1.0/24):
```
sshd: 192.168.1.
```

## 2. Configure /etc/hosts.deny

This file specifies which IP addresses or subnets are denied access to the SSH service by default.

#### Deny All Other IPs

To deny SSH access to all IPs except those allowed in /etc/hosts.allow:
```
sudo nano /etc/hosts.deny
```

Add the following line:
```
sshd: ALL
```

## 3. Additional SSH Configuration

The SSH daemon `(sshd)` can be further configured to control access by user, group, or root login status. These settings are managed in the `/etc/ssh/sshd_config` file.

#### 3.1 Limit SSH Access by User

To allow only specific users to SSH into the server, edit the `sshd_config` file:
```
sudo nano /etc/ssh/sshd_config
```

Add or modify the following line:
```
AllowUsers user1 user2
```

Replace user1 and user2 with the usernames you want to allow.

#### 3.2 Deny SSH Access by User
To deny specific users:
```
DenyUsers user3 user4
```

Replace user3 and user4 with the usernames you want to deny.

#### 3.3 Disable Root Login
For security purposes, it is recommended to disable root login via SSH:
```
PermitRootLogin no
```

#### 3.4 Limit SSH Access by Group

We can create a seperate group `sshusers` and include all ssh users in that group and allow that group itself for ssh.
To allow only users in a specific group (e.g., sshusers):
```
AllowGroups sshusers
```

## 4. Restart SSH Service

After making changes to the hosts.allow, hosts.deny, or sshd_config files, restart the SSH service to apply the changes.

#### APT-based Systems (Ubuntu/Debian)
```
sudo systemctl restart ssh
```

#### YUM-based Systems (Alma/Centos/Rocky/RHEL)
```
sudo systemctl restart sshd
```

## Conclusion

By configuring SSH access controls using /etc/hosts.allow, /etc/hosts.deny, and additional SSH daemon settings, you can enhance the security of your Linux servers. Restricting access to trusted IP addresses and users minimizes the risk of unauthorized access.





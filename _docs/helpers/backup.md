---
layout: single
type: docs
permalink: /docs/helper/backup/
redirect_from:
  - /theme-setup/
last_modified_at: 2023-06-15
last_modified_by: Mohammad_Asif
toc: true
title: "Enable File Sysyem and Database Backup in Faveo"
---
Faveo has an inbuilt backup option which needs to be setup before taking backups. Let's configure backup for the Faveo by following the below steps.

## 1. Make storage folder for backups.

**a. For Linux Based Systems:**

Make a storage directory under the path /var/www by the following command.

```
mkdir -p /var/www/storage/
```

Change ownership of the of the storage directory by following commmand.

*For Ubuntu/Debian*
```
chown -R www-data:www-data /var/www/storage/
```

*For Alma, Rocky, RHEL*
```
chown -R apache:apache /var/www/storage/
```

**b. For Windows Based Systems:**

Make a storage directory under the path C:\inetpub\

<img src="https://toolbox.easeus.com/images/toolbox/file-lock/screenshots/create-new-folder-1.png" alt="" style=" width:400px ; height:250px ">

Right click on storage directory and in the security tab click on edit and add user IUSR. Give full permissions to IIS_IUSRS, IUSR and Users for the storage folder.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/windows-images/Permission.png?raw=true" alt="" style=" width:400px ; height:250px ">

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/permissioniis.png" alt="" style=" width:400px ; height:250px ">

## 2. Setup Backup Directory in Faveo.

Login into the Faveo and go to *Admin Panel > Settings > System Backup*.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/helpers/images/backup1.png" alt="" style=" width:400px ; height:170px ">

You will see the **Backup Storage Path** option, set it to /var/www/storage/ incase of Linux Servers and C:\inetpub\storage incase of Windows servers.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/helpers/images/backup2.png" alt="" style=" width:400px ; height:70px ">

---

<a href="https://support.faveohelpdesk.com/show/how-to-take-system-backup-for-database-and-file-system-in-faveo" target="_blank" rel="noopener">Click here</a> to check how to take system Backup for Database and file system in Faveo.

---
layout: single
type: docs
permalink: /docs/helpers/server-hardening/log-rotation
redirect_from:
  - /theme-setup/
last_modified_at: 2024-09-12
last_modified_by: Mohammad_Asif
toc: true
title: "OS Patching and House Keeping on Linux Servers"
---


<img alt="cron" src="https://www.pc-freak.net/images/Find-when-cron.daily-cron.monthly-cron.weekly-run-on-Redhat-CentOS-Debian-SuSE-SLES-Linux-cron-logo-1.png" width="250" height="60" />

## Introduction
Maintaining a secure and efficient server environment involves regular updates and housekeeping tasks. 

Three critical aspects of server maintenance are `OS patching`, `log rotation`, and cleaning up the `/tmp folder`. 

Automating these tasks using cron jobs ensures they are performed consistently without manual intervention, reducing the risk of security vulnerabilities and storage issues.

---

**OS Patching:** 
Keeping your operating system up-to-date is essential for protecting against security vulnerabilities and ensuring the latest features and improvements are installed. Regular patching helps maintain the integrity and performance of your system.

**Log Rotation:** 
System logs can grow quickly, consuming significant disk space. Log rotation manages this by compressing and archiving old logs, freeing up space and ensuring that critical information is retained without overwhelming the system.

**/tmp Folder Maintenance:** 
The /tmp directory is used to store temporary files created by various processes. Over time, these files can accumulate and consume valuable disk space. Regularly cleaning the /tmp folder ensures that unnecessary files do not affect system performance.

## Cron Jobs for Automation

To automate these tasks, we will set up cron jobs for each maintenance activity. Cron jobs are scheduled tasks in Unix-based systems that run automatically at specified intervals. We will define/edit the crons at the root level by the below command:
```
crontab -e
```

### 1. OS Patching (Daily at Midnight)
This cron job will update the operating system packages daily at midnight, ensuring that the system always has the latest security patches and updates.

For Debian Based Servers
```
0 0 * * * sudo apt update && sudo apt upgrade -y 
```

For RHEL Based Servers
```
0 0 * * * sudo yum update -y
```

### Log Rotation (Weekly on Saturday Midnight)
This cron job will rotate and compress logs every week on Saturday at midnight, preventing log files from growing too large and consuming excessive disk space.
```
0 0 * * 6 /usr/sbin/logrotate /etc/logrotate.conf
```

`/usr/sbin/logrotate`, `/etc/logrotate.conf` runs the logrotate utility with the main configuration file, which handles the rotation, compression, and archiving of logs as defined in `/etc/logrotate.conf`.

### /tmp Folder Cleanup (Daily for Files Older Than 7 Days)
This cron job will run  daily at midnight and delete files in the `/tmp` folder that are older than 7 days, keeping the directory clean and freeing up disk space.
```
0 0 * * * find /tmp -type f -mtime +7 -exec rm -f {} \;
```


## Conclusion
By setting up these cron jobs, you can automate essential maintenance tasks that are critical to keeping your server secure, efficient, and organized. Regular OS patching, log rotation, and /tmp folder cleanup will reduce the risk of vulnerabilities, manage disk usage effectively, and maintain overall system health.

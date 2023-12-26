---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/backup-script/
redirect_from:
  - /theme-setup/
last_modified_at: 2023-12-26
last_modified_by: Mohammad_Asif
toc: true
title: "Automated Backup Script for Faveo File System and Database to the FTP-Server"
---

<img src="https://www.faveohelpdesk.com/wp-content/uploads/2022/10/faveo-logo-1.png" alt="" style=" width:200px ; height:80px ">

## Backup Script


> **Note** : 
> This is an automated backup script that takes a backup of the Filesystem and Database in local and also has option to upload the backups to Remote server or Storage Box and also retains the backup data for a specified time on both remote and local.

> **Warning** : 
> This script works in LINUX BASED server's only

## Requirements 
---
> **Note**
> This script should be executed as root user or SUDO privileged user.

-   This script requires **Python3** and **Python3 modules:** os, shutil, paramiko, datetime, subprocess, time (To install this you can use **pip install MODULE-NAME**), **Cron, Tarball, FTP** to be installed in the server.

## Usage
---


<b>1. </b> Clone this repository to your server from where you want to take backups.

```
https://github.com/ladybirdweb/backup-script.git
```

<b>2. </b> Once the repository is cloned, go inside the directory and you can find four files as follows **mainlocal.py** file is to take and store backups locally, **mainftp.py** file is to take and store backups to remote server or storage box with FTP method, **mainscp.py** file is to take and store backups to remote server or storage box with SCP method and the last file **cron.sh** is to setup cron on the server to take backups. After cloning follow the below steps.

<b>3. </b> To take backups using this script we need to provide the following details to the python files.

<b>4. </b> First we need to set the variables to the python script based on which method is used. if the backups are taken and stored on the same server you need to provide the details on **mainlocal.py** file and also can ignore the details below (##THIS IS ONLY FOR THE REMOTE BACKUPS IGNORE FOR THE LOCAL BACKUP) and if the backups are moved to remote server or storage box the details should be provieded to either **mainftp.py** or **mainscp.py** depends on the methods used for moving backup files to remote server either FTP or SCP, below are the details that has to update in the python script.

```
# Set the Backup Retention period in days for REMOTE Default 7 days:
BACKUP_RETENTION = 7

# Set the Backup Retention period in days for local data, (defined Default as 5 mins):
LOCAL_BACKUP_RETENTION = 5 / (24 * 60)

# Set the directory you want to store backup files
BACKUP_DIRECTORY = "/path/to/backup/directory"

# Log File for purged file details
LOG_FILE = "/path/to/backup/directory/backup.log"

# Set the directory you want to take backup
BACKUP_SOURCE = "/path/to/directory/to/backup"

# Set the MySQL server credentials
MYSQL_HOST = "localhost"                       # Default is localhost if you want to use remote host change the value.
MYSQL_PORT = "3306"                            # Default is 3306 if you want to use a different port change the value accordingly.
MYSQL_USER = "database-username"
MYSQL_PASSWORD = "database-password"

# Set the database name you want to backup
DATABASE_NAME = "database-name"

# Set FTP credentials
FTP_HOST = "ftp-hostname"
FTP_PORT = "21"                               # Default port is 21 if you have a different value change it accordingly.
FTP_USER = "ftp-username"
FTP_PASS = "ftp-password"

# Set remote directory path to upload in FTP
REMOTE_DIR = "/remote/directory/in/ftp/server"
```


-  **BACKUP_RETENTION =** Here mention the backup retention period that you want to use in the remote FTP-Server in days (default is 7 days), this is used to save the last N no of days in the remote server.
- **LOCAL_BACKUP_RETENTION =** Here mention the backup retention period that you want to use in the local server in days (default is 5 mins). this is used to delete the N no of days old files in the local server.
- **BACKUP_DIRECTORY =** Here mention the directory where you want to store the backup zip files in the local server. (this should be an absolute path)
- **LOG_FILE =** Here mention the path to the script folder where the scripts are present and there will be a file called backup.log mention the same name for the file, this is used to log the backup operations and purge operations.
- **BACKUP_SOURCE=** Here mention the directory in which you want to take a backup i.e filesystem directory. (this should be an absolute path)
- **MYSQL_HOST =** Default is localhost if you want to use a remote host change the value.
- **MYSQL_PORT =** Default is 3306 if you want to use a different port change the value accordingly.
- **MYSQL_USER =** Here mention the MySQL user name. (this user should have full privileges on the DB which you want to take a backup)
- **MYSQL_PASSWORD =** Here mention the MySQL user password. 
- **DATABASE_NAME =** Here mention the Database name which we want to take backup.
- **FTP_HOST =** Here mention the FTP-Server hostname or IP.
- **FTP_PORT =** Default port is 21 if you have a different value change it accordingly.
- **FTP_USER =** Here mention the FTP user name.
- **FTP_PASS =** Here mention the FTP user password.
- **REMOTE_DIR =** Here mention the remote directory on FTP server where you want to upload the backup files.



<b>5. </b> Once the above details are added to the **mainloacl.py** or **mainftp.py** or **mainscp.py** file the python script is ready.

<b>6. </b> We need to execute the **cron.sh** this is a shell script you need to change the file permission and execute it to do the same you should be inside the cloned repository.

- To change the file permission run the below command.

```
chmod +x *
```

- To execute the script run the below command.

```
/bin/bash cron.sh
```


<b>7. </b> Once the script is executed it will ask you for following details.

- You can **ADD** or **REMOVE** cron with the first option, it will ask you whether to add or remove the cronjob like below: you need to enter add or remove as per your need (if you enter to remove the script will search and remove the backup script cronjob if present in the server, if you enter add it will continue to prceed with the following)

```
Do you want to add or remove the cron job? Enter 'add' or 'remove':
```

- Then it will ask a confirmation on whether the required details are added to **Python** file: you can respond with yes or no, if you have added the details enter yes or enter no it will stop the script.

```
Have you added the required details to the main.py script? Enter 'yes' or 'no':
```

- Then it will ask for the absolute path to the cloned directory, to get this detail you can run pwd from inside the clonned folder in your terminal and paste the output here.

```
Enter the directory path for the scripts (to get this directory use 'pwd' command from the clonned directory):
```

- Then it will ask for the cron interval there will be three options Daily, Weekly, Monthly 

```
Select the cron interval:
1. Daily (this cron will run daily)
2. Weekly (this cron is defaulted to run every Sunday on every week to change you need to edit interval_choice inside the cron.sh file)
3. Monthly (this cron is defaulted to run on the first of every month to change this you need to edit the interval choice inside the cron.sh file)
```

- The next step is to mention the time in 24.00 hrs format, on this time the cron will run at the specified interval.

```
Enter the time of day to run the cron job (in 24-hour format, e.g. 23:30) or press Enter to use the default time of midnight:
```

- The next step is to select whether to store backups in local server or to the remote serevr to do so the script will ask you the below and you can provide answers with A or B.

```
Do you want to store the backup Locally or to Remote storage: Please select (A) for Remote and (B) for Local (here need to select A or B : A is for remote storage and B is for local storage).
```

- The last step is to select which method should be used for storing the files to remote storage you can provide the preference with optioins C and D.

```
 Select SCP or FTP to upload the files to remote storage. 
 (SCP:C / FTP:D)
```

<b>8. </b> Once the above is done the cronjob will be created and the script will prompt you with a success message.

## Conclusion

Now the cron will run the script at the specified time and interval which will execute the main.py script to take backup and push to FTP-server.



---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/backup-script/
redirect_from:
  - /theme-setup/
last_modified_at: 2023-05-03
last_modified_by: Mohammad_Asif
toc: true
title: "Automated Backup Script for Faveo File System and Database to the FTP-Server"
---

<img src="https://www.faveohelpdesk.com/wp-content/uploads/2022/10/faveo-logo-1.png" alt="" style=" width:200px ; height:80px ">

## Backup Script


> **Note** : 
> This is an automated backup script that takes a backup of the Filesystem and Database and uploads the backups to the FTP-Server and retains the backup data for a specified time.

> **Warning** : 
> This script works in LINUX BASED server's only

## Requirements 
---
> **Note**
> This script should be executed as SUDO user or SUDO privileged user.

-   This script requires **Python3**, **Cron**, **Tarball**, **FTP** to be installed in the server.

## Usage
---


<b>1. </b> Clone this repository to your server from where you want to take backups.

```
https://github.com/ladybirdweb/backup-script.git
```

<b>2. </b> Once the repository is cloned go inside the directory and you can find two files **main.py** and **cron.sh** after that follow the below steps.

<b>3. </b> In this script we need to provide the below details to do the backup and upload operations.

<b>4. </b> First we need to set the variable to the script in the python script whcih you are using for local **mainlocal.py** file and for remote **mainremote.py** , below are the details that we have to update in the script.

```
# Set the Backup Retention period in days for REMOTE Default 7 days:
BACKUP_RETENTION = 7

# Set the Backup Retention period in days for local data, (defined Default as 5 mins):
LOCAL_BACKUP_RETENTION = 5 / (24 * 60)

# Set the directory you want to store backup files
BACKUP_DIRECTORY = "/path/to/backup/directory"

# Set the directory you want to take backup
BACKUP_SOURCE = "/path/to/directory/to/backup"

# Set the MySQL server credentials
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



<b>5. </b> Once the above details are added to the **mainloacl.py** or **mainremote.py** file the python script is ready.

<b>6. </b> We need to execute the **cron.sh** this is a shell script you need to change the file permission and execute it to do the same you should be inside the cloned repository.

- To change the file permission run the below command.

```
chmod +x *
```

- To execute the script run the below command.

```
/bin/bash cron.sh
```


<b>7. </b> Once the script is executed it will ask you for the below details.

- You can **ADD** or **REMOVE** cron with the first option, it will ask you whether to add or remove the cronjob like below: you need to enter add or remove as per your need (if you enter to remove the script will search and remove the backup script cronjob)

```
Do you want to add or remove the cron job? Enter 'add' or 'remove':
```

- Then it will ask a confirmation on whether the required details are added to **Python** file: you can respond with yes or no, if you have added the details enter yes or enter no it will stop the script.

```
Have you added the required details to the main.py script? Enter 'yes' or 'no':
```

- Then it will ask for the absolute path to the cloned directory, to get this detail you can run pwd in your terminal and paste the output here.

```
Enter the directory path for the scripts (to get this directory use 'pwd' command):
```

- Then it will ask for the cron interval there will be three options Daily, Weekly, Monthly 

```
Select the cron interval:
1. Daily (this cron will run daily)
2. Weekly (this cron is defaulted to run every Sunday on every week to change you need to edit interval_choice inside the cron.sh file)
3. Monthly (this cron is defaulted to run on the first of every month to change this you need to edit the interval choice inside the cron.sh file)
```

- The final step is to mention the time in 24.00 hrs format, on this time the cron will run at the specified interval.

```
Enter the time of day to run the cron job (in 24-hour format, e.g. 23:30) or press Enter to use the default time of midnight:
```


<b>8. </b> Once the above is done the cronjob will be created and the script will prompt you with a success message.

## Conclusion

Now the cron will run the script at the specified time and interval which will execute the main.py script to take backup and push to FTP-server.



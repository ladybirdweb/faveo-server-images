---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/generic-migration/
redirect_from:
  - /theme-setup/
last_modified_at: 2022-12-20
toc: true
title: Cloning/Migrating Faveo Helpdesk from one server to another
---

#  <!-- omit in toc -->



Cloning/migrating Faveo Helpdesk to a new server should be a pretty painless process. You really only have a few things to worry about:

- Your .env
- Your database
- Your faveo file system

The easiest way to handle this is to simply run a system backup through your Faveo Helpdesk. Login as an <b>Admin</b>, navigate to the <b>Admin panel > Settings > System Backup </b>which will generate faveo file system and database zip files, but if for some reason that’s not working for you, a regular database dump using phpMyAdmin or another MySQL/MariaDB tool should work fine too for database and manually archiving the faveo files with tools like zip or tar will work too.


- To take a backup of the faveo filesystem and database navigate to Admin Panel-> System Backups. Give the location of the backup path and make sure that the directory actually exists in the server if not create the directory and provide the necessary permission so the web server user is able to access that directory. Click on backup and the backup process will start in the background and you will get a notification once the backup is completed. The time to take backups depends on the size of the faveo file system and database.

<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/GUI-images/backup1.png?raw=true"/>


<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/GUI-images/backup2.png?raw=true"/>


<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/GUI-images/backup3.png?raw=true"/>

- Install all Faveo prerequisites on your target server.

- Import your data into your target server’s database. Refer to the .env file for the Database name, Database user, and password. It is advised you have the same credentials on the target server database too or you can update the new values in the .env on the target server once it is copied.

- Copy the Faveo files zip backup to the target server and extract it. Make sure to change the right ownership after extracting.

- If you’re using a newly named hostname (like faveo-dev.mycompany.com) make sure you update the “APP_URL” in the “.env” and update the DNS to be able to resolve the new hostname.

- Finally, run the below command inside the faveo directory to avoid the attachments link issue.

```sh
php artisan storage:link
```
- You should be all set.

---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/php-upgrade/
redirect_from:
  - /theme-setup/
last_modified_at: 2022-11-26
toc: true
---

# Migrating Faveo Helpdesk  <!-- omit in toc -->




# Cloning/Migrating Faveo Helpdesk from one server to another <!-- omit in toc -->



Cloning/migrating Faveo Helpdesk to a new server should be a pretty painless process. You really only have a few things to worry about:

- Your .env
- Your database
- Your faveo file system

The easiest way to handle this is to simply run a system backup through your Faveo Helpdesk admin panel at Admin > Backups which will generate faveo file system and database zip files, but if for some reason that's not working for you, a regular database dump using phpMyAdmin or another MySQL/MariaDB tool should work fine too for database and manually archiving the faveo files with tools like zip or tar will work too.

<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/GUI-images/backup1.png?raw=true"/>
<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/GUI-images/backup2.png?raw=true"/>
<img alt="" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/GUI-images/backup3.png?raw=true"/>

- Install all Faveo prerequisites on your target server
- Import your data into your target server's database. Refer the .env file for Database name, Database user and password. It is advised you have the same credentials on the target server database too or you can update the new values in the .env on the target server once it is copied.
- Copy the Faveo files zip backup to the target server and extract it. Make sure to change the right ownership after extracting.
- If you're using a new named hostname (like faveo-dev.mycompany.com, make sure you update the "APP_URL" in the ".env" and update the  DNS to be able to resolve the new hostname.
- Finally, run the below command inside faveo directory to avoid attachments link issue.

```sh
php artisan storage:link
```
- You should be all set.
---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/websockets/
redirect_from:
  - /theme-setup/
last_modified_at: 2024-02-28
last_modified_by: Mohammad_Asif
toc: true
title: Enabling Websockets in Faveo Helpdesk
---
## Introduction:

Websockets provide a bidirectional communication protocol for real-time data exchange over a persistent connection. Pusher simplifies websocket integration, enabling seamless real-time communication between clients and the server for responsive, interactive applications.

WebSockets enable real-time updates in web apps, making UIs more responsive. Instead of polling for changes, data is sent over a WebSocket when updated on the server.

## Server Level Changes:
Add the below contents to the supervisor conf file.

#### For Debian Based Systems:

Open the file with nano editor.

```
nano /etc/supervisor/conf.d/faveo-worker.conf
```

Add the below configurations at the end of the file.

```
[program:faveo-websockets]
process_name=%(program_name)s
command=php /var/www/faveo/artisan websockets:serve
autostart=true
autorestart=true
user=root
redirect_stderr=true
stdout_logfile=/var/www/faveo/storage/logs/websocket-worker.log
```

Restart Supervisor

```
systemctl restart supervisor
```

Check the service status.

```
supervisorctl
```

#### For RedHat Based Systems:

Open the file with nano editor.


```
nano /etc/supervisord.d/faveo-worker.ini
```

Add the below configurations at the end of the file.

```
[program:faveo-websockets]
process_name=%(program_name)s
command=php /var/www/faveo/artisan websockets:serve
autostart=true
autorestart=true
user=root
redirect_stderr=true
stdout_logfile=/var/www/faveo/storage/logs/websocket-worker.log
```

Restart Supervisor

```
systemctl restart supervisord
```

Check the service status.

```
supervisorctl
```

> **Note** that the user will be *root* only in both the cases.

## Faveo GUI Changes:

Login to the Faveo HelpDesk and go to **Admin Panel > Drivers > Websockets**.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/GUI-images/websockets.png" alt="" style=" width:400px ; height:auto">

Select Pusher Settings icon ⚙️ and enter the following details:

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/GUI-images/websockets1.png" alt="" style=" width:400px ; height:auto">

**Details:**

1. **Host:**  Add your helpdesk domain name here (FQDN).
2. **SSL Certificate Path:**  Add your main SSL certificate path here.
3. **SSL Private Key:**  Add the Private Key for the helpdesk domain.
4. **SSL Passphrase:** Add SSL Password if the SSL is password protected, if not leave this field blank.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/GUI-images/websockets2.png" alt="" style=" width:400px ; height:auto">

Save the above details. The Websockets is configured on the Helpdek at this stage.

<img alt="Ubuntu" src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/openlitespeed-images/openlitespeed_logo_grey_bold.png?raw=true" width="200px" />

## Introduction

This document will list steps on how to install Redis, Supervisor and Worker for faveo.

We will install following dependencies in order to make Redis work:

- Redis
- LSPHP extension for Redis
- supervisor

Switch to root user or run the following commands as sudoers.

```
sudo su
```

### Install Redis and PHP redis extension

```
sudo apt install redis lsphp81-redis
```
### Start, Enable and restart the Redis-service

```
systemctl start redis-server
systemctl enable redis-server
```
### Install and Configure Supervisor

```
apt-get install supervisor
```
### Copy paste the below configuration.( Change the directories according to your configuration)

```
nano /etc/supervisor/conf.d/faveo-worker.conf
```

## Openlitespeed Web Server

```cpp
[program:faveo-Horizon]
process_name=%(program_name)s
command=php /usr/local/lsws/Example/html/faveo/artisan horizon
autostart=true
autorestart=true
user=www-data
redirect_stderr=true
stdout_logfile=/usr/local/lsws/Example/html/faveo/storage/logs/horizon-worker.log
```

## litespeed Web Server 

```cpp
[program:faveo-Horizon]
process_name=%(program_name)s
command=php /usr/local/lsws/DEFAULT/html/faveo/artisan horizon
autostart=true
autorestart=true
user=www-data
redirect_stderr=true
stdout_logfile=/usr/local/lsws/DEFAULT/html/faveo/storage/logs/horizon-worker.log
```


### Restart the Supervisor to reread the new configuration.Permalink
```
systemctl restart supervisor 
```
To check the Status of workers use the below command

```
supervisorctl
```

### Enable Redis in FaveoPermalink
After Redis installation is complete, follow these [instructions](https://docs.faveohelpdesk.com/docs/helper/enable-redis) to configure Redis with Faveo.
# Install and configure Redis, Supervisor and Worker for Faveo on Cent OS 7 <!-- omit in toc -->

<img alt="Cent OS Logo" src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Centos-logo-light.svg/300px-Centos-logo-light.svg.png" width="200"  />

## Introduction

This document will list steps on how to install Redis for faveo.

We will install following dependencies in order to make Redis work:

- Redis
- PHP extension for Redis
- supervisor

## Install Redis

```sh
sudo yum install redis -y
```

## Install PHP extension

```sh
yum install redis -y
yum install -y php-pecl-redis.x86_64
```

## Start Redis

```sh
systemctl start redis.service
```

If you’d like Redis to start on boot, you can enable it with the enable command:

```sh
systemctl enable redis
```

You can check Redis’s status by running the following:

```sh
systemctl status redis.service
```

Once you’ve confirmed that Redis is indeed running, test the setup with this command:

```sh
redis-cli ping
```
This should print PONG as the response. If this is the case, it means you now have Redis running on your server and we can begin configuring it to enhance its security.

## Install and Configure Supervisor

```sh
yum install -y supervisor
```

If you’d like Redis to start on boot, you can enable it with the enable command:

```sh
systemctl enable supervisord
```

## Start Supervisord

```
systemctl start supervisord
```

Copy paste the below content in supervisor configuration.

```sh
nano /etc/supervisord.d/faveo-worker.ini
```

Change the directories according to your faveo configuration.

```sh
[program:faveo-worker]
process_name=%(program_name)s_%(process_num)02d
command=php  /var/www/faveo/artisan queue:work redis --sleep=3 --tries=3
autostart=true
autorestart=true
numprocs=8
redirect_stderr=true
stdout_logfile=/var/www/faveo/storage/logs/worker.log

[program:faveo-Recur]
process_name=%(program_name)s_%(process_num)02d
command=php  /var/www/faveo/artisan queue:work redis --queue=recurring --sleep=3 --tries=3
autostart=true
autorestart=true
numprocs=1
redirect_stderr=true
stdout_logfile=/var/www/faveo/storage/logs/recur-worker.log

[program:faveo-Reports]
process_name=%(program_name)s_%(process_num)02d
command=php  /var/www/faveo/artisan queue:work redis --queue=reports --sleep=3 --tries=3
autostart=true
autorestart=true
numprocs=1
user=apache
redirect_stderr=true
stdout_logfile=/var/www/faveo/storage/logs/reports-worker.log

[program:faveo-Horizon]
process_name=%(program_name)s
command=php /var/www/faveo/artisan horizon
autostart=true
autorestart=true
user=apache
redirect_stderr=true
stdout_logfile=/var/www/faveo/storage/logs/horizon-worker.log
```
## Restart the Supervisor to reread configuration

```sh
systemctl restart supervisord 
sudo supervisorctl reread 
sudo supervisorctl update
```

##  Start the Worker

Replace the worker name according to your configuration

```sh
sudo supervisorctl start faveo-worker:*
```

To check the Status use the below command

systemctl status supervisord

## Enable Redis in Faveo
After Redis installation is complete, follow these instruction to configure Redis with Faveo.[Configuration of Redis with Faveo](https://support.faveohelpdesk.com/show/enable-redis-in-faveo)
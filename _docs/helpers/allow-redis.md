---
layout: single
type: docs
permalink: /docs/helpers/allow-redis/
redirect_from:
  - /theme-setup/
last_modified_at: 2024-09-19
last_modified_by: Mohammad_Asif
toc: true
title: "Allow Redis Connection for Faveo Network Discovery"
---

<img alt="Redis" src="https://upload.wikimedia.org/wikipedia/en/6/6b/Redis_Logo.svg" width="200"  /> 


- [<strong>Introduction :</strong>](#introduction)
    - [<strong>1. Steps to Secure Redis and Allow Access</strong>](#1-steps-to-secure-redis-and-allow-access)
        - [<strong>Linux Server</strong>](#linux-server)
        - [<strong>Windows Server</strong>](#windows-server)
    - [<strong>2. Updating Faveo Helpdesk Configuration</strong>](#2-updating-faveo-helpdesk-configuration)
    - [<strong>3. Updating Faveo Network Discovery Configuration</strong>](#3-updating-faveo-network-discovery-configuration)


---


<a id="introduction" name="introduction"></a>

# <strong>Introduction :</strong>

Faveo Network Discovery uses the Redis Database to transfer data from Faveo Network Discovery to Faveo Helpdesk. To enable this process, the Network Discovery server must be granted access to the Redis database on the Faveo Helpdesk server. This will allow the necessary data to be transferred from the Redis database to Faveo Helpdesk.

Additionally, the Redis database must be secured with a password to ensure safe access while still allowing external access from the Network Discovery server.

<a id="1-steps-to-secure-redis-and-allow-access" name="1-steps-to-secure-redis-and-allow-access"></a>

### <strong>1. Steps to Secure Redis and Allow Access</strong>

---

<a id="linux-server" name="linux-server"></a>

### <strong>Linux Server</strong>

Open `redis.conf` file in any editor of your choice.

We will use `nano` to edit. Type following command in terminal, hit enter.

```
nano /etc/redis/redis.conf
```

**Set Passphrase for Redis**

Search for a line `# requirepass foobared`

Remove `#` and replace `foobared` with your password. 
So now it will look like 
```
requirepass YOUR_PASSWORD
```

**Allow External Connections to Redis**

Search for a `bind 127.0.0.1 ::1` 
Change it to
```
bind 127.0.0.1 ::1 YOUR_NETWORK_DISCOVERY_SERVER_IP
```

Restart redis server by typing following command.
```
sudo systemctl restart redis-server
```


Once Redis is secured and IP is allowed, verify the Redis connection from the Faveo Network Discovery server using the following command:
```
redis-cli -h FAVEO_SERVER_IP -p 6379 -a YOUR_PASSWORD
```

Make sure to replace `FAVEO_SERVER_IP` and `YOUR_PASSWORD` with the actual values for your environment.

If the above does not work, make the redis available to `0.0.0.0` i.e.,
```
bind 0.0.0.0
```

Restart redis server by typing following command.
```
sudo systemctl restart redis-server
```

<a id="windows-server" name="windows-server"></a>

### <strong>Windows Server</strong>

Let’s locate Redis installation folder. Preferably it will be at `C:\Program Files\Redis\`
 unless you have installed it somewhere else.

You’ll find 2 files there named `redis.windows.conf` and `redis.windows-service.conf`

Since we are using redis as a windows service we have to edit `redis.windows-service.conf`.


**Set Passphrase for Redis**

Open up respective file, and search for `#requirepass foobared`

Remove `#` and replace `foobared` with `your desired password`. And save the file.
```
requirepass YOUR_PASSWORD
```


**Allow External Connections to Redis**

Search for a `bind 127.0.0.1 ::1` 
Change it to
```
bind 127.0.0.1 ::1 YOUR_NETWORK_DISCOVERY_SERVER_IP
```

Now open `task manager`, click on `Services` tab.

Look for `Redis` service, Right click on it and click `restart`.



Once Redis is secured and IP is allowed, verify the Redis connection from the Faveo Network Discovery server using the following command:
```
redis-cli -h FAVEO_SERVER_IP -p 6379 -a YOUR_PASSWORD
```

Make sure to replace `FAVEO_SERVER_IP` and `YOUR_PASSWORD` with the actual values for your environment.

If the above does not work, make the redis available to `0.0.0.0` i.e.,
```
bind 0.0.0.0
```

Now open `task manager`, click on `Services` tab.

Look for `Redis` service, Right click on it and click `restart`.


<a id="2-updating-faveo-helpdesk-configuration" name="2-updating-faveo-helpdesk-configuration"></a>

### <strong>2. Updating Faveo Helpdesk Configuration</strong>


Since Redis is now password-protected, you need to update the Faveo Helpdesk `.env` file to enable access to the Redis database.

Open the `.env` file for editing:
```
For Linux:
nano /var/www/faveo/.env

For IIS:
C:\inetpub\wwwroot\.env

For Apache:
C:\Apache24\htdocs\.env
```

Add the following entry in the `.env` file:
```
REDIS_PASSWORD=YOUR_PASSWORD
```


<a id="3-updating-faveo-network-discovery-configuration" name="3-updating-faveo-network-discovery-configuration"></a>

### <strong>3. Updating Faveo Network Discovery Configuration</strong>


You also need to provide the Redis credentials in the Faveo Network Discovery `.env` file. Open the .env file for editing:
```
nano /var/www/faveo/.env
```

Add the following entries to the `.env` file:
```
FAVEO_REDIS_HOST=FAVEO_SERVER_IP
FAVEO_REDIS_PASSWORD=YOUR_PASSWORD
FAVEO_REDIS_PORT=6379
```

Make sure to replace `FAVEO_SERVER_IP` and `YOUR_PASSWORD` with the actual values for your environment.


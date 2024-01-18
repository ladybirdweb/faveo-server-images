---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/meilisearch/
redirect_from:
  - /theme-setup/
last_modified_at: 2024-01-04
last_modified_by: Mohammad_Asif
toc: true
title: Installing Meilisearch Driver for Faveo.
---
<img alt="Windows" src="https://assets-global.website-files.com/64c7a317aea92912392c0420/64e78fa96ece14d6a2632a57_Meilisearch_logo.webp" width="200"  />

- [<strong>Introduction :</strong>](#introduction-) 
    - [<strong>1. For Linux Server</strong>](#1-for-linux-server)
    - [<strong>2. For Windows Server</strong>](#2-for-windows-server)

<a id="introduction-" name="introduction-"></a>

## <strong>Introduction:</strong>

MeiliSearch is an open-source search engine developed in Rust that delivers flexible search and indexing capabilities. It adeptly handles typos, supports full-text search, synonyms, and comes packed with various features, making it an ideal choice for elevating search functionalities in your applications.

---

<a id="1-for-linux-server" name="1-for-linux-server"></a>

### <strong>1. For Linux Server</strong>

### Step 1:  Install Meilisearch
Once you are logged in into your machine via SSH, ensure your system and its dependencies are up-to-date before proceeding with the installation.

Also make sure **curl** is installed on the server.

```
For Debian and Derivatives:
apt update
apt install curl -y
```

```
For RHEL and Derivatives:
yum update -y
yum install curl -y
```

We will use the below script that will carry out the installation process. It will copy a binary of Meilisearch to your machine and enable you to use it immediately.

```
curl -L https://install.meilisearch.com | sh
```

Give the binary execute permission using:
```
chmod +x meilisearch
```

Meilisearch is finally installed and ready to use. To make it accessible from everywhere in your system, move the binary file into your system binaries folder:

```
mv ./meilisearch /usr/local/bin/
```

### Step 2: Create System User
Running applications as root can introduce security flaws in your system. To prevent that from happening, create a dedicated system user for running Meilisearch:

```
useradd -d /var/lib/meilisearch -b /bin/false -m -r meilisearch
```

### Step 3: Create a Configuration File
Download default config to */etc*:

```
curl https://raw.githubusercontent.com/meilisearch/meilisearch/latest/config.toml > /etc/meilisearch.toml
```

Update the following lines so Meilisearch stores its data in the home folder of your newly created user:



```
nano /etc/meilisearch.toml
```

```
env = "production"
master_key = "YOUR_MASTER_KEY_VALUE"
db_path = "/var/lib/meilisearch/data"
dump_dir = "/var/lib/meilisearch/dumps"
snapshot_dir = "/var/lib/meilisearch/snapshots"
```

>**NOTE**:  Remember to choose a safe and random key like *master_key = lc3CEU9zI6G1ZfPZkW2SMwWXQj_hDwhZh-pa3Nh-qRw*

Finally, create the directories you added to the configuration file and set proper privileges:

```
mkdir /var/lib/meilisearch/data /var/lib/meilisearch/dumps /var/lib/meilisearch/snapshots

chown -R meilisearch:meilisearch /var/lib/meilisearch

chmod 750 /var/lib/meilisearch
```
 
### Step 4: Run Meilisearch as a service
We will use a very simple service file that will run Meilisearch on port 7700.

Run this command to create a service file:

```
cat << EOF > /etc/systemd/system/meilisearch.service
[Unit]
Description=Meilisearch
After=systemd-user-sessions.service

[Service]
Type=simple
WorkingDirectory=/var/lib/meilisearch
ExecStart=/usr/local/bin/meilisearch --config-file-path /etc/meilisearch.toml
User=meilisearch
Group=meilisearch

[Install]
WantedBy=multi-user.target
EOF
```


The service file you just built is all you need for creating your service. Now you must enable it to tell the operating system that we want it to run Meilisearch at every boot. You can then start the service to make it run immediately. Ensure everything is working smoothly by checking the service status.

```
systemctl enable meilisearch

systemctl start meilisearch

systemctl status meilisearch
```

At this point, Meilisearch is installed and running on your Linux Server.

<a id="2-for-windows-server" name="2-for-windows-server"></a>

### <strong>2. For Windows Server</strong>

<a href="https://github.com/meilisearch/meilisearch/releases/tag/v1.5.0" target="_blank" rel="noopener">Click Here</a> to download Meilisearch executable for windows.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/GUI-images/meili.png" alt="" style=" width:400px ; height:150px ">

Once the executable is downloaded, move it to <code><b>Faveo Root Directory</b></code> *(C:\inetpub\wwwroot - Incase of Windows with IIS & C:\Apache24\htdocs - Incase of Windows with Apache)*. 

Double-click on the executable, a command prompt window will open, copy the <code><b>master-key</b></code> from the command prompt window and use that in the next step.


<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/GUI-images/meili1.png" alt="" style=" width:400px ; height:150px ">


Open the command prompt in Administrative mode and run the below command with the full path of the executable.


Windows with IIS
```
C:\inetpub\wwwroot\meilisearch-windows-amd64.exe --master-key lc3CEU9zI6G1ZfPZkW2SMwWXQj_hDwhZh-pa3Nh-qRw*
```

Windows with Apache
```
C:\Apache24\htdocs\meilisearch-windows-amd64.exe --master-key lc3CEU9zI6G1ZfPZkW2SMwWXQj_hDwhZh-pa3Nh-qRw*
```


>**NOTE**:  Remember to replace the master-key copied in the above step.


Once the above command is run, it will give results like below, at this point Meilisearch is configured on your Windows server.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/GUI-images/meili2.png" alt="" style=" width:400px ; height:150px ">

You can confirm the same by visiting *http://localhost:7700*

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/GUI-images/meili3.png" alt="" style=" width:400px ; height:150px ">














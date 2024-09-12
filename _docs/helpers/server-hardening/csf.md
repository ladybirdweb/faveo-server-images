---
layout: single
type: docs
permalink: /docs/helper/server-hardening/csf
redirect_from:
  - /theme-setup/
last_modified_at: 2024-09-12
last_modified_by: Mohammad_Asif
toc: true
title: "ConfigServer Security & Firewall (CSF) Installation and Configuration Guide"
---



This guide provides step-by-step instructions for installing and configuring ConfigServer Security & Firewall (CSF) on a server.

<img alt="csf" src="https://community.time4vps.com/uploads/editor/p2/mxdl93nqqtxy.png" width="500"  />

- [<strong>Introduction :</strong>](#introduction-) 
    - [<strong>1. CSF Installation</strong>](#1-csf-installation)
    - [<strong>2. CSF Configuration</strong>](#2-csf-configuration)
    - [<strong>3. CSF Configuration Script</strong>](#3-csf-configuration-script)


<a id="introduction-" name="introduction-"></a>

## <strong>Introduction:</strong>

ConfigServer Security & Firewall (CSF)  is a Stateful Packet Inspection (SPI) firewall, login/intrusion detection, and security application for Linux servers provided by ConfigServer. Login Failure Daemon (LFD) is a daemon process that runs on our servers, which uses CSF for server security.


<a id="1-csf-installation" name="1-csf-installation"></a>

### <strong>1. CSF Installation</strong>

#### On Debian-based Systems
Update package lists and install required dependencies

```
sudo apt-get update
sudo apt-get install -y wget perl libwww-perl liblwp-protocol-https-perl sendmail iptables
```
#### On RHEL-based Systems 

Update package lists and install required dependencies

```
sudo yum update -y
sudo yum install -y wget perl perl-libwww-perl bind-utils sendmail iptables
```

#### Download and install CSF

```
wget https://download.configserver.com/csf.tgz
tar -xzf csf.tgz
cd csf
sudo sh install.sh
```

<a id="2-csf-configuration" name="2-csf-configuration"></a>

### <strong>2. CSF Configuration</strong>

Open the CSF configuration file:

```
sudo nano /etc/csf/csf.conf
```

Modify the following settings in the configuration file:

- Testing Mode: Set TESTING to "0" to enable the firewall.

```
TESTING = "0"
```
- Restrict Syslog: Set RESTRICT_SYSLOG to 3.

```
RESTRICT_SYSLOG = "3"
```

- Allow Incoming Connections: Configure TCP_IN to allow connections on necessary ports.

```
TCP_IN = "20,21,22,25,53,853,80,110,143,443,465,587,993,995,30030,10000,1515,1514,10050"
```

- Allow Outgoing Connections: Configure TCP_OUT to allow connections on necessary ports.

```
TCP_OUT = "20,21,22,25,53,853,80,110,113,443,587,993,995,10000,1515,1514,10050"
```

- IPv6 Settings: Configure TCP6_IN and TCP6_OUT if applicable.

```
TCP6_IN = "20,21,22,25,53,853,80,110,143,443,465,587,993,995,30030"
TCP6_OUT = "20,21,22,25,53,853,80,110,113,443,587,993,995"
```
- Allow Incoming UDP Connections: Configure UDP_IN.

```
UDP_IN = "20,21,53,853,80,443,10000,1515,1514"
```

- Allow Outgoing UDP Connections: Configure UDP_OUT.

```
UDP_OUT = "20,21,53,853,113,123,10000,1515,1514"
```

- IPv6 UDP Settings: Configure UDP6_IN and UDP6_OUT if applicable.

```
UDP6_IN = "20,21,53,853,80,443"
UDP6_OUT = "20,21,53,853,113,123"
```
Save and close the configuration file.

### Allow IP Address

Open the CSF configuration file:

```
sudo nano /etc/csf/csf.allow
```
- Add the IP address you want to allow:

```
# 223.178.83.28
```

### Deny IP Address

Open the CSF deny list file:

```
sudo nano /etc/csf/csf.deny
```

- Add the IP address you want to deny:

```
# 220.178.80.20
```


Restart CSF to apply changes:

```
sudo csf -r
sudo systemctl restart lfd
```

---

<a id="3-csf-configuration-script" name="3-csf-configuration-script"></a>

### <strong>3. CSF Configuration Script</strong>

Use the following script to automate the CSF configuration:

create a new file named csf_configure.sh with the following command:

```
nano csf_configure.sh
```

Add the Script Content
```bash
#!/bin/bash

# Define IP addresses to allow and deny
# Example ("127.0.0.1" "192.168.1.1")
ALLOWED_IPS=() 
DENIED_IPS=()

# Define the values to be set in the CSF configuration
TESTING="0"
RESTRICT_SYSLOG="3"
TCP_IN="20,21,22,25,53,853,80,110,143,443,465,587,993,995,30030,10000,1515,1514,10050"
TCP_OUT="20,21,22,25,53,853,80,110,113,443,587,993,995,10000,1515,1514,10050"
TCP6_IN="20,21,22,25,53,853,80,110,143,443,465,587,993,995,30030"
TCP6_OUT="20,21,22,25,53,853,80,110,113,443,587,993,995"
UDP_IN="20,21,53,853,80,443,10000,1515,1514"
UDP_OUT="20,21,53,853,113,123,10000,1515,1514"
UDP6_IN="20,21,53,853,80,443"
UDP6_OUT="20,21,53,853,113,123"

# Define the CSF configuration file paths
CSF_CONF="/etc/csf/csf.conf"
CSF_ALLOW="/etc/csf/csf.allow"
CSF_DENY="/etc/csf/csf.deny"

# Define the IP tables log file
IPTABLES_LOG="/var/log/iptables.log"

# Backup the original configuration files
echo "Backing up original configuration files..."
sudo cp $CSF_CONF "$CSF_CONF.bak"
sudo cp $CSF_ALLOW "$CSF_ALLOW.bak"
sudo cp $CSF_DENY "$CSF_DENY.bak"

# Log current IP tables configuration
echo "Logging current IP tables configuration..."
sudo iptables -L -n > $IPTABLES_LOG
echo "Current IP tables configuration logged to $IPTABLES_LOG"

# Comment out previous IP addresses
echo "Commenting out previous IP addresses..."
sudo sed -i 's/^\([^#].*\)/# \1/' $CSF_ALLOW
sudo sed -i 's/^\([^#].*\)/# \1/' $CSF_DENY

# Update CSF configuration
echo "Updating CSF configuration..."
update_config() {
    local key=$1
    local value=$2
    if sudo sed -i "s/^${key} =.*/${key} = \"$value\"/" $CSF_CONF; then
        echo "Updated ${key} successfully."
    else
        echo "Failed to update ${key}." >&2
        exit 1
    fi
}

update_config "TESTING" "$TESTING"
update_config "RESTRICT_SYSLOG" "$RESTRICT_SYSLOG"
update_config "TCP_IN" "$TCP_IN"
update_config "TCP_OUT" "$TCP_OUT"
update_config "TCP6_IN" "$TCP6_IN"
update_config "TCP6_OUT" "$TCP6_OUT"
update_config "UDP_IN" "$UDP_IN"
update_config "UDP_OUT" "$UDP_OUT"
update_config "UDP6_IN" "$UDP6_IN"
update_config "UDP6_OUT" "$UDP6_OUT"

# Add allowed IP addresses with timestamp and description
if [ ${#ALLOWED_IPS[@]} -gt 0 ]; then
    echo "Configuring allowed IP addresses..."
    for IP in "${ALLOWED_IPS[@]}"; do
        TIMESTAMP=$(date "+%a %b %d %H:%M:%S %Y")
        echo "$IP # Allowing IP $IP - $TIMESTAMP" | sudo tee -a $CSF_ALLOW > /dev/null
    done
else
    echo "No IP addresses to allow."
fi

# Add denied IP addresses with timestamp and description
if [ ${#DENIED_IPS[@]} -gt 0 ]; then
    echo "Configuring denied IP addresses..."
    for IP in "${DENIED_IPS[@]}"; do
        TIMESTAMP=$(date "+%a %b %d %H:%M:%S %Y")
        echo "$IP # Denying IP $IP - $TIMESTAMP" | sudo tee -a $CSF_DENY > /dev/null
    done
else
    echo "No IP addresses to deny."
fi

# Restart CSF and LFD to apply the changes
echo "Restarting CSF and LFD..."
sudo csf -r
sudo systemctl restart lfd
sudo systemctl restart csf

echo "CSF and LFD configuration completed and applied."
```
Save the file and exit.

Change the file permissions to make the script executable:

```
chmod +x csf_configure.sh
```

Run the script with root privileges to apply the configuration:

```
sudo ./csf_configure.sh
```
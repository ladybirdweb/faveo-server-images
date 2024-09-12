---
layout: single
type: docs
permalink: /docs/helpers/server-hardening/unsecure-ports
redirect_from:
  - /theme-setup/
last_modified_at: 2024-09-12
last_modified_by: Mohammad_Asif
toc: true
title: "Disabling Unsecured Ports on a Linux Server with CSF"
---

<img alt="insecure" src="https://www.svgrepo.com/show/451509/channel-insecure.svg" width="100" height="90" />

This document guides you on how to identify and disable unsecured ports on a Linux server using ConfigServer Security & Firewall (CSF). Closing unnecessary and insecure ports is vital for hardening your server’s security and reducing its vulnerability to attacks.

## What Are Unsecured Ports?
Unsecured ports are network ports that are:

- Open but unused.
- Used by services that are not secured, often involving outdated protocols or unnecessary services.

## Common Unsecured Ports

Below is a list of commonly unsecured ports that should be closed or secured:

**Telnet (Port 23):** Unencrypted remote login. Replace with SSH (Port 22).

**FTP (Port 21):** Unencrypted file transfer. Replace with SFTP or FTPS.

**POP3 (Port 110):** Unencrypted email retrieval. Replace with POP3S (Port 995).

**IMAP (Port 143):** Unencrypted email retrieval. Replace with IMAPS (Port 993).

**SMB (Port 445):** File sharing on Windows networks, vulnerable to certain attacks. Restrict its use.

**HTTP (Port 80):** Unencrypted web traffic. Replace with HTTPS (Port 443).
**RDP (Port 3389):** Often targeted by brute-force attacks. Secure with strong authentication or a VPN.

**SNMP (Port 161):** If unsecured, SNMP can expose sensitive information. Consider using SNMPv3.

**RPC (Port 135):** Used for Microsoft RPC services, vulnerable to certain exploits. Restrict its exposure.

**NFS (Port 2049):** Network file sharing, can expose sensitive files if not properly secured.

## How to Identify Open Ports

Before disabling unsecured ports, you need to identify the open ports on your server.

### Step 1: Scan for Open Ports
You can use tools like `netstat`, `ss`, or `nmap` to identify open ports.

#### Using netstat
```
sudo netstat -tuln
```

#### Using ss
```
sudo ss -tuln
```

#### Using nmap
```
sudo nmap -sT -sU -p- 127.0.0.1
```

## How to Disable Unsecured Ports Using CSF

Once you've identified the open and unsecured ports, you can use CSF to close them.

### Step 2: Configure CSF to Block Unsecured Ports

CSF (ConfigServer Security & Firewall) is a popular firewall management tool that allows you to easily manage iptables firewall rules and secure your server.

#### Step 2.1: Edit CSF Configuration

To block unsecured ports, you need to edit the CSF configuration file.
```
sudo nano /etc/csf/csf.conf
```

#### Step 2.2: Close Specific Ports

Locate the `TCP_IN`, `TCP_OUT`, `UDP_IN`, and `UDP_OUT` directives in the `csf.conf` file. These define which ports are allowed for incoming and outgoing traffic. Remove any ports that are insecure or unnecessary from these lists.

<kbd>Example:</kbd>
To close Telnet (Port 23), FTP (Port 21), and others:
```
# Allow incoming TCP ports (remove insecure ones)
TCP_IN = "22,443,636,992,993,995"  # Remove 21, 23, 110, 143, 3389, etc.

# Allow outgoing TCP ports (remove insecure ones)
TCP_OUT = "22,443,636,992,993,995"  # Remove 21, 23, 110, 143, 3389, etc.

# Allow incoming UDP ports (remove insecure ones)
UDP_IN = "53"

# Allow outgoing UDP ports (remove insecure ones)
UDP_OUT = "53"
```

Adjust the port list according to your server's needs.

#### Step 2.3: Block Specific Ports Individually (Optional)

If you need to block specific ports individually without modifying the default csf.conf configuration, you can add custom rules in /etc/csf/csf.deny.

<kbd>Example:</kbd>
To block Port 23 (Telnet) and Port 21 (FTP) specifically:
```
sudo nano /etc/csf/csf.deny
```

Add
```
tcp|in|d=23|s=0.0.0.0/0
tcp|in|d=21|s=0.0.0.0/0
```

#### Step 3: Restart CSF

After making changes, restart CSF to apply the new rules:
```
sudo csf -r
```

#### Step 4: Verify Closed Ports
After CSF is reloaded, verify that the insecure ports are no longer open.
To confirm the same you can rerun the `netstat`, `ss` or `nmap` commands listed in Step 1.
```
sudo netstat -tuln
```
or
```
sudo ss -tuln
```
or
```
sudo nmap -sT -sU -p- 127.0.0.1
```

Ensure that the unsecured ports are no longer listed.

## Ports to Exclude:
Here are the ports that should not be included in the CSF configuration:

#### TCP_IN/TCP_OUT
23 (Telnet - unsecured)
80 (HTTP - unsecured)
110 (POP3 - unsecured)
143 (IMAP - unsecured)
389 (LDAP - unsecured)
21 (FTP - unsecured)

#### UDP_IN/UDP_OUT
69 (TFTP - unsecured)
161 (SNMP - unsecured)
123 (NTP - can be misused if not secured properly)

## Ports to Include:
Here are the secure ports that should be included in the CSF configuration:

#### TCP_IN/TCP_OUT
22 (SSH)
443 (HTTPS)
636 (LDAPS - LDAP over SSL)
992 (Telnet over SSL)
993 (IMAPS - IMAP over SSL)
995 (POP3S - POP3 over SSL)

#### UDP_IN/UDP_OUT
53 (DNS)

---

# MySQL & Redis Ports:
If MySQL and Redis are running on the same server as Faveo Helpdesk Server, you can safely block the ports externally while keeping the services accessible internally.

## Blocking Ports While Keeping Local Connections

### MySQL and Redis Listening on localhost:

Both MySQL and Redis can be configured to listen on `localhost (127.0.0.1)`, which means they will only accept connections from the local machine. In this setup, the services are not exposed to the outside world, making it safe to block their ports in CSF.

### CSF Configuration:

You do not need to allow MySQL (default port `3306`) and Redis (default port `6379`) in `TCP_IN` or `TCP_OUT` for external connections.

The ports should remain accessible internally because they are bound to localhost and not exposed externally. Therefore, blocking these ports in CSF does not affect local connections.

## Steps to Ensure Security:

### 1.Bind MySQL and Redis to localhost:

#### MySQL:
Edit the MySQL configuration file:
```
sudo nano /etc/mysql/my.cnf
```

Ensure bind-address is set to 127.0.0.1:
```
bind-address = 127.0.0.1
```

#### MariaDB:
Edit the MariaDB configuration file:
```
nano /etc/mysql/mariadb.conf.d/50-server.cnf
```

Ensure bind-address is set to 127.0.0.1:
```
bind-address = 127.0.0.1
```

#### Redis:
Edit the Redis configuration file:
```
sudo nano /etc/redis/redis.conf
```

Ensure bind-address is set to 127.0.0.1:
```
bind 127.0.0.1
```

### 2. CSF Configuration:

Block MySQL and Redis ports in CSF:
```
# Do not include these ports in TCP_IN or TCP_OUT
TCP_IN = "..."
TCP_OUT = "..."
```

Since both services are bound to localhost, the server's firewall (CSF) will block external access to these ports while allowing local connections.


## Conclusion

By identifying and disabling unsecured ports on your server using CSF, you significantly reduce the risk of unauthorized access and potential exploitation


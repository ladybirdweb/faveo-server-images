---
layout: single
type: docs
permalink: /docs/helpers/server-hardening/home
redirect_from:
  - /theme-setup/
last_modified_at: 2024-09-13
last_modified_by: Mohammad_Asif
toc: true
title: "Server Hardening Guidelines for Faveo Helpdesk"
---

<img alt="ssh" src="https://static.thenounproject.com/png/3190015-200.png" width="150" height="100" />

- [<strong>Introduction :</strong>](#introduction-) 
    - [<strong>1. Secure SSH Configuration</strong>](#1-secure-ssh-configuration)
    - [<strong>2. ConfigServer Security & Firewall (CSF)</strong>](#2-configserver-security-&-firewall)
    - [<strong>3. Antivirus and Malware Detection</strong>](#3-antivirus-and-malware-detection)
    - [<strong>4. Web Server Hardening</strong>](#4-webserver-hardening)
    - [<strong>5. Disabling Unsecured Ports</strong>](#5-disabling-unsecured-ports)
    - [<strong>6. OS Patching and Log Rotation</strong>](#6-os-patching-and-log-rotation)
    - [<strong>7. Regular Backups</strong>](#7-regular-backups)




<a id="introduction-" name="introduction-"></a>

## <strong>Introduction:</strong>

At Faveo Helpdesk, we prioritize the security of our infrastructure to ensure the protection of sensitive data and the smooth functioning of our services. Server hardening is a critical process that involves securing the server's configuration, reducing vulnerabilities, and implementing robust controls to prevent unauthorized access and potential exploits.

This document outlines the key steps we follow to harden our servers, ensuring they are resilient against attacks and compliant with industry standards.


<a id="1-secure-ssh-configuration" name="1-secure-ssh-configuration"></a>

### <strong>1. Secure SSH Configuration</strong>

**a. Disable Root Access**

To minimize the risk of brute force attacks or unauthorized access, root login via SSH is disabled. Administrative tasks are performed using non-root user accounts with limited privileges.

**b. Create Non-Root Users**
Instead of root, specific users are created for system management. Access to privileged operations is granted via `sudo` on a need-to-know basis.

**c. Change SSH Port**
We modify the default SSH port to a non-standard port to reduce the likelihood of automated attacks targeting the default port (22).

**d. Enable Two-Factor Authentication (2FA)**
For added protection, we enable Two-Factor Authentication (2FA) to ensure only authorized personnel can gain access to the server, adding an extra security layer.

- [Click Here Secure SSH Documentation](/docs/helpers/server-hardening/secure-ssh)


**f. SSH Access Controls**
Strict SSH access controls are enforced by limiting access to a whitelist of IP addresses and utilizing SSH key authentication for secure remote access.

- [Click Here Access Control Documentation](/docs/helpers/server-hardening/access-control)



<a id="2-configserver-security-&-firewall" name="2-configserver-security-&-firewall"></a>

### <strong>2. ConfigServer Security & Firewall (CSF)</strong>

We deploy ConfigServer Security & Firewall (CSF) for monitoring and controlling incoming and outgoing traffic. CSF is configured through the command line to block malicious traffic and provide robust protection against intrusions.

- [Click Here CSF Installation & Configuration](/docs/helper/server-hardening/csf)


<a id="3-antivirus-and-malware-detection" name="3-antivirus-and-malware-detection"></a>

### <strong>3. Antivirus and Malware Detection</strong>

We employ ClamAV for virus and malware detection, running regular scans to detect, isolate, and remove harmful files. This proactive approach ensures that the system remains free from threats.

- [Click Here Antivirus Installation Documentation](/docs/helpers/server-hardening/clamav)


<a id="4-webserver-hardening" name="4-webserver-hardening"></a>

### <strong>4. Web Server Hardening</strong>

**a. Security Headers**
We configure critical security headers (Content-Security-Policy, X-Frame-Options, etc.) to protect against common vulnerabilities like cross-site scripting (XSS) and clickjacking for both NGINX and Apache.

- [Click Here for Apache Hardening Documentation](/docs/helpers/server-hardening/apache-hardening)

- [Click Here for Nginx Hardening Documentation](/docs/helpers/server-hardening/nginx-hardening)

**b. ModSecurity with OWASP Rules**
ModSecurity is implemented alongside the OWASP Core Rule Set (CRS) to provide an extra layer of protection against web application attacks like SQL injection and cross-site scripting.

- [Click Here for ModSecurity Documentation](/docs/helpers/server-hardening/mod-security)

<a id="5-disabling-unsecured-ports" name="5-disabling-unsecured-ports"></a>

### <strong>5. Disabling Unsecured Ports</strong>

We ensure that only necessary and secured ports are active on our servers. All unused or unsecured ports are disabled to prevent unauthorized access.

- [Click Here for disabling Unsecured Ports Documentation](/docs/helpers/server-hardening/unsecure-ports)


<a id="6-os-patching-and-log-rotation" name="6-os-patching-and-log-rotation"></a>

### <strong>6. OS Patching and Log Rotation</strong>

**Regular OS Patching:** We maintain up-to-date system software and patches to close known security loopholes.
**Log Rotation:** Log files, including those in `/tmp`, are regularly rotated to ensure system stability and prevent malicious users from exploiting log data.

- [Click Here for Log Rotation Documentation](/docs/helpers/server-hardening/log-rotation)


<a id="7-regular-backups" name="7-regular-backups"></a>

### <strong>7. Regular Backups</strong>

A robust backup system is in place to regularly store and archive data. Backups are secured and periodically tested for recovery to ensure we can quickly restore data in the event of a breach or system failure.

- [Click Here for Backup Documentation](/docs/helpers/choose-backup)

## Conclusion

Server hardening is an ongoing process, and at Faveo Helpdesk, we continuously monitor, audit, and update our systems to defend against evolving threats. By following these best practices, we aim to maintain the integrity, availability, and security of our servers, keeping our infrastructure safe from attacks and ensuring uninterrupted service.
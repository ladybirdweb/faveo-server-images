---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/windows-iis-ssl/
redirect_from:
  - /theme-setup/
last_modified_at: 2020-06-09
toc: true
---

# Install Let’s Encrypt SSL for Faveo on Windows Server Running IIS Web Server <!-- omit in toc -->


<img alt="Ubuntu" src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/Windows_logo_%E2%80%93_2012_%28dark_blue%29.svg/65px-Windows_logo_%E2%80%93_2012_%28dark_blue%29.svg.png" width="65"  />

## Introduction
This document will lists down how to install Let’s Encrypt SSL on Windows Server Running IIS Web Server

**PS:** Please replace faveohelpdesk.tk with your valid domain name which is mapped with your server


## Download the Let’s Encrypt client

Download Lets encrypt file from GitHub Link [https://github.com/win-acme/win-acme/releases](https://github.com/win-acme/win-acme/releases)

Download the file called ``` win-acme.v2.1.8.847.x64.pluggable.zip ```

<img alt="" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1592304791Screenshot%20from%202020-06-16%2016-21-04.png"  />

## Setting up the SSL certificate

Extract the zip file under particular directory and RUN the Wacs.exe application.

**Step 1:** Type N to generate new certificate.
<img alt="" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1592304939ssl2.png"  />

**Step 2:** Select Option 1 that means install SSL for Default Web Site
<img alt="" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1592305043ssl3.png"  />

**Step 3:** Select Option 1 this option will ask for which site you want to Install SSL.
<img alt="" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1592305174ssl4.png"  />

**Step 4:** Press y to continue with the selection.
<img alt="" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1592305273ssl5.png"  />

## Setting up auto renewal of the certificate

Lets encrypt installer will create the task scheduler entry
<img alt="" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1592305421ssl6.png"  />

Once SSL Installation is complete. You can see IIS (Internet Information Services) manager Site Bindings created.
<img alt="" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1592305700ssl7.png"  />

---
layout: single
type: docs
permalink: /docs/installation/providers/enterprise/windows-iis-ssl/
redirect_from:
  - /theme-setup/
last_modified_at: 2022-10-25
toc: true
title: Install Let’s Encrypt SSL for Faveo on Windows Server Running IIS Web Server
---

<img alt="Windows" src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Windows_logo_and_wordmark_-_2021.svg/250px-Windows_logo_and_wordmark_-_2021.svg.png" width="200"  />


## Introduction
This document will lists down how to install Let’s Encrypt SSL on Windows Server Running IIS Web Server

**PS:** Please replace faveohelpdesk.tk with your valid domain name which is mapped with your server


## Download the Let’s Encrypt client

<a href="https://www.win-acme.com/" target="_blank" rel="noopener">Click Here</a> to download win-acme.v2.1.23.1315.x64.pluggable.zip.

<img alt="" src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/windows-images/winacme.png"  />

## Setting up the SSL certificate

Extract the zip file under particular directory and RUN the wacs.exe application as Administrator.

<img alt="" src="https://support.faveohelpdesk.com/ckeditor_attachements/2020/06/1592304791Screenshot%20from%202020-06-16%2016-21-04.png"  />

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

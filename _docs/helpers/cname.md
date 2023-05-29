---
layout: single
type: docs
permalink: /docs/helper/cname/
redirect_from:
  - /theme-setup/
last_modified_at: 2023-05-29
toc: true
---

# Creating Custom Domains for Faveo Cloud <!-- omit in toc -->

This document will guide you on how to create a custom domain for your Faveo Cloud instance.

## Custom Domain Creation:

### Prerequisites:

1. To create a custom domain, you need to have a domain registered with any vendor like GoDaddy, Namecheap, Freenom, etc.

2. You also need to have access to the DNS management of the domain. You can obtain this information from the vendor from whom you purchased the domain.

### To create a custom domain, follow the steps below to create a CNAME record:

1. Log in to the domain registrar portal that has access to the DNS management. Below is an example of how it looks. Here, we are showing an example with Freenom domain registrar.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/helpers/images/loginpage.png?raw=true" alt="" />

2. Once logged in, the dashboard may vary with different vendors. Please search for the list of services and find the domain list, as shown below.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/helpers/images/selectingservice.png?raw=true" alt="" />

3. After selecting the services, you will see the domains and services purchased from the vendor. Here, you can see three domains. Select the domain on which you want to create the custom domain.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/helpers/images/managedomain.png?raw=true" alt="" />

4. Click on the manage domain and go to the domain page. You will find an option called "DNS Management." Click on it.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/helpers/images/dnsmanagement.png?raw=true" alt="" />

5. This will take you to a page where you can add DNS records, as shown below.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/helpers/images/recordadding.png?raw=true" alt="" />

6. This is the final step for creating a custom domain. Enter the custom name you want for your domain (e.g., "***test.faveocloud.com***"). "***test***" represents the custom domain. Then, select the type from the dropdown menu as "***CNAME***" record. For some vendors, there may be an option to create the record type with a click button. After selecting the record type, enter the value for the record. The value should be "faveocloud.com," as shown in the snapshot below.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/helpers/images/recordadding.png?raw=true" alt=""  />

7. Once the record is added, you will receive a success message on your dashboard, as shown below.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/helpers/images/addedsuccess.png?raw=true" alt=""  />

8. The propagation of the custom domain may take 2 to 4 hours, depending on your vendor's DNS speed. You can check the status of propagation using any DNS checker in your browser, such as [dnschecker](https://dnschecker.org/).

9. Once the domain is propagated, you are good to go.

***Custom domain created successfully.***
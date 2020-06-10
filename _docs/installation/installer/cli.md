---
layout: single
type: docs
permalink: /docs/installation/installer/cli/
redirect_from:
  - /theme-setup/
last_modified_at: 2020-06-09
toc: true
title: "Faveo Web CLI Installer"
---

Faveo comes with a CLI installer to help and guide you through the installation process. While the installer provides step by step guide during the installation, it's important and helpful to have general knowledge about Web servers, PHP and MySQL.

Before getting started make sure your server meets following [minimum requirement](/docs/system-requirement/requirement/) required to install and use Faveo

<a id="getting-started" name="getting-started"></a>
## Getting Started

Download the latest version of Faveo from [https://billing.faveohelpdesk.com](https://billing.faveohelpdesk.com) and upload the .zip files in the folder on your server.

Faveo Community version can also be downloaded directly from [Github](https://github.com/ladybirdweb/faveo-helpdesk)

For example /faveo/, /helpdesk/ or /support/ depending on your preference. Basic knowledge of using FTP is an added advantage at this stage. If you don't know how to use FTP, we would recommend you read the documentation supplied with your FTP client and learn the basics of uploading and setting permissions on files. 

You can get the installer by simply browsing the Faveo URL (Faveo Hosted URL). Faveo installation script will attempt to auto-detect paths and any permission issues. By following the given instructions, you can complete the installation and basic setup in a web browser. If the installation spots any configuration errors then it will not allow you to continue until the errors are corrected.

<a id="step1" name="step1"></a>
### Step 1: Server Requirements

The installer will perform the system requirement test and if it spots any errors then it will not allow you to continue until all the requirements are met. When all your server checklists are configured correctly it displays as “Enabled” and you click on the Continue button to move on with the installation process.

<img src="https://lh3.googleusercontent.com/u5KQhlSUOiZWoU3AV5xZeAM37cGdhLduILJFXfSw8fmy7S48cyLXauHn1sPILa7pszCZF6h8amfHfspM0pJSzZRY7dbwwedhXXT-ZLBV9YVb50FM9zzw5WabEeTPXqLORtGHclWM" alt="" />
    
<a id="step2" name="step2"></a>
### Step 2: License Agreement

Accept the License and Agreement and click on Continue to proceed with the installation.

<img src="https://lh3.googleusercontent.com/Ng18bWPkeQLLcHnAeksmrkyHFAEmyWfybH6ssp_0bDMVdGFk3L-pIJK8Cq4qK8BhDnTfVwRdjIWtcfcBmfcLAhQ0psylv4aeoD8U_MD13M_K5Nh8Tja5xJFXVWYM7O4-3Q3oTPxM" alt="" />

<a id="step3" name="step3"></a>    
### Step 3: Database Setup

Establish the database connection by providing the database details.

Fill the Database Name, Database username, and password in the specified boxes. Click on the Continue button. If the given database details are valid it will show the “Database connection successful” message. If any error message is received refill the details and retry the connection of the database.

<img src="https://lh4.googleusercontent.com/CcUguP6ydKHKMnS0puVlvbih9IXn84A7PHMwj9x6xesEq2eSIA9YCGPI97QLmBWUkse-2oH2GCYGkOtp1DA7CJIqv4AWm-m8j-oen77C7loG3GQBzF8w9Wus_sNZFpFvUHO3Rjuv" alt="" />


<img src="https://lh6.googleusercontent.com/iBXIOj5dsxcnXQj7dwXBSOdHjlFFYGVsKjbBDAWm8eKalKVk8pPjv7VuXGiejtu54F3-I107_BLioeXDT8Qkx_tz1Mqu-HN2XyygldARQutFoHljwxDNlNdZ38pLrxsD2KYNbmXr" alt="" />

<a id="step4" name="step4"></a>
### Step 4: Locale Information

Provide the system locale information as system login details and system language, system time and click on Continue.
<img src="https://lh5.googleusercontent.com/s80NnEB2vEezRJ0lBBApn7TA21UvJbvvYuwyx48lZZOpPGiRh-VDL-QcBGo6k85XnjC_qaQOdn79A1Mczep7N2934mt5MVj_DPGv4kh-c6lRtc95Qy0_z1YqdMrj_6UPyTRYTau2" alt="" />
    
<a id="step5" name="step5"></a>
### Step 5: License Key

Product License Key: Provide the license key received for the purchased product and click on the Continue button. Refer the link [how to get the product license key?](/docs/helpers/license-key)

<img src="https://lh3.googleusercontent.com/RDCZNHxE_VOwCmbhYM_3SFdt4gGkMNTVdZAFzXZYp0FWRtPkaTgIJnDG333OnLagBSPHMS6RzgH_ALIaBOLWB9HBY1oaUD0DB2kpH2Q65PE57ny5EVY9gsc-BqfJVNI-O3h0zMHU" alt="" />
    
Congratulations! Faveo is installed and operational!

<a id="step6" name="step6"></a>
### Step 6: Start using Faveo

Go to the browser and hit the Faveo URL to login and start using faveo
<img src="https://lh3.googleusercontent.com/4OXyz8qOcKKrxCOz7vEhnmQz7udSeJMlXNfwnVZ12zdlYKPHr_oozdhn6AGtwazdcmqfx-BdxE6Jj4ZHS3iLY4XtRmbH7RxjdB8l2vJZ4uWaIRwIdQNZILD2TcIzkn5hUzp6J7F2" alt="" />

**Note:** Installer performs basic configuration, required to get Faveo up and running. Further configuration is required post-install, to make the system fully functional like
- Email configuration
- Setting Cron Job URL

Faveo can be also installed via a [CLI](/docs/installation/installer/cli) installer. 

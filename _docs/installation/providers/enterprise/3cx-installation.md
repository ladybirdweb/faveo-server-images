## Install Debian for 3CX

To install Debian for 3CX:

1. [Download the latest 3CX ISO.](https://downloads-global.3cx.com/downloads/debian10iso/debian-amd64-netinst-3cx.iso)

2. If you are using a hypervisor/virtualized OS, set the CD option to boot from the ISO and ensure the CD drive is set to connect on startup. If you are installing on a mini PC, then create a bootable image, plug it into one of the available Mini PC’s USB ports and set the BIOS to boot from the USB drive to start the installation.

3. Boot your system with the downloaded 3CX ISO, select “**Install**” from the main boot screen and press the "**Enter**" key.

<img src="https://github.com/tamilselvan-lws/Documents/blob/main/INSTALLATION%20GUIDE/Images/3cx-images/3cx-install1.png?raw=true" style=" width:500px ; height:250px ">

4. Enter a hostname for the computer so you can easily identify it on your network, using the characters 'a' to 'z', numbers '0' to '9' and the '-' character.

```
Hostname: ladybird
```
<img src="https://github.com/tamilselvan-lws/Documents/blob/main/INSTALLATION%20GUIDE/Images/3cx-images/3cx-install2.png?raw=true" style=" width:500px ; height:250px ">

5. Enter a domain name - use the same domain you used on other computers in the network, Select “**Continue> to proceed.

```
Domain name: 3cx.in
```

<img src="https://github.com/tamilselvan-lws/Documents/blob/main/INSTALLATION%20GUIDE/Images/3cx-images/3cx-install3.png?raw=true" style=" width:500px ; height:250px ">

8. Select the default system language and press the “**Enter**” key.

<img src="https://github.com/tamilselvan-lws/Documents/blob/main/INSTALLATION%20GUIDE/Images/3cx-images/3cx-install4.png?raw=true" style=" width:500px ; height:250px ">

9. Select your geographical location from the location menu and press the “**Enter**” key to proceed.

<img src="https://github.com/tamilselvan-lws/Documents/blob/main/INSTALLATION%20GUIDE/Images/3cx-images/3cx-install5.png?raw=true" style=" width:500px ; height:250px ">

10. Specify the root account password for the machine and select “**Continue**” to re-enter the password for verification purposes. Finally, select “**Continue> to proceed. Note: Set a strong password for the root user, as this account has no restrictions!

11. Select the system timezone and press the “**Enter**” key to proceed.

12. Partition your disk, selecting “Guided - use the entire disk”. Press the “**Enter> key to proceed.

<img src="https://github.com/tamilselvan-lws/Documents/blob/main/INSTALLATION%20GUIDE/Images/3cx-images/3cx-install7.png?raw=true" style=" width:500px ; height:250px ">

13. Confirm your disk selection by pressing the “**Enter**” key. If you are installing on a bare metal machine, all data on your disk will be erased!

<img src="https://github.com/tamilselvan-lws/Documents/blob/main/INSTALLATION%20GUIDE/Images/3cx-images/3cx-install8.png?raw=true" style=" width:500px ; height:250px ">

14. Select the “All files in one partition” partitioning scheme and press the “**Enter**” key to proceed.

<img src="https://github.com/tamilselvan-lws/Documents/blob/main/INSTALLATION%20GUIDE/Images/3cx-images/3cx-install9.png?raw=true" style=" width:500px ; height:250px ">

15. Select “Finish partitioning and write changes to disk” and press the “**Enter**” key to proceed to the 3CX Debian installation.

<img src="https://github.com/tamilselvan-lws/Documents/blob/main/INSTALLATION%20GUIDE/Images/3cx-images/3cx-install10.png?raw=true" style=" width:500px ; height:250px ">

16. Select ‘Yes’ and press the “**Enter**” key to confirm writing changes to the disk. The install process can take about 5-20 minutes, depending on your machine’s performance. When the Debian installer finishes, the machine is rebooted and the 3CX installation starts automatically.

<img src="https://github.com/tamilselvan-lws/Documents/blob/main/INSTALLATION%20GUIDE/Images/3cx-images/3cx-install11.png?raw=true" style=" width:500px ; height:250px ">

17. Now choose the “3CX Version xx” to install and then press “**OK**”. Agree to the “3CX License Agreement” to proceed.

<img src="https://github.com/tamilselvan-lws/Documents/blob/main/INSTALLATION%20GUIDE/Images/3cx-images/3cx-install13.png?raw=true" style=" width:500px ; height:250px ">

## Step 5: Upload the Configuration File

<img src="https://github.com/tamilselvan-lws/Documents/blob/main/INSTALLATION%20GUIDE/Images/3cx-images/3cx-install14.png?raw=true" style=" width:500px ; height:250px ">

After the 3CX Debian installation finishes and the machine is rebooted, you need to upload the configuration file to complete the installation.

1. If you do not have a configuration file yet, go to [www.3cx.com/install/](www.3cx.com/install/)

2. Login with your 3CX account and configure an On Premise / DIY PBX. At the end of the process, you will be given a link to the configuration file. You can copy the link or download the file. For more information see Installing 3CX

3. Use a web browser on **http://"ip of machine":5015** by selecting option **1**.

4. Once your installation is ready, you will be prompted to set your password. Login to the PBX using the email you used to register.

<img src="https://github.com/tamilselvan-lws/Documents/blob/main/INSTALLATION%20GUIDE/Images/3cx-images/3cx-install15.png?raw=true" style=" width:500px ; height:250px ">
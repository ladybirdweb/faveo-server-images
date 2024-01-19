## Step 1: Install Debian for 3CX

To install Debian for 3CX:

1. [Download the latest 3CX ISO.](https://downloads-global.3cx.com/downloads/debian10iso/debian-amd64-netinst-3cx.iso)

2. If you are using a hypervisor/virtualized OS, set the CD option to boot from the ISO and ensure the CD drive is set to connect on startup. If you are installing on a mini PC, then create a bootable image, plug it into one of the available Mini PC’s USB ports and set the BIOS to boot from the USB drive to start the installation.

3. Boot your system with the downloaded 3CX ISO, select <code><b>Install</b></code> from the main boot screen and press the <code><b>Enter</b></code> key.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/3cx-images/3cx-install1.png?raw=true" style=" width:500px ; height:250px ">

4. Enter a hostname for the computer so you can easily identify it on your network, using the characters 'a' to 'z', numbers '0' to '9' and the '-' character.

```
Hostname: ladybird
```
<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/3cx-images/3cx-install2.png?raw=true" style=" width:500px ; height:250px ">

5. Enter a domain name - use the same domain you used on other computers in the network, Select <code><b>Continue</b></code> to proceed.

```
Domain name: 3cx.in
```

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/3cx-images/3cx-install3.png?raw=true" style=" width:500px ; height:250px ">

6. Select the default system language and press the <code><b>Enter</b></code> key.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/3cx-images/3cx-install4.png?raw=true" style=" width:500px ; height:250px ">

7. Select your geographical location from the location menu and press the <code><b>Enter</b></code> key to proceed.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/3cx-images/3cx-install5.png?raw=true" style=" width:500px ; height:250px ">

8. Specify the root account password for the machine and select <code><b>Continue</b></code> to re-enter the password for verification purposes. Finally, select <code><b>Continue</b></code> to proceed. Note: Set a strong password for the root user, as this account has no restrictions!

9. Select the system timezone and press the <code><b>Enter</b></code> key to proceed.

10. Partition your disk, selecting “Guided - use the entire disk”. Press the <code><b>Enter</b></code> key to proceed.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/3cx-images/3cx-install7.png?raw=true" style=" width:500px ; height:250px ">

11. Confirm your disk selection by pressing the <code><b>Enter</b></code> key. If you are installing on a bare metal machine, all data on your disk will be erased!

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/3cx-images/3cx-install8.png?raw=true" style=" width:500px ; height:250px ">

12. Select the “All files in one partition” partitioning scheme and press the <code><b>Enter</b></code> key to proceed.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/3cx-images/3cx-install9.png?raw=true" style=" width:500px ; height:250px ">

13. Select “Finish partitioning and write changes to disk” and press the <code><b>Enter</b></code> key to proceed to the 3CX Debian installation.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/3cx-images/3cx-install10.png?raw=true" style=" width:500px ; height:250px ">

14. Select ‘Yes’ and press the <code><b>Enter</b></code> key to confirm writing changes to the disk. The install process can take about 5-20 minutes, depending on your machine’s performance. When the Debian installer finishes, the machine is rebooted and the 3CX installation starts automatically.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/3cx-images/3cx-install11.png?raw=true" style=" width:500px ; height:250px ">

15. Now choose the “3CX Version xx” to install and then press <code><b>OK</b></code>. Agree to the “3CX License Agreement” to proceed.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/3cx-images/3cx-install13.png?raw=true" style=" width:500px ; height:250px ">



## Step 2: Upload the Configuration File

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/3cx-images/3cx-install14.png?raw=true" style=" width:500px ; height:250px ">

After the 3CX Debian installation finishes and the machine is rebooted, you need to upload the configuration file to complete the installation.

1. If you do not have a configuration file yet, go to [www.3cx.com/install/](www.3cx.com/install/)

2. Login with your 3CX account and configure an On Premise / DIY PBX. At the end of the process, you will be given a link to the configuration file. You can copy the link or download the file. For more information see Installing 3CX

3. Use a web browser on <code><b>http://"ip of machine":5015</b></code> by selecting option **1**.

4. Once your installation is ready, you will be prompted to set your password. Login to the PBX using the email you used to register.

<img src="https://github.com/ladybirdweb/faveo-server-images/blob/master/_docs/installation/providers/enterprise/3cx-images/3cx-install15.png?raw=true" style=" width:500px ; height:250px ">

## Step 3: Network Configuration for 3CX

1. The primary network configuration file on Debian is located at <code><b>/etc/network/interfaces</b></code>.

```
sudo nano /etc/network/interfaces
```

2. Add the configuration for the new network interface.

- Primary Network Interface (enp11s0)
- Airtel SIP Network Interface (enp6s0)

```
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto enp11s0
iface enp11s0 inet static
    address 192.168.2.82
    netmark 255.255.255.255
    gateway 192.168.2.1

auto enp6s0
iface enp6s0 inet static
    address 10.231.58.94
    netmask 255.255.255.252
    gateway 10.231.58.93
```

3. Airtel SIP Network Configuration

- Configuration of IP routes for the Airtel SIP network interface. The following routes have been established to direct traffic via the specified gateway (10.231.58.93):

```
sudo ip route add 10.5.70.3 via 10.231.58.93
sudo ip route add 10.5.70.19 via 10.231.58.93
sudo ip route add 10.5.110.130 via 10.231.58.93
sudo ip route add 10.5.110.131 via 10.231.58.93
sudo ip route add 10.5.110.146 via 10.231.58.93
sudo ip route add 10.5.110.147 via 10.231.58.93
sudo ip route add 10.5.110.194 via 10.231.58.93
sudo ip route add 10.5.110.195 via 10.231.58.93
sudo ip route add 10.5.110.210 via 10.231.58.93
sudo ip route add 10.5.110.211 via 10.231.58.93
```

4. After making changes to this file, restart the networking service to apply the new configurations.

```
sudo systemctl restart networking
```
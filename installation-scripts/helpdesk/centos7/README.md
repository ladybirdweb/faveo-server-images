# Faveo Helpdesk Freelancer, Enterprise auto install script

Automatic-installation script is available for <b>FRESH CentOS 7</b> installs at
https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk/centos7/autoinstall.sh

# Run the script

To run, copy/paste this into the command-line
    
```sh
yum -y install wget
wget https://support.faveohelpdesk.com/uploads/install-scripts/helpdesk/centos7/autoinstall.sh
```

Change execution permission for file.

```sh
chmod +x Faveo-Centos-apache.sh
```

Execute the script

```sh
./Faveo-Centos-apache.sh
```

Follow the final installation steps [here](https://support.faveohelpdesk.com/show/web-gui-installer)

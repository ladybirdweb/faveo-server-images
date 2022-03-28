#!/bin/bash


































#Colour variables for the script.
red=`tput setaf 1`

green=`tput setaf 2`

yellow=`tput setaf 11`

skyblue=`tput setaf 14`

white=`tput setaf 15`

reset=`tput sgr0`

echo -e "$skyblue                                                                                                                    $reset"
sleep 0.05
echo -e "$skyblue                                   _______ _______ _     _ _______ _______                                          $reset"
sleep 0.05
echo -e "$skyblue                                  (_______|_______|_)   (_|_______|_______)                                         $reset"
sleep 0.05
echo -e "$skyblue                                   _____   _______ _     _ _____   _     _                                          $reset"
sleep 0.05
echo -e "$skyblue                                  |  ___) |  ___  | |   | |  ___) | |   | |                                         $reset"
sleep 0.05
echo -e "$skyblue                                  | |     | |   | |\ \ / /| |_____| |___| |                                         $reset"
sleep 0.05
echo -e "$skyblue                                  |_|     |_|   |_| \___/ |_______)\_____/                                          $reset"
sleep 0.05
echo -e "$skyblue                                                                                                                    $reset"
sleep 0.05
echo -e "$skyblue                          _     _ _______ _       ______ ______  _______  ______ _     _                            $reset"
sleep 0.05
echo -e "$skyblue                        (_)   (_|_______|_)     (_____ (______)(_______)/ _____|_)   | |                            $reset"
sleep 0.05
echo -e "$skyblue                         _______ _____   _       _____) )     _ _____  ( (____  _____| |                            $reset"
sleep 0.05
echo -e "$skyblue                        |  ___  |  ___) | |     |  ____/ |   | |  ___)  \____ \|  _   _)                            $reset"
sleep 0.05
echo -e "$skyblue                        | |   | | |_____| |_____| |    | |__/ /| |_____ _____) ) |  \ \                             $reset"
sleep 0.05
echo -e "$skyblue                        |_|   |_|_______)_______)_|    |_____/ |_______|______/|_|   \_)                            $reset"
sleep 0.05
echo -e "$skyblue                                                                                                                    $reset"
sleep 0.05
echo -e "$skyblue                                                                                                                    $reset"
                                                                                        
                                                                                        
                                                                                        
echo -e "$yellow         This is a automated Installation Script for Faveo Helpdesk products which runs on Linux Distro's $reset"
echo -e "                                                                                                          "
echo -e "                                                                                                          "

# Detect Debian users running the script with "sh" instead of bash.

if readlink /proc/$$/exe | grep -q "dash"; then
	echo '&red This installer needs to be run with "bash", not "sh". $reset'
	exit 1
fi

# Checking for the Super User.

if [[ $EUID -ne 0 ]]; then
   echo -e "$red This script must be run as root $reset"
   exit 1
fi

# Detect OS
# $os_version are needed to install the dependency packages.
# Below the OS will be detected and the Version check will be done for the Faveo Requirement.

if grep -qs "ubuntu" /etc/os-release; then
	os="ubuntu"
	os_version=$(grep 'VERSION_ID' /etc/os-release | cut -d '"' -f 2 | tr -d '.')
    Os_Version=$(hostnamectl | grep 'Operating System')
	group_name="nogroup"
    sleep 1
    echo -e "                                 "
    echo -e "[OS Detected] : $green $Os_Version $reset"
    sleep 1
    echo -e "                                 "
    echo -e "Supported OS Version [CHECK :$green OK $reset]"

elif [[ -e /etc/debian_version ]]; then
	os="debian"
	os_version=$(grep -oE '[0-9]+' /etc/debian_version | head -1)
	group_name="nogroup"
    Os_Version=$(hostnamectl | grep 'Operating System')
	group_name="nogroup"
    sleep 1
    echo -e "                                 "
    echo -e "[OS Detected] : $green $Os_Version $reset"
    sleep 1
    echo -e "                                 "
    echo -e "Supported OS Version [CHECK :$green OK $reset]"

elif [[  -e /etc/rocky-release || -e /etc/centos-release ]]; then
	os="centos"
	os_version=$(grep -shoE '[0-9]+'  /etc/rocky-release /etc/centos-release | head -1)
	group_name="nobody"
    Os_Version=$(hostnamectl | grep 'Operating System')
	group_name="nogroup"
    sleep 1
    echo -e "                                 "
    echo -e "[OS Detected] : $green $Os_Version $reset"
    sleep 1
    echo -e "                                 "
    echo -e "Supported OS Version [CHECK :$green OK $reset]"
elif [[  -e /etc/rocky-release ]]; then
	os="rocky"
	os_version=$(grep -shoE '[0-9]+'  /etc/rocky-release | head -1)
	group_name="nobody"
    Os_Version=$(hostnamectl | grep 'Operating System')
	group_name="nogroup"
    sleep 1
    echo -e "                                 "
    echo -e "[OS Detected] : $green $Os_Version $reset"
    sleep 1
    echo -e "                                 "
    echo -e "Supported OS Version [CHECK :$green OK $reset]"
# If the required OS and version is not detected the below response will be passed to the user.
else
	echo "$red This installer seems to be running on an unsupported distribution.
Supported distros are Ubuntu, Debian, Rocky Linux, CentOS and Fedora.$reset"
	exit
fi

if [[ "$os" == "ubuntu" && "$os_version" -lt 1604 ]]; then
    echo "$os_version"
	echo "$red Ubuntu 16.04 or higher is required to use this installer.
This version of Ubuntu is too old and unsupported.$reset"
	exit
fi

if [[ "$os" == "debian" && "$os_version" -lt 9 ]]; then
    echo "$os_version"
	echo "$red Debian 9 or higher is required to use this installer.
This version of Debian is too old and unsupported.$reset"
	exit
fi

if [[ "$os" == "centos" && "$os_version" -lt 7 ]]; then
    echo "$os_version"
	echo "$red CentOS 7 or higher is required to use this installer.
This version of CentOS is too old and unsupported.$reset"
	exit
fi

# Prerequisties for the Faveo installation like the Domain, email, License and order numbers are taken below:
echo -e "                               "
echo -e "$skyblue Please provide the Below details which is required for the Faveo installaion $reset"

Get_Faveo_Prerequisties ()
{
echo -e "                                 "
echo "$yellow Domain Name$reset";
echo -e "                                 "
read DomainName
echo -e "                                 "
echo "$yellow Email $reset";
echo -e "                                 "
read Email
echo "$yellow You can find the License and Order No from https://billing.faveohelpdesk.com $reset"
echo -e "                                   "
echo "$yellow License Code $reset";
echo -e "                                 "
read LicenseCode
echo -e "                                 "
echo "$yellow Order Number $reset";
echo -e "                                 "
read OrderNumber
echo -e "                                 "
echo -e "\n";
echo -e "Confirm the Entered Helpdesk details:\n";
echo -e "-------------------------------------\n"
echo -e "                                 "
echo "Domain Name :$yellow $DomainName $reset";
echo -e "                                 "
echo "Email:$yellow $Email $reset";
echo -e "                                 "
echo "License Code:$yellow $LicenseCode $reset";
echo -e "                                 "
echo "Order Number:$yellow $OrderNumber $reset";
}
#Executing function to fetch the above detais.

Get_Faveo_Prerequisties

#Checking the Details with functions below.

echo -e "\n";
read -p "Continue ($green y $reset/$red n $reset)?" REPLY
if [[ ! $REPLY =~ ^(yes|y|Yes|YES|Y) ]]; then
    echo -e "                           "
    read -p "Do you wish to Re-enter Continue ($green y $reset/$red n $reset)?" REPLY2
    if [[ ! $REPLY2 =~ ^(yes|y|Yes|YES|Y) ]]; then
        exit 1;
    else
        Get_Faveo_Prerequisties
    fi;
    read -p "Is the above details are correct ($green y $reset/$red n $reset)?" REPLY3
    if [[ ! $REPLY3 =~ ^(yes|y|Yes|YES|Y) ]]; then
        echo "Please restart the script"
        exit 1;
    else
        echo -e "        "
        echo "$skyblue Proceeding the Installation $reset"
        echo -e "          "
    fi
else 
    echo -e "           "
    echo "Proceeding Further"
fi;

#DNS Propagation checking with DIG command.

echo -e "               "
echo -e "$yellow Checking whether the domain is propagated to the server's public IP. $reset"
echo -e "                                       "

#Installing Prerequisties for faveo;

#####    apt update && apt install dnsutils git wget curl unzip nano zip -y || yum update -y && yum install unzip wget nano yum-utils curl openssl zip git bind-utils -y

#Checking the server public IP:

PublicIP=$(curl -s ifconfig.me) 

#checking the domian propagated IP:

echo -e "               "
DomainIP=$(dig $DomainName +short)
echo -e "               "

# Condition for comparing the IP's:

if [[ $PublicIP != $DomainIP ]]; then
    echo -e "$yellow Please make sure the Domain is propagated to the server pubic IP and try again, The server IP is $red $PublicIP $reset and The domain is propagated to $red $DomainIP $reset $reset";
    echo -e "               "
    exit 1
else
    echo -e "$yellow The Domain is Propagated to the Server Public IP CHECK :$green OK $reset $reset"
    echo -e "               "
    echo "$skyblue Proceeding the Installation $reset"
    echo -e "               "
fi

# Checking for required ports whether it is open or not.

echo -e "$yellow Checking for the Port 80 and 443 Http and Https Faveo requires those Ports for the Installation $reset" 
echo -e "       "

nc -z $DomainName 80

if [[ $? != 0 ]]; then
    echo "$red The Port 80 is Not open. Please open the required Ports and restart the script $reset";
    echo -e "               "
    exit 1
else
    echo "$yellow The Port 80 Open CHECK :$green OK $reset $reset"
    echo -e "               "
    echo "$skyblue Proceeding the Installation $reset"
    echo -e "               "
fi

nc -z $DomainName 443

if [[ $? != 0 ]]; then
    echo "$red The Port 443 is Not open. Please open the required Ports and restart the script $reset";
    echo -e "               "
    exit 1
else
    echo "$yellow The Port 443 Open CHECK :$green OK $reset $reset"
    echo -e "               "
    echo "$skyblue Proceeding the Installation $reset"
    echo -e "               "
fi




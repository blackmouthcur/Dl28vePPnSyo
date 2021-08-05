#!/bin/bash
#Run this from shell as root: curl https://raw.githubusercontent.com/blackmouthcur/Dl28vePPnSyo/main/Sw7C32.sh | bash
echo "------------------------------------------------"
echo "			CENTOS 8 Plex and Samba Set Up"
echo "------------------------------------------------"
echo "Changing SELINUX default to disabled"
cp /etc/selinux/conf /etc/selinux/conf.bak
echo "Made /etc/selinux/conf.bak"
find /etc/selinux/conf -type f -name 'conf' -exec sed -i 's/enabled/disabled/g' {} \;
echo "Done"
echo " "
echo "Checking for CENTOS updates / upgrades"
dnf update
dnf upgrade
echo " " 
sleep 3
clear
echo "Downloading and Installing Samba and Samba Client"
sudo yum install samba samba-client -y
echo "Done"
echo " "
sleep 3
echo "Making directories:"
echo "/media/storage/plexmedia"
echo "/media/storage/general"
mkdir /media/storage
mkdir /media/storage/plexmedia
mkdir /media/storage/general
chmod 777 /media/storage/plexmedia
chmod 777 /media/storage/general
echo "Done"
echo " "
echo "Pulling smb.conf file from git repo"
cd /etc/samba
wget https://raw.githubusercontent.com/blackmouthcur/Dl28vePPnSyo/main/smb.conf
echo "Samba Installed and two shares created."
echo " "
echo " Moving to PLEX Install"
sleep 3
clear
echo "Getting plex repo from git repo"
cd /etc/yum.repos.d/
wget https://raw.githubusercontent.com/blackmouthcur/Dl28vePPnSyo/main/plex_media.repo
dnf install plexmediaserver -y
echo " Moving to Firewall"
sleep 3
clear
echo "Setting Firewall Rules for PLEX and SAMBA"
firewall-cmd --permanent --zone=public --add-service=samba
firewall-cmd --zone=public --add-service=samba
firewall-cmd --add-service=plex --zone=public --permanent
firewall-cmd --reload
echo " Firewall Reloaded and Done"
echo " "
echo " Enabling Services"
sleep 3
clear
systemctl enable plexmediaserver
systemctl start plexmediaserver
sudo systemctl start smb.service
sudo systemctl start nmb.service
sudo systemctl enable smb.service
sudo systemctl enable nmb.service
sleep 3
clear
echo "Plex is at: http://server-ip:32400/web hit it up"
echo "Samba: \\serverip or dns name\ (File Explorer) "
echo " "
echo "------------------------------------------------"
echo "               SCRIPT COMPLETE"
echo "------------------------------------------------"


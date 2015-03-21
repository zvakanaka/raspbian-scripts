#!/bin/bash
#BASH SETUP GMAIL via SSMTP by adam quinton
if [ $USER = "root" ]
then
#Sets up gmail using ssmptp
SSMTP_CONFIG="/etc/ssmtp/ssmtp.conf"

#check if ssmtp already installed
dpkg -s ssmtp > /dev/null
if [ $? -eq 1 ]
then
   echo -e ssmtp not installed, installing...
   sudo apt-get install ssmtp
   if [ $? -eq 1 ]; then
       echo -e Failed to install ssmtp, exiting...
       exit 1
   fi
fi
userAccount=""
read -p "Gmail username(w/o @gmail.com): " userAccount
password=""
echo -n "Gmail password: "
read -s password
echo
echo -e 'root='${userAccount%%@gmail.com*}'@gmail.com\nmailhub=smtp.gmail.com:465\nrewriteDomain=gmail.com\nAuthUser='${userAccount%%@gmail.com*}'\nAuthPass='$password'\nFromLineOverride=YES\nUseTLS=YES' > $SSMTP_CONFIG
#Make password file more secure(only specified user and root may read it)
systemUserInstall=""
read -p "User on system this account can be run under: " systemUserInstall
echo ${userAccount%%@gmail.com*} > /home/$systemUserInstall/.ipSender
chown $systemUserInstall:$systemUserInstall $SSMTP_CONFIG
chmod 600 $SSMTP_CONFIG

#Sending test email
echo SENDING TEST EMAIL...
echo -e 'To: '${userAccount%%@gmail.com*}'@gmail.com\nFrom: '${userAccount%%@gmail.com*}'@gmail.com\nSubject: Bash Gmail Test\nYou have set up bash gmail!\nThis message was sent by '$USER' from '$HOSTNAME'.\nEmail is now set up for the user '$systemUserInstall'.' > testEmail.txt
ssmtp ${userAccount%%@gmail.com*}'@gmail.com' < testEmail.txt
rm testEmail.txt
else
   echo -e '\e[1;31mERROR: USER must be root, try "sudo su" and run script again\e[0m'
fi

#!/bin/sh
# whatip.sh
# By Adam Quinton
# Email the IP address of the current machine
# Ssmtp must be previously configured

CONFIG_DIR=$HOME/.whatip
#contains the TO and FROM emails
CONFIG_FILE=$CONFIG_DIR/config

# Source variables in config file, or One time setup
if [ -f $CONFIG_FILE ]; then
    chmod +x $CONFIG_FILE
    . $CONFIG_FILE
else
    if [ ! -d $CONFIG_DIR ]; then
        mkdir $CONFIG_DIR
    fi
    echo -e \#!/bin/bash > $CONFIG_FILE
    read -p "To Email (e.g. linus@gmail.com): " toEmail
    echo export toEmail=$toEmail >> $CONFIG_FILE
    read -p "From Email (e.g. woz@gmail.com): " fromEmail
    echo export fromEmail=$fromEmail >> $CONFIG_FILE
fi

# grab ip address
IPADDRESSES=$(ifconfig | grep 'inet addr')
IPTEMPPREFIX=${IPADDRESSES##*inet addr:}
CURRIP=${IPTEMPPREFIX%%Bcast:*}

echo 'Sending IP: '$CURRIP' FROM: '$fromEmail' TO: '$toEmail''

echo -e 'To: '$toEmail'\nFrom: '$fromEmail'\nSubject: Ip Address of '$HOSTNAME'\n\nYour ip is '$CURRIP'\nThis message was sent by '$USER' from '$HOSTNAME'\nMessage sent '$(date)'.' > tmpIpEmail.txt
ssmtp $toEmail < tmpIpEmail.txt

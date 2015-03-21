#!/bin/bash
# Mails IP address
#INSTRUCTIONS: run setupGmail first

# test if to account file exists
# then set toAccount to file contents
if [ -z $1 ]; then
    if [ -f ~/.ipReceiver ]; then
        toAccount=$(<~/.ipReceiver)
    else
        toAccount=""
        read -p "Send IP email to: " toAccount
        echo $toAccount > ~/.ipReceiver
    fi
else
    toAccount=$1
fi
# test if from account file exists
# then set fromAccount to file contents
if [ -f ~/.ipSender ]; then
    fromAccount=$(<~/.ipSender)
else
   fromAccount=""
   read -p "Send email from: " fromAccount
   echo ${fromAccount%%@gmail.com*} > ~/.ipSender
fi

# grab ip address
IPADDRESSES=$(ifconfig | grep 'inet addr')
IPTEMPPREFIX=${IPADDRESSES#*inet addr:}
CURRIP=${IPTEMPPREFIX%%Bcast:*}

echo -e 'Sending IP: '$CURRIP' FROM: '$fromAccount' TO: '$toAccount''

# sending
echo -e 'To: '$toAccount'\nFrom: '$fromAccount'@gmail.com\nSubject: Ip Address of '$USER'\nYour ip is '$CURRIP'\nThis message was sent by '$USER' from '$HOSTNAME'\nMessage sent '$(date)'.' > tmpIpEmail.txt
ssmtp $toAccount < tmpIpEmail.txt

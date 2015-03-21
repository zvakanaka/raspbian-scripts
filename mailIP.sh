#! /bin/sh
# /etc/init.d/mailIP
### BEGIN INIT INFO
# Provides:          mailIP
# Required-Start:    $all
# Required-Stop:     
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Email your IP address at startup
### END INIT INFO

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin

. /lib/init/vars.sh
. /lib/lsb/init-functions
# If you need to source some other scripts, do it here

case "$1" in
  start)
    log_begin_msg "Starting mailIP service"
# doing something
# Mails IP address
# INSTRUCTIONS: run setupGmail first

# test if to account file exists
# then set toAccount to file contents
 if [ -f ~/.ipReceiver ]; then
        toAccount=$(<~/.ipReceiver)
    else
       echo 'ERROR: No ".ipReceiver" file found.'
       exit 1    
fi
# test if from account file exists
# then set fromAccount to file contents
if [ -f ~/.ipSender ]; then
    fromAccount=$(<~/.ipSender)
else
       echo 'ERROR: No ".ipSender" file found.'
       exit 1    
fi
# grab ip address
IPADDRESSES=$(ifconfig | grep 'inet addr')
IPTEMPPREFIX=${IPADDRESSES#*inet addr:}
CURRIP=${IPTEMPPREFIX%%Bcast:*}
echo -e 'Sending IP: '$CURRIP' FROM: '$fromAccount' TO: '$toAccount''
# sending
echo -e 'To: '$toAccount'\nFrom: '$fromAccount'@gmail.com\nSubject: Ip Address of '$USER'\nYour ip is '$CURRIP'\nThis message was sent by '$USER' from '$HOSTNAME'\nMessage sent '$(date)'.' > tmpIpEmail.txt
ssmtp $toAccount < tmpIpEmail.txt

    log_end_msg $?
    exit 0
    ;;
  stop)
    log_begin_msg "Stopping mailIP service"

    # do something to kill the service or cleanup or nothing

    log_end_msg $?
    exit 0
    ;;
  *)
    echo "Usage: /etc/init.d/mailIP {start|stop}"
    exit 1
    ;;
esac

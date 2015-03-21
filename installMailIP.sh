#!/bin/bash
# installMailIP.sh
# This is all you need to run to set up ipMailer

mkdir ~/mailIP
cd ~/mailIP
if [ ! -f mailIP.sh ]; then
   echo "mailIP file not found! Downloading from github.."
   wget https://raw.githubusercontent.com/zvakanaka/raspbian-scripts/master/mailIP.sh
fi

echo "Creating Service..."
sudo mv -v mailIP.sh /etc/init.d/mailIP

sudo chmod u+x /etc/init.d/mailIP
sudo update-rc.d mailIP defaults

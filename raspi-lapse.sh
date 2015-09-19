#!/bin/bash                                                                     
# raspi-lapse                                                                     
# Author: Adam Quinton           
# Idea from: fotosyn.com:
#     https://bitbucket.org/fotosyn/fotosynlabs/raw/9819edca892700e459b828517bba82b0984c82e4/RaspiLapseCam/raspiLapseCam.py
MIN_DISPLAY="-p 1600,100,100,80 -op 200"
NO_DISPLAY="-n"
ADJUST="-sh 40 -awb auto -mm average -v"

grep "start_x=1" /boot/config.txt > /dev/null 2>&1 || (sed -i "s/start_x=0/start_x=1/g" /boot/config.txt && echo Camera setup now installed, you must reboot && exit 1)

TIMELAPSE_DIR=$HOME/timelapse
# If no TIMELAPSE_DIR, create one
[ -d ${TIMELAPSE_DIR} ] || mkdir -p ${TIMELAPSE_DIR}

FREQ="$1"
if [ ! "$FREQ" ]; then
    # Frequency in miliseconds: 1000 is 1 Second                                                          
    FREQ=5000
fi

# Date Format: Sep-19-2015-12PM                                                      
DATE=$(date +%b-%d-%Y-%I%p)

raspistill -o ${TIMELAPSE_DIR}/${DATE}-pic%04d.jpg -t 21600000 -tl $FREQ $ADJUST $NO_DISPLAY

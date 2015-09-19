#!/bin/bash                                                                     
# raspi-lapse                                                                     
# Author: Adam Quinton                                                          

grep "start_x=1" /boot/config.txt > /dev/null 2>&1 || (sed -i "s/start_x=0/start_x=1/g" /boot/config.txt && echo Camera setup now installed, you must reboot && exit 1)

TIMELAPSE_DIR=$HOME/timelapse
# If no TIMELAPSE_DIR, create one
[ -d ${TIMELAPSE_DIR} ] || mkdir -p ${TIMELAPSE_DIR}

FREQ="$1"
if [ ! "$FREQ" ]; then
    # Frequency in miliseconds: 1000 is 1 Second                                                          
    FREQ=5000
fi

# Date Format: 12:11:38PM-Sep-19-2015                                                        
raspistill -o ${TIMELAPSE_DIR}/$(date +%I:%M:%S%p-%b-%d-%Y).jpg -t 21600000 -tl $FREQ -p 1600,100,100,80 -op 200

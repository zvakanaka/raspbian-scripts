#!/bin/bash                                                                     
# raspi-lapse                                                                     
# Author: Adam Quinton                                                          

TIMELAPSE_DIR=$HOME/timelapse

FREQ="$1"
if [ ! "$FREQ" ]; then
    # Frequency in miliseconds                                                  
    # 1000 is 1 Second                                                          
    FREQ=5000
fi

# Date Format:                                                                  
# 12:11:38PM-Sep-19-2015                                                        
raspistill -o ${TIMELAPSE_DIR}/$(date +%I:%M:%S%p-%b-%d-%Y).jpg -tl $FREQ

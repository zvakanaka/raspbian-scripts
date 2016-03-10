#!/bin/bash -v
# pi-gphoto2.sh
# Author: Adam Quinton
# 1-19-2016
# Download and install gphoto
GPHOTO2=gphoto2-2.5.3.tar.bz2
LIBGPHOTO2=libgphoto2-2.5.3.1.tar.bz2
mkdir gphoto2
cd gphoto2
if [ ! -f $LIBGPHOTO2 ] ; then
   wget http://downloads.sourceforge.net/project/gphoto/libgphoto/2.5.3.1/libgphoto2-2.5.3.1.tar.bz2
fi

if [ -f $LIBGPHOTO2 ] ; then
   if [ ! -f $GPHOTO2 ] ; then
      wget http://downloads.sourceforge.net/project/gphoto/gphoto/2.5.3/gphoto2-2.5.3.tar.bz2
   fi
   tar xvjf $LIBGPHOTO2
   cd libgphoto2*/
   sudo apt-get install libltdl-dev libusb-dev libusb-1.0-0-dev -y
   ./configure --prefix=/usr --disable-nls
   sudo make install
   cd ..
   if [ -f $GPHOTO2 ] ; then
      tar xvjf $GPHOTO2
      cd gphoto2*/
      sudo apt-get install autotools-dev automake libpopt-dev -y
      ./configure --prefix=/usr --disable-nls
      sudo make install
   fi
fi

gphoto2 --version

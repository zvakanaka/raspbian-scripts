#!/bin/bash -v
# pi-gphoto2.sh
# Author: Adam Quinton
# 1-19-2016
# Download and install gphoto

mkdir gphoto2
cd gphoto2
if [ ! -f gphoto2-2.5.3.tar.bz2 ] ; then
   wget http://downloads.sourceforge.net/project/gphoto/gphoto/2.5.3/gphoto2-2.5.3.tar.bz2
fi
if [ ! -f libgphoto2-2.5.3.1.tar.bz2 ] ; then
   wget http://downloads.sourceforge.net/project/gphoto/libgphoto/2.5.3.1/libgphoto2-2.5.3.1.tar.bz2
fi

tar xvjf gphoto2-2.5.3.tar.bz2
tar xvjf libgphoto2-2.5.3.1.tar.bz2

cd libgphoto2-2.5.3.1/
sudo apt-get install libltdl-dev libusb-dev libusb-1.0-0-dev -y
./configure --prefix=/usr --disable-nls
sudo make install

cd ..

cd gphoto2-2.5.3/
sudo apt-get install autotools-dev automake libpopt-dev -y
./configure --prefix=/usr --disable-nls
sudo make install

gphoto2 --version

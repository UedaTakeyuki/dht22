#############################################
#
# dht22 lbrary preparation
#
#   required time: about 10 minutes on RPi 3B+

# update
# https://www.raspberrypi.org/forums/viewtopic.php?p=1497364
sudo apt update

# git
sudo apt-get install git-core

#
# build tools
#
sudo apt-get install autoconf automake libtool

#
# WireingPi
#
# refer http://wiringpi.com/download-and-install/
#
#git clone git://git.drogon.net/wiringPi
#cd wiringPi
#./build
#cd ..

#sudo apt-get install wiringpi

mkdir -p ./wiringPi
cd wiringPi
wget https://project-downloads.drogon.net/wiringpi-latest.deb
sudo dpkg -i wiringpi-latest.deb
cd ..

#
# lol_dht22: Setup to use dht22 on Raspbian
#
git clone https://github.com/technion/lol_dht22
cd lol_dht22
./configure
autoreconf -f -i
make
cd ..

# python module dependency
sudo apt-get install python3-pip
sudo pip3 install subprocess32 requests sensorhandler pytoml pondslider error_counter --break-system-packages
if [ ${cat /etc/debian_version} -lt 11 ] ; then
  sudo apt-get install python-pip
  sudo pip2 install subprocess32 requests sensorhandler pytoml pondslider error_counter
fi

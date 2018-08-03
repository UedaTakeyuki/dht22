#############################################
#
# dht22 lbrary preparation
#
#   required time: about 10 minutes on RPi 3B+

# git
sudo apt-get install git-core

#
# build tools
#
sudo apt-get install autoconf automake libtool

#
# WireingPi
#
git clone git://git.drogon.net/wiringPi
cd wiringPi
./build
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
sudo apt-get install python-pip
sudo pip install subprocess32 requests

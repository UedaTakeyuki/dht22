# dht22
Read Temperature and Rerative Humidity from dht22 (another name AM2302) sensor, culiculate Humidity Deficit value, and send these (Temperature, Rerative Humidity, Humidity Deficit) to [MONITOR](https://monitor.uedasoft.com) server to watch these by Time Series Chart.

## DHT22/AM2302 sensor

DHT22 (another name AM2302) sensor module is inexpensive Temperature & Humidity sensor module. DataSheet is available [here](https://www.sparkfun.com/datasheets/Sensors/Temperature/DHT22.pdf).

The original sensor module has thin ***4 pin*** for implement on the board. So you need some electronic works to use it. You can buy the original module by <a target="_self" href="http://rover.ebay.com/rover/1/711-53200-19255-0/1?icep_ff3=2&pub=5575391936&toolid=10001&campid=5338390482&customid=&icep_item=181922128912&ipn=psmain&icep_vectorid=229466&kwid=902099&mtid=824&kw=lg">eBay</a><img style="text-decoration:none;border:0;padding:0;margin:0;" src="http://rover.ebay.com/roverimp/1/711-53200-19255-0/1?ff3=2&pub=5575391936&toolid=10001&campid=5338390482&customid=&item=181922128912&mpt=[CACHEBUSTER]"> about 3$.

![dht22 breakout](https://4.bp.blogspot.com/-TniTXhOq8Zw/W7LDE7PpiSI/AAAAAAAABZc/D7el9KKklQkqnr0s8TmnpZqqcp7sTU1fwCEwYBhgL/s1600/2018-10-02%2B09.45.28.jpg)

In case you woudn't like soldering, my recommendation is using pre-implemented breakout board which you can buy it by <a target="_self" href="http://rover.ebay.com/rover/1/711-53200-19255-0/1?icep_ff3=2&pub=5575391936&toolid=10001&campid=5338390482&customid=&icep_item=191964438524&ipn=psmain&icep_vectorid=229466&kwid=902099&mtid=824&kw=lg">eBay</a><img style="text-decoration:none;border:0;padding:0;margin:0;" src="http://rover.ebay.com/roverimp/1/711-53200-19255-0/1?ff3=2&pub=5575391936&toolid=10001&campid=5338390482&customid=&item=191964438524&mpt=[CACHEBUSTER]"> almost same price as original module.

## install
download from [release](https://github.com/UedaTakeyuki/dht22/releases)

or 

```
git clone https://github.com/UedaTakeyuki/dht22.git
```

## setup
Setup environment & install depending modules by:

```
cd dht22
./setup.sh 
```

## cabling
Connect RPi & DHT22 as:

- 3.3V on RPi and "+" on DHT22
- GND(0v) on RPi and "-" on DHT22
- wPi 29 on RPi and "out" on DHT22 

Followings are example of cabling, but you can free to use other 5v and 0v Pin on the RPi. 

```
                   +-----+-----+---------+------+---+---Pi B+--+---+------+---------+-----+-----+
                   | BCM | wPi |   Name  | Mode | V | Physical | V | Mode | Name    | wPi | BCM |
                   +-----+-----+---------+------+---+----++----+---+------+---------+-----+-----+
                   |     |     |    3.3v |      |   |  1 || 2  |   |      | 5v      |     |     |
                   |   2 |   8 |   SDA.1 |   IN | 1 |  3 || 4  |   |      | 5v      |     |     |
                   |   3 |   9 |   SCL.1 |   IN | 1 |  5 || 6  |   |      | 0v      |     |     |
                   |   4 |   7 | GPIO. 7 |   IN | 1 |  7 || 8  | 1 | ALT0 | TxD     | 15  | 14  |
                   |     |     |      0v |      |   |  9 || 10 | 1 | ALT0 | RxD     | 16  | 15  |
                   |  17 |   0 | GPIO. 0 |   IN | 0 | 11 || 12 | 0 | IN   | GPIO. 1 | 1   | 18  |
                   |  27 |   2 | GPIO. 2 |   IN | 0 | 13 || 14 |   |      | 0v      |     |     |
                   |  22 |   3 | GPIO. 3 |   IN | 0 | 15 || 16 | 0 | IN   | GPIO. 4 | 4   | 23  |
 "+" of DHT22 ---> |     |     |    3.3v |      |   | 17 || 18 | 0 | IN   | GPIO. 5 | 5   | 24  |
                   |  10 |  12 |    MOSI |   IN | 0 | 19 || 20 |   |      | 0v      |     |     |
                   |   9 |  13 |    MISO |   IN | 0 | 21 || 22 | 0 | IN   | GPIO. 6 | 6   | 25  |
                   |  11 |  14 |    SCLK |   IN | 0 | 23 || 24 | 1 | IN   | CE0     | 10  | 8   |
                   |     |     |      0v |      |   | 25 || 26 | 1 | IN   | CE1     | 11  | 7   |
                   |   0 |  30 |   SDA.0 |   IN | 1 | 27 || 28 | 1 | IN   | SCL.0   | 31  | 1   |
                   |   5 |  21 | GPIO.21 |   IN | 1 | 29 || 30 |   |      | 0v      |     |     |
                   |   6 |  22 | GPIO.22 |   IN | 1 | 31 || 32 | 0 | IN   | GPIO.26 | 26  | 12  |
                   |  13 |  23 | GPIO.23 |   IN | 0 | 33 || 34 |   |      | 0v      |     |     |
                   |  19 |  24 | GPIO.24 |   IN | 0 | 35 || 36 | 0 | IN   | GPIO.27 | 27  | 16  |
                   |  26 |  25 | GPIO.25 |   IN | 0 | 37 || 38 | 0 | IN   | GPIO.28 | 28  | 20  |
 "-" of DHT22 ---> |     |     |      0v |      |   | 39 || 40 | 0 | IN   | GPIO.29 | 29  | 21  | <--- "out" of DHT22
                   +-----+-----+---------+------+---+----++----+---+------+---------+-----+-----+
                   | BCM | wPi |   Name  | Mode | V | Physical | V | Mode | Name    | wPi | BCM |
                   +-----+-----+---------+------+---+---Pi B+--+---+------+---------+-----+-----+
```

![dht22](https://1.bp.blogspot.com/-SufWREq2L5k/W7LP6lOBUqI/AAAAAAAABaM/dLdloQ2Pm7UaXN772V1q0KzBtcuFj87cwCLcBGAs/s1600/2018-10-02%2B10.53.13.jpg)

![RPi](https://4.bp.blogspot.com/-iXRnFPfCA2s/W7LCfHJkjgI/AAAAAAAABZI/LbuQs3p3Y0Mhc_Wac0x8z4vv6wneHboWACEwYBhgL/s1600/2018-10-02%2B09.42.42.jpg)

## test for getting Sensor value

```
python3 dht22.py
```

In case succeeded, espected response is as follows:

```
pi@raspberrypi:~/dht22 $ python3 -m dht22
{'humiditydeficit': '12.3', 'temp': 25.2, 'humidity': 47.1}
```

## send to server

The dht22.py can be work as the handler of [UedaTakeyuki/sensorhandler](https://github.com/UedaTakeyuki/sensorhandler). So, by sensorhandler, you can read the sensor values and send these to the following servers:

- [MONITOR™](https://monitor.uedasoft.com/)  Detail steps for settings is available [here](send_monitor.md). 
- [AT&T M2X](https://m2x.att.com/) Detail steps for settings is available [here](send_m2x.md). 


## setting for automatically read sensor values and send these to server at 5 minute interval

You can do it both by setting crontab if you're used to do so, or you can use autostart.sh command as follow:


```
# set autostart on
./autostart.sh --on

# set autostart off
./autostart.sh --off
```

Tecknically speaking, autostart.sh doesn't use crontab, instead, prepare service for interval running of ***sensorhandler*** named dht22.service .
You can confirm current status of dht22.service with following command:

```
sudo systemctl status dht22.service
```

In case dht22.service is running, you can see the log of current status and taking & sending photo as follows:
```
pi@raspberrypi:~/dht22 $ sudo systemctl status dht22.service 
● dht22.service - Get temp, humid, and humiditydeficit data & Post to the monito
   Loaded: loaded (/home/pi/dht22/dht22.service; enabled; vendor preset: enabled
   Active: active (running) since Mon 2018-10-01 13:47:46 JST; 4h 32min ago
 Main PID: 802 (loop.sh)
   CGroup: /system.slice/dht22.service
           ├─ 802 /bin/bash /home/pi/dht22/loop.sh
           └─4389 sleep 5m

Oct 01 18:19:35 raspberrypi loop.sh[802]: {'humiditydeficit': '12.3', 'temp': 25
Oct 01 18:19:35 raspberrypi loop.sh[802]: temp
Oct 01 18:19:35 raspberrypi loop.sh[802]: send
Oct 01 18:19:35 raspberrypi loop.sh[802]: {"ok":true}
Oct 01 18:19:35 raspberrypi loop.sh[802]: humidity
Oct 01 18:19:35 raspberrypi loop.sh[802]: send
Oct 01 18:19:35 raspberrypi loop.sh[802]: {"ok":false,"reason":"ViewID not valid
Oct 01 18:19:35 raspberrypi loop.sh[802]: humiditydeficit
Oct 01 18:19:35 raspberrypi loop.sh[802]: send
Oct 01 18:19:35 raspberrypi loop.sh[802]: {"ok":true}
lines 1-18/18 (END)
```

In case afte service set as off, you can see followings:
```
pi@raspberrypi:~/dht22 $ sudo systemctl status dht22.service
Unit dht22.service could not be found.
```

## Dependency
This project depend on followings:

- [technion/lol_dht22](https://github.com/technion/lol_dht22): Nice Raspberry Pi DHT22/AM2302 polling application only depend on WiringPi. I'm really grateful for ***lol_dht22***.
- [UedaTakeyuki/sensorhandler](https://github.com/UedaTakeyuki/sensorhandler): Multipurpose sensorhandler, read the value from source & do somethings (send, save, trigger, ...) with it, as configed.

The ***setup.sh*** in this module install & setup all of these modules mentioned above and also there dependent modules.

## Q&A
Any questions, suggestions, reports are welcome! Please make [issue](https://github.com/UedaTakeyuki/dht22/issues) without hesitation! 

## history
- 1.2.0  2018.10.03  ad send_m2x
- 1.3.0  2022.03.24  python3 support
- 1.4.0  2023.11.13  Don't install python2-pip if OS version is BullsEye or later.

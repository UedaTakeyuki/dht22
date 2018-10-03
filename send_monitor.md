# Send Sensor value to the MONITOR™ server.

## What is monitor Server.
[MONITOR™](https://monitor.uedasoft.com) is a Web service to provide visualization of the sensor data. It shows the latest sent Camera Image and latest sent Sensor data as time seriese chart.
MONITOR™ manages display parts as ***element***. There are fllowing 2 type of element:

- ***view element*** for ***Camera Image***
- ***value element*** for ***Sensor Value***

![MONITOR display](https://monitor.uedasoft.com/docs/UserGuide/pics/2018-08-19.12.42.14-2.png)


## set value_id
Make sure your value_id on your account of the MONITOR. At the default, 3 of value_id are available, let's say that are as ABCDEF, GHIJKL, MNOPQR. In case you would use ABCDEF for making temperature chart, GHIJKL humidity chart and MNOPQR for humidity deficit, set these by setid.sh as

```
./setid.sh -t ABCDEF -h GHIJKL -d MNOPQR
```

In case just you would make only temeperature chart, -h and -d can be ommitted as follows:


```
./setid.sh -t ABCDEF
```

Detail syntax of ***setid.sh*** is as follow:

```
Usage: ./setid.sh [-t temp_id] [-h humidity_id] [-d humiditydeficit_id] 
  [temp_id]:            value_id for temperature 
  [humidity_id]:        value_id for humidity 
  [humiditydeficit_id]: value_id for humiditydeficit 
```

## test for sending Sensor value

```
python -m sensorhandler
```

In case everythin goood, response is as follows:

```
{'humiditydeficit': '12.2', 'temp': 25.2, 'humidity': 47.6}
temp
send
{"ok":true}
humidity
send
{"ok":false,"reason":"ViewID not valid"}
humiditydeficit
send
{"ok":true}
```

In case something wrong, response finished with {"ok":false,"reason":"XXX"}. For Example:

```
{"ok":false,"reason":"ValueID not valid"}
```

In case, you should make sure if correct value_is was set by setid.sh command.

## setting for automatically run view.sh at 5 minute interval

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

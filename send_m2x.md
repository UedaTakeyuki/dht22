# Send ｓensor value to the [AT&T M2X](https://m2x.att.com/).

With [M2X handler](https://github.com/UedaTakeyuki/handler4m2x) for [UedaTakeyuki/sensorhandler](https://github.com/UedaTakeyuki/sensorhandler), you can send dht22 data to AT&T M2X service without any programming, just only by setting.

## install [M2X handler](https://github.com/UedaTakeyuki/handler4m2x)
Set up script [send_m2x.setup.sh](send_m2x.setup.sh) in this project do all necessary instration task. Go to the folder where dht22 is installed, and call this script.

```
cd dht22
./send_m2x.setup.sh
```

## edit [config.toml](config.toml)
The [config.toml](config.toml) file in this project is just for MONITOR™ server like these :
```
[[sources]]
  name   = "dht22"
  errorhandler = "errorhandler"
  [[sources.values]]
    name = "temp"
    handlers = [
      "send_monitor",
#      "handler4m2x.send_m2x",
    ]
  [[sources.values]]
    name = "humidity"
    handlers = [
      "send_monitor",
#      "handler4m2x.send_m2x",
    ]
  [[sources.values]]
    name = "humiditydeficit"
    handlers = [
      "send_monitor",
#      "handler4m2x.send_m2x",
    ]
```

In order to enabling [M2X handler](https://github.com/UedaTakeyuki/handler4m2x), remove "#" character which is for commnet out "handler4m2x.send_m2x" line. And comment out "send_monitor" if you wouldn't send to the MONITOR at the same time.
After this, config.toml file might be as follows:

```
[[sources]]
  name   = "dht22"
  errorhandler = "errorhandler"
  [[sources.values]]
    name = "temp"
    handlers = [
#      "send_monitor",
      "handler4m2x.send_m2x",
    ]
  [[sources.values]]
    name = "humidity"
    handlers = [
#      "send_monitor",
      "handler4m2x.send_m2x",
    ]
  [[sources.values]]
    name = "humiditydeficit"
    handlers = [
#      "send_monitor",
      "handler4m2x.send_m2x",
    ]
```

## Set M2X API-KEY, DEVICE, STREAMS on the send_m2x.ini file
Go to your M2X Developper page, create your DEVICE, API-KEY, and 3 of STREAMs for temperature, rerative humidity and humidity deficit.
The necessary ACCESS of API-KEY for this is just "GET" and "PUT".
Then, go to handler4m2x folder and edit send_m2x.ini file. Originally, send_m2x.ini file must be as follows:

```
[stream]
temp=
humidity=
humiditydeficit=

[client]
key=

[device]
key=
```

So, fill your M2X STREAMs in [stream] section, your API-KEY in [client] section and DEVICE in [device] section like as follows:

```
[stream]
temp=my-room-temperature
humidity=my-room-humidity
humiditydeficit=my-room-humidiydeficit

[client]
key=123456749fb8eaaa669ebeb3b95f8c83

[device]
key=54321aa81bdedadb72bbbff76d85020a
```

## Read Sensor value and send it to M2X

Go up to the folder where dht22 is installed, call sensorhandler 

```
python -m sensorhandler
```

In case everythin goood, response is as follows:

```
pi@raspberrypi:~/dht22 $ python -m sensorhandler
{'humiditydeficit': '12.6', 'temp': 26.7, 'humidity': 50.2}
temp
handler4m2x.send_m2x
{u'status': u'accepted'}
humidity
handler4m2x.send_m2x
{u'status': u'accepted'}
humiditydeficit
handler4m2x.send_m2x
{u'status': u'accepted'}
```

In case something wrong, response finished with {"ok":false,"reason":"XXX"}. For Example:

```
{"ok":false,"reason":"ValueID not valid"}
```

In case, you should make sure if correct value_is was set by setid.sh command.

# coding:utf-8
# Copy Right Atelier UEDA  © 2015 -
#
# require: 'lol_dht' https://github.com/technion/lol_dht22
#          
# return:  {"temp": , "humidity": , "humiditydeficit":}

import os
import sys
import configparser
import subprocess32 as subprocess
import re
import json
import traceback
import requests
import urllib3
from urllib3.exceptions import InsecureRequestWarning
# refer http://73spica.tech/blog/requests-insecurerequestwarning-disable/
urllib3.disable_warnings(InsecureRequestWarning)

# get configration
configfile = os.path.dirname(os.path.abspath(__file__))+'/'+os.path.splitext(os.path.basename(__file__))[0]+'.ini'
ini = configparser.ConfigParser()
ini.read(configfile)

def dht22(gpio):
  global ini
  try:
    if ini.get("mode", "run_mode") == "dummy":
      result = {"temp":30.0, "humidity":30.0}

    else:
      p = subprocess.Popen("sudo "+os.path.abspath(os.path.dirname(__file__))+"/lol_dht22/loldht " + str(gpio) + " |grep Hum", stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
#      std_out, std_err = p.communicate(None, timeout=20)
      std_out, std_err = p.communicate(None, timeout=60) # extend timeout time
      result = std_out.strip()

      # read result
      match = re.match(r'Humidity = (.*) % Temperature = (.*) \*C',result.decode('utf-8'))
      temp = float(match.group(2))
      humidity =float(match.group(1))

      # drop bad value.
      if temp < -1000  or temp > 1000:
        temp = None
        print("temp: None")
      if humidity < -1000 or humidity > 1000:
        humidity = None
        print("humidity: None")
      if temp == 0 and humidity == 0:
        result = {}
      else:
        result = {"temp":temp, "humidity":humidity}
    return result
  except IOError:
    info=sys.exc_info()
    print ("IOError:"+ traceback.format_exc(info[0]))
  except:
    info=sys.exc_info()
    print ("Unexpected:"+ traceback.format_exc(info[0]))

# http://d.hatena.ne.jp/Rion778/20121203/1354546179
def HumidityDeficit(t,rh): # t: 温度, rh: 相対湿度
    ret = AbsoluteHumidity(t, 100) - AbsoluteHumidity(t, rh)
    return ret; 

# http://d.hatena.ne.jp/Rion778/20121203/1354461231
def AbsoluteHumidity(t, rh):
    ret = 2.166740 * 100 * rh * tetens(t)/(100 * (t + 273.15))
    return ret


#  Saturated vapor pressure
#  function GofGra(t){};
# http://d.hatena.ne.jp/Rion778/20121126/1353861179
def tetens(t):
    ret = 6.11 * 10 ** (7.5*t/(t + 237.3))
    return ret

def read():
  global ini
  result = dht22(ini.get("gpio", "gpio"))
  if result is not None:
    result["humiditydeficit"] = ('%.1f' % HumidityDeficit(result["temp"],result["humidity"]))
    return result

if __name__ == '__main__':
#  print json.dumps(dht22(ini.get("gpio", "gpio")))
  values = read()
  print (values)


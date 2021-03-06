#!/bin/bash

usage_exit() {
  echo "Usage: $0 [-t temp_id] [-h humidity_id] [-d humiditydeficit_id] " 1>&2
  echo "  [temp_id]:            value_id for temperature " 			1>&2
  echo "  [humidity_id]:        value_id for humidity " 				1>&2
  echo "  [humiditydeficit_id]: value_id for humiditydeficit " 	1>&2
  exit 1
}

if [ $# -eq 0 ]; then
  usage_exit
fi

while getopts t:h:d: OPT
do
  case $OPT in
    t)  VALUE_t=$OPTARG
        ;;
    h)  VALUE_h=$OPTARG
        ;;
    d)  VALUE_d=$OPTARG
        ;;
    h)  usage_exit
        ;;
    \?) usage_exit
        ;;
  esac
done

if [ -n "$VALUE_t" ]; then
	sed -i "s/^temp=.*/temp=${VALUE_t}/" send_monitor.ini
fi
if [ -n "$VALUE_h" ]; then
	sed -i "s/^humidity=.*/humidity=${VALUE_h}/" send_monitor.ini
fi
if [ -n "$VALUE_d" ]; then
	sed -i "s/^humiditydeficit=.*/humiditydeficit=${VALUE_d}/" send_monitor.ini
fi

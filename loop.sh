#!/bin/bash
#SCRIPT_DIR=$(cd $(dirname $0); pwd)
while true
do
  python -m sensorhandler --config $(cd $(dirname $0); pwd)/config.toml --imppath $(cd $(dirname $0); pwd)
  sleep 5m
done

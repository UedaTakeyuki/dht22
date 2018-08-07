#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)
while true; do sudo python ${SCRIPT_DIR}/dht22.py; sleep 5m; done

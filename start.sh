#!/bin/bash

if [ -e /data/APIKEY.txt ]; then
  ln -s /data/APIKEY.txt /src/etherpad/APIKEY.txt
fi

if [ -e /data/settings.json ]; then
  ln -s /data/settings.json /src/etherpad/settings.json
fi

exec /src/etherpad/bin/run.sh --root

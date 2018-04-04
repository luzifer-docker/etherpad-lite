#!/bin/bash
set -euxo pipefail

if [ -e /data/APIKEY.txt ]; then
  rm -f /src/etherpad/APIKEY.txt
  ln -s /data/APIKEY.txt /src/etherpad/APIKEY.txt
fi

if [ -e /data/settings.json ]; then
  rm -f /src/etherpad/settings.json
  ln -s /data/settings.json /src/etherpad/settings.json
fi

exec /src/etherpad/bin/run.sh --root

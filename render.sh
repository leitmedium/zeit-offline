#!/bin/bash

URL=${1/https:\/\/www/http:\/\/xml}

if hash curl 2>/dev/null ; then
  curl -s $URL | xsltproc zeitoffline.xslt - > artikel.html
elif hash wget 2>/dev/null ; then
  wget $URL --quiet -O - | xsltproc zeitoffline.xslt - > artikel.html
else
  echo "Neither curl nor wget found. Aborting."
  exit 1
fi

if hash xdg-open 2>/dev/null ; then
  xdg-open artikel.html
elif hash open 2>/dev/null ; then
  open artikel.html
else
  echo "Neither xdb-open nor open found. Aborting, as I don't know how to open your browser with artikel.html"
  exit 1
fi

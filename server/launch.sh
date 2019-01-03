#!/bin/sh

cd "$(dirname "$0")"

PRECIP=$( ./tt )
cp -f assets/Rain_$PRECIP.jpg PRECIP.jpg
./bar_sub
cat DS | jq .hourly.summary | sed 's/"//g' > SUMMARY.txt

#Parse Weather and replace placeholder text in the svg template file
python parse_weather.py

#convert svg to png, and rotate 90 degrees for horizontal view
sudo /usr/local/bin/convert -depth 8 -rotate 90 weather-processed.svg weather-processed.png

#We optimize the image (necessary for viewing on the kindle)
sudo /usr/local/bin/pngcrush -q -c 0 weather-processed.png weather-script-output.png > /dev/null 2>&1


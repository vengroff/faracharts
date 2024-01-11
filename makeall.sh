#!/usr/bin/env sh


for vf in fraction ""
do
  echo Vehicle feature: $vf

  gmake STATE=36 PLACE=51000 PLACE_NAME="'New York, New York'" VEHICLE_FEATURE=$vf
  gmake STATE=06 PLACE=44000 PLACE_NAME="'Los Angeles, California'" VEHICLE_FEATURE=$vf
  gmake STATE=17 PLACE=14000 PLACE_NAME="'Chicago, Illinois'" VEHICLE_FEATURE=$vf
  gmake STATE=48 PLACE=35000 PLACE_NAME="'Houston, Texas'" VEHICLE_FEATURE=$vf
  gmake STATE=04 PLACE=55000 PLACE_NAME="'Phoenix, Arizona'" VEHICLE_FEATURE=$vf
  gmake STATE=42 PLACE=60000 PLACE_NAME="'Philadelphia, Pennsylvania'" VEHICLE_FEATURE=$vf
  gmake STATE=48 PLACE=65000 PLACE_NAME="'San Antonio, Texas'" VEHICLE_FEATURE=$vf
  gmake STATE=06 PLACE=66000 PLACE_NAME="'San Diego, California'" VEHICLE_FEATURE=$vf
  gmake STATE=48 PLACE=19000 PLACE_NAME="'Dallas, Texas'" VEHICLE_FEATURE=$vf
  gmake STATE=06 PLACE=68000 PLACE_NAME="'San Jose, California'" VEHICLE_FEATURE=$vf
  gmake STATE=48 PLACE=05000 PLACE_NAME="'Austin, Texas'" VEHICLE_FEATURE=$vf
  gmake STATE=12 PLACE=35000 PLACE_NAME="'Jacksonville, Florida'" VEHICLE_FEATURE=$vf
  gmake STATE=39 PLACE=18000 PLACE_NAME="'Columbus, Ohio'" VEHICLE_FEATURE=$vf
  gmake STATE=06 PLACE=67000 PLACE_NAME="'San Francisco, California'" VEHICLE_FEATURE=$vf
  gmake STATE=48 PLACE=27000 PLACE_NAME="'Fort Worth, Texas'" VEHICLE_FEATURE=$vf
  gmake STATE=18 PLACE=36003 PLACE_NAME="'Indianapolis, Indiana'" VEHICLE_FEATURE=$vf
  gmake STATE=37 PLACE=12000 PLACE_NAME="'Charlotte, North Carolina'" VEHICLE_FEATURE=$vf
  gmake STATE=53 PLACE=63000 PLACE_NAME="'Seattle, Washington'" VEHICLE_FEATURE=$vf
  gmake STATE=08 PLACE=20000 PLACE_NAME="'Denver, Colorado'" VEHICLE_FEATURE=$vf
  gmake STATE=11 PLACE=50000 PLACE_NAME="'Washington, District of Columbia'" VEHICLE_FEATURE=$vf

done

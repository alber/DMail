#!/bin/bash

lastdockedstatus=$(<isdocked.txt)
#echo " $lastdockedstatus " 
isnearstatus=$(./isnear_station.sh)
#echo " $isnearstatus " 

if [ $lastdockedstatus -eq 0 ]
then
  if [ $isnearstatus ]
  then
    echo 1 > isdocked.txt
    echo 1
  else
    echo 0
  fi
else
  echo 0
fi

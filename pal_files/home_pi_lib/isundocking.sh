#!/bin/bash

lastdockedstatus=$(<isdocked.txt)
#echo " $lastdockedstatus " 
isnearstatus=$(./isnear_station.sh)
#echo " $isnearstatus " 

if [ $lastdockedstatus -eq 1 ]
then
  if [ $isnearstatus -eq 0 ]
  then
    echo 0 > isdocked.txt
    echo 1
  else
    echo 0
  fi
else
  echo 0
fi

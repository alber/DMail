#!/bin/bash

#lat $1

#long $2

curl -X GET "https://api.weather.com/v1/geocode/$1/$2/forecast/fifteenminute.json?units=m&language=en-US&apiKey=da328055e2e940d8b28055e2e9e0d851" -H "accept: application/json" -H "Accept-Encoding: gzip" | gunzip -


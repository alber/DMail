#!/bin/bash

source /home/pi/.rvm/scripts/rvm
sleep 3s
cd Public/palstation/
rails s -b 0.0.0.0 &

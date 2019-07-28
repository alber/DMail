#!/bin/bash

#sudo batctl n -H | awk '/b8:27:eb:f8:e8:5a/ {print ($3+0) <= 10}' -
sudo batctl n -H | awk '/b8:27:eb:41:c3:94/ {print ($3+0) <= 10}' -

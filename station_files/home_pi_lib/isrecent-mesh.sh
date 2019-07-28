#!/bin/bash
sudo batctl n -H | awk '{print ($3+0) <= 10, $2}' -

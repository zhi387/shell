#!/bin/bash
if [ ping -w 1  -c 1 192.168.0.2 > /dev/null ]
then
echo "1"
else
echo "0"
fi

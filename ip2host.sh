#!/bin/bash
#
#ping局域网内ip，查找存在主机。
#
i=${2}
while [ ${i} -le ${3} ]
do
echo "ping -w 1 -c 1 ${1}.${i}"
ping -w 1 -c 1 "${1}.${i}" | grep "ttl=" |awk '{print $4}' >>  ping.log
i=$(($i+1))
done
awk  -F ':'  '{print $1}' ping.log > ip2host.log
rm ping.log
#host 数量
count=`grep -c . ip2host.log`
echo "There are ${count} host!"

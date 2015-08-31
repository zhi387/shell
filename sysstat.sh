#!/bin/bash
#
#使用shell scripts 获取系统运行状态、软硬件信息（cpu负载、内存使用率、swap使用率、io速率、硬盘空间、网络流量、软件包版本）。
#
#cpu负载
cpuload=(`cat  /proc/loadavg | awk '{print $1,$2,$3}'`)
#内存使用
mem_usage=(`awk '/MemTotal/{total=$2}/MemFree/{free=$2}/Buffers/{buffers=$2}/^Cached/{cached=$2}END{print (total-free-buffers-cached)/1024}' /proc/meminfo`)
#swap使用
swap_usage=`awk '/SwapTotal/{total=$2}/SwapFree/{free=$2}END{print (total-free)/1024}'  /proc/meminfo`
#io
io=(`awk  '/pgpgin/{pgin=$2}/pgpgout/{pgout=$2}END{print pgin,pgout}' /proc/vmstat`)
#硬盘空间
df_usage=`df |awk '{print "\t"$1"\t"$5"\t"$2}'`
#网络流量
traffic_be=(`awk 'BEGIN{ORS=" "}/enp2s0/{print $2,$10}' /proc/net/dev`)
echo "testing eth , please wait , 10s"
sleep 10
traffic_af=(`awk 'BEGIN{ORS=" "}/enp2s0/{print $2,$10}' /proc/net/dev`)
netin=$(( (${traffic_af[0]}-${traffic_be[0]})/8/5 ))
netout=$(( (${traffic_af[1]}-${traffic_be[1]})/8/5 ))
#软件信息
package=`rpm -qa`
#输出信息
(echo -e "cpu_load[1,5,15]: ${cpuload[0]}\t${cpuload[1]}\t${cpuload[2]}"
echo "mem_usage：${mem_usage}"
echo "swap_usage: ${swap_usage}"
echo -e "ioin:${io[0]}\tioout:${io[1]}"
echo "df_usage:${df_usage}"
echo -e "netin:${netin}\tnetout:${netout}"
echo -e "package:\n$package")>sysstat.log

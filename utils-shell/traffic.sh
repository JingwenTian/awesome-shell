#!/bin/sh
 
###统计10s内的平均流量，以Mb为单位

#先安装计数器扩展: apt-get install bc

if [ "$1" = "" ];then
  echo -e "\n      use interface_name after the script,like \"$0 eth0\"...\n"
  exit -1
fi
 
echo -e "\n      start monitoring the $1,press \"ctrl+c\" to stop"
echo ----------------------------------------------------------
#ls  /etc/sysconfig/network-scripts/|grep ifcfg|cut -d "-" -f 2
 
while true
  do
 
  RX_bytes=`cat /proc/net/dev|grep "$1"|awk '{print $1}'|cut -d ":" -f 2`
  TX_bytes=`cat /proc/net/dev|grep "$1"|awk '{print $9}'`
 
  sleep 10
 
  RX_bytes_later=`cat /proc/net/dev|grep "$1"|awk '{print $1}'|cut -d ":" -f 2`
  TX_bytes_later=`cat /proc/net/dev|grep "$1"|awk '{print $9}'`
 
  ###Mb=B*8/1024/1024
  speed_RX=`echo "scale=2;($RX_bytes_later - $RX_bytes)*8/1024/1024/10"|bc`
  speed_TX=`echo "scale=2;($TX_bytes_later - $TX_bytes)*8/1024/1024/10"|bc`
 
  printf "%-3s %-3.1f %-10s %-4s %-3.1f %-4s\n" IN: $speed_RX Mb/s OUT: $speed_TX Mb/s
    
done

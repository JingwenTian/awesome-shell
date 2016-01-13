#!/bin/bash
#查看当前系统的各个状态的网络连接数目
netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'

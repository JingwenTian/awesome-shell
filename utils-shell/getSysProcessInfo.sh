#!/bin/bash
#倒序查看服务器各类进程数
ps -ef| awk '{a[$8]++}END{for(i in a){print i,a[i] | "sort -r -k 2"}}'

#!/bin/bash
# 统计文件或目录数量: 
# 统计文件: ./counter.sh f 统计目录: ./counter.sh d
STR=$1
case $STR in
	f|1)	ls -l | grep "^-" | wc -l
			;;
	d|2)	ls -l | grep "^d" | wc -l
			;;
	*)		echo "执行./counter.sh f|d - f表示文件,d表示目录"
			;;
esac

#!/bin/sh
#读取文件状态（修改时间，大小，权限模式，磁盘占用）
#usage: stat access.log

string=$1
stat $string

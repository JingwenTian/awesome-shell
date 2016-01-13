#!/bin/sh
# 备份和远程同步脚本
# @param 本地目录
# @param 远程目录
# @param 远程主机信息
# @sync remote dir: ./rsync.sh /local/dir/ /remote/dir/ root@123.56.91.143
# @sync local dir:  ./rsync.sh /local/dir1/ /local/dir2/ root@192.168.1.200
#
# @Author: jingwentian
# @Date:   2015-10-29 18:28:55
# @Last Modified by:   jingwentian
# @Last Modified time: 2015-10-29 21:37:58

LOCALDIR=$1
REMOTEDIR=$2
REMOTEHOST=$3

if [ "$LOCALDIR" = "" ] || [ "$REMOTEDIR" = "" ] || [ "$REMOTEHOST" = "" ];then
    echo -e "\n      USAGE: \"$0 /local/dir/ /remote/dir/ root@123.56.91.143 \n"
    exit -1
fi

echo "********** These files will be sync **********"
ls -l $LOCALDIR
echo "********** Sure you want to sync?(y/n)"
while :
do
read input
case $input in
Y|y)
echo  "Start sync"
rsync -avzh -e 'ssh -p22' --progress $LOCALDIR  $REMOTEHOST:$REMOTEDIR
exit
;;
N|n)
echo "Quit"
exit
;;
*)
echo "Please input y/n"
;;
esac
done

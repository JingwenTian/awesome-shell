#!/bin/bash

#通过chattr命令锁定文件或目录
#http://vbird.dic.ksu.edu.tw/linux_basic/0340bashshell-scripts_3.php
#http://www.dayanmei.com/lnmp-delete-user-ini/

#FILE_NAME=$1 #文件/文件夹名称
#OPERATE_TYPE=$2 #操作类型 锁定/解锁

#貌似不用判断文件的类型, chattr锁定和解锁文件夹的时候无需-R来递归处理

#锁定文件
lock()
{
	if [ "${filetype}" == 'file' ];then
		chattr +i $filename
	else
		chattr +i $filename 
	fi
}

#解锁文件
unlock()
{
	if [ "${filetype}" == 'file' ];then
		chattr -i $filename
	else
		chattr -i $filename 
	fi
}

#查询文件属性
cat()
{
	lsattr $filename
}

#提示输入文件名称
echo -e "Please input a filename. \n\n"
read -p "Input a filname:" filename
test -z $filename && echo "You must input a filename" && exit 0

#判断文件和操作类型是否存在
test ! -e $filename && echo "The filename '$filename' DO NOT exist" && exit 0

#判断文件类型
test -f $filename && filetype="file"
test -d $filename && filetype="dir"

#提示输入操作类型
read -p "Input operate type(lock/unlock/cat):" operate

if [ "${operate}" == "lock" ];then
	lock
elif [ "${operate}" == "unlock" ];then
	unlock
else
	cat
fi



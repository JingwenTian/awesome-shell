#!/bin/sh
# add new user 
# @Author: jingwentian
# @Date:   2016-01-02 17:38:37
# @Last Modified by:   jingwentian
# @Last Modified time: 2016-01-04 19:51:20

export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
clear

printf "
>>>>>>>>>>>>>>>>>>>>> 开始添加新用户 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"

. ./include/util.sh

if [ ! -n "$1" ];then
Echo_Red "please add your username !";
exit;
fi

uname=$1;
/usr/sbin/groupadd $uname
/usr/sbin/useradd -g $uname $uname -d /home/$uname/
Echo_Blue "add user ok ."

chmod -R 755  /home/$uname
mkdir /home/$uname/nginx/
mkdir /home/$uname/webroot/
echo "this is your webroot !" > /home/$uname/webroot/readme.txt


# TODO: 将nginx的配置文件拷贝到每个人的目录, 然后启动文件里监听不同的端口
# cp -r /home/mosh/nginx/* /home/$uname/nginx/
# rm /home/$uname/nginx/conf/vhost*
# cp /home/mosh/nginx/conf/vhost.conf  /home/$uname/nginx/conf/
# echo "add nginx info ok ."

chown  $uname.$uname  -R /home/$uame

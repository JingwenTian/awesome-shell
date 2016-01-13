#!/bin/bash
#通过使用客户端执行mysql登陆命令来监控mysql服务是否正常
#reference: http://t.cn/RUqlgxi

USERNAME=$1
PASSWORD=$2

if [ "$USERNAME" = "" ] || [ "$PASSWORD" = "" ];then
  echo -e "\n       WARNING: you need to input the username and password,like \"$0 root 1234\"...\n"
  exit -1
fi

mysql -u$USERNAME -p$PASSWORD -e "select version();" &>/dev/null
if [ $? -ne 0 ]
then
    /etc/init.d/mysql start
else
    echo "MySQL is running"
fi


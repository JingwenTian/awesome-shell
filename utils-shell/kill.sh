#!/bin/sh

###杀掉进程 ./kill.sh swoole

if [ "$1" = "" ];then
  echo -e "usage: \"$0 your_process_name\"...\n"
  exit -1
fi

ps -ef | grep $1 | grep -v grep | awk '{print $2}' | xargs kill

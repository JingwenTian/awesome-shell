#########################################################################
# [Multi Tail Script]
# Desc: 多日志文件合并输出打印
# Usage: sh multitail.sh "/foo/bar/*-access-log"
# File Name: multitail.sh
# Author: jingwentian
# mail: mini.mosquitor@gmail.com
# Created Time: 二 11/14 12:10:51 2017
#########################################################################
#!/bin/bash

# 作为参数输入的日志文件(必须匹配到多个文件)
PARAMS_LOG=$1
# 需要合并的日志文件配置(如果PARAMS_LOG为空则可以在此手工配置 ex: ('/foo/a.log' '/bar/b.log'))
TARGET_LOG=()
# 合并输出的日志文件
TAIL_LOG=/tmp/multilog.log
# PID容器(用于退出时杀死) 
TAIL_PID=()

# 退出 `ctrl-c`时触发 ctrl_c() 进行清理工作
# 参考: http://man.linuxde.net/trap
trap ctrl_c SIGINT

# 打印方法(加点颜色好看)
Color_Text() {
  echo -e " \e[0;$2m$1\e[0m"
}
Echo_Red() {
  echo $(Color_Text "$1" "31")
}
Echo_Green() {
  echo $(Color_Text "$1" "32")
}
Echo_Yellow() {
  echo $(Color_Text "$1" "33")
}
Echo_Blue() {
  echo $(Color_Text "$1" "34")
}

# 帮助信息
usage () {
    Echo_Blue '[Multi Tail Script Usage]'
    Echo_Blue '此脚本用于多日志文件合并输出打印'
    Echo_Yellow '方法一: 通过传入参数:'  
    Echo_Green 'multitail.sh "/foo/bar/*-access-log"'
    Echo_Yellow '方法二: 通过固定配置:'
    Echo_Green "TARGET_LOG=('/foo/a.log' '/bar/b.log')"
    exit 0
}

# 如果传入参数则在此重置目标日志配置
if [ "PARAMS_LOG" != "" ];then
  TARGET_LOG=${PARAMS_LOG}
fi

# 输出帮助信息
#if [ ${#TARGET_LOG[@]} -eq 0 ]; then
if [ $(echo -ne ${TARGET_LOG} | wc -m) -eq 0 ];then
  usage
fi

# 执行开始
Echo_Green "==> 开始合并打印...."

# 退出时进行清理工作: 干掉所有后台的tail, 并且清空合并后的文件, 然后退出
function ctrl_c() {
    # ps aux |grep tail |grep -v grep| awk '{print $2}' |xargs kill -9
    Echo_Red "==> 停止合并打印...."
    for pid in ${TAIL_PID[*]}; do Echo_Red "==> 清理PID ${pid}..."; kill -9 ${pid}; done
    cat /dev/null > ${TAIL_LOG}
    exit 0
}

# 将日志文件配置的数组循环
# 在后台进行 `tail -f` 输出到一个文件中
# 然后`tail -f` 最终合并的文件进行统一输出
# for file in /foo/bar/debug_*; do echo "==> ${file} <=="; done
i=0
for file in ${TARGET_LOG[*]}
do
    Echo_Green "==> 导入日志文件: ${file}"
    tail -f "${file}" >> ${TAIL_LOG} &
    TAIL_PID[$i]=$!
    (( i++ ))
done

tail -f ${TAIL_LOG}

#!/bin/sh
# @Author: jingwentian
# @Date:   2016-01-02 00:24:12
# @Last Modified by:   jingwentian
# @Last Modified time: 2016-01-02 21:11:57

export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
clear

printf "
>>>>>>>>>>>>>>>>>>>>> 开始安装啦 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"

# 检测是否是root用户
if [ $(id -u) != "0" ]; then
    echo "Error: 你必须使用root用户来执行此脚本"
    exit 1
fi

#包含的脚本
. ./include/util.sh
. ./include/init.sh

#检测系统
Get_Dist_Name
if [ "${DISTRO}" = "unknow" ]; then
    Echo_Red "未知系统,无法支持"
    exit 1
fi

Init_Install()
{
	Init_Prepare
	Init_Environment
	Init_Addons
}

# 系统准备
Init_Prepare()
{
	#确认开始
	Press_Install
	#打印系统参数
	Print_Sys_Info
	Check_Hosts

	#初始化依赖
	CentOS_InstallNTP
	CentOS_RemoveAMP
	CentOS_Dependent

	#设置时区
	Set_Timezone
	#关闭SELinux
	Disable_Selinux
	#创建目录
	Init_Dir
	#批量下载
	Multi_Download
	#批量解压
	Multi_Unzip
}

#安装环境基础扩展
Init_Environment()
{
	Install_Pcre
	Install_Libiconv
	Install_Libmcrypt
	Install_Mhash
	Install_Mcrypt

	Install_MySQL 
	Install_PHP
	Install_ImageMagick
	Install_Imagick
	Install_Libmemcached
	Install_Memcached
	Install_Raphf
	Install_Propro
	Install_Curl
	Install_Pecl_http

	Install_Tengine
}

#安装插件 
#TODO:后面写成可选安装的形式
Init_Addons()
{
	Install_Mongo
	Install_Swoole
	Install_Yaf

	Install_Git
	Install_Zsh
}


#开始执行并记录LOG
Init_Install 2>&1 | tee -a /root/EsysShell-install.log





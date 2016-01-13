#!/bin/bash
#通过执行以下命令，可以在1分钟内对系统资源使用情况有个大致的了解。
# http://openskill.cn/article/252
#   uptime
#   dmesg | tail
#   vmstat 1
#   mpstat -P ALL 1
#   pidstat 1
#   iostat -xz 1
#   free -m
#   sar -n DEV 1
#   sar -n TCP,ETCP 1
#   top
# @author: jingwentian

## 工具方法

Color_Text()
{
  echo -e " \e[0;$2m$1\e[0m"
}

Echo_Red()
{
  echo $(Color_Text "$1" "31")
}

## 分析性能方法

Show_Uptime()
{
	Echo_Red "负载情况: ======================================================================"
	uptime
	sleep 5
}

Show_Dmesg()
{
	Echo_Red "系统日志(最后10行): ============================================================="
	dmesg | tail
	sleep 5
}

Show_Vmstat()
{
	Echo_Red "系统核心指标: ==================================================================="
	#vmstat 1 1秒执行一次
	vmstat 1 5   
	sleep 10
}

Show_Mpstat()
{
	Echo_Red "每个CPU的占用情况: ==============================================================="
	#mpstat -P ALL 1 逐个显示
	mpstat -P ALL 
	sleep 5
}

Show_Pidstat()
{
	Echo_Red "进程的CPU占用率: ================================================================="
	#pidstat 1 一秒显示一个
	pidstat 1 5 #1s 显示5个
	sleep 10
}

Show_Iostat()
{
	Echo_Red "磁盘IO情况: ======================================================================"
	iostat -xz 1 5
	sleep 5
}

Show_Free()
{
	Echo_Red "内存的使用情况: ==================================================================="
	free -m
	sleep 5
}

Show_Sar()
{
	Echo_Red "网络设备的吞吐率: ================================================================="
	sar -n DEV 1 5
	sleep 5
}

Show_SarTcp()
{
	Echo_Red "TCP连接状态: ======================================================================"
	sar -n TCP,ETCP 1 5
	sleep 5
}

Show_Top()
{
	Echo_Red "综合状态: ========================================================================="
	#htop
	top -n 1
}

Run_Analysis()
{
	Show_Uptime
	Show_Dmesg
	Show_Vmstat
	Show_Mpstat
	Show_Pidstat
	Show_Iostat
	Show_Free
	Show_Sar
	Show_SarTcp
	Show_Top
}
Run_Analysis 2>&1 | tee -a /root/system-analysis.log


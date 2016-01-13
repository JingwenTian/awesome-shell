#!/bin/bash
#获取本机IP地址
ifconfig | grep "inet addr:" | awk '{ print $2 }'| sed 's/addr://g'

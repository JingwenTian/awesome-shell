#!/bin/sh
# CURL循环请求并返回HTTP状态码

URL=$1
TIMES=$2

if [ "$URL" = "" ] || [ "$TIMES" = "" ];then
    echo -e "\n      USAGE: \"$0 http://website.com 100 \n"
    exit -1
fi

for i in {0..$TIMES}; do (curl -Is $URL | head -n1 &) 2>/dev/null; done

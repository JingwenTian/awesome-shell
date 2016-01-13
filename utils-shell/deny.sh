#!/bin/bash
blockips=/home/tianjingwen/nginx/conf/blockips.conf
tail -n100 /home/tianjingwen/nginx/logs/www-access-log \
|awk '{if($7!~/a/)next}{print $1,$7,$11}' \
|grep -i -v -E "google|yahoo|baidu|msnbot|FeedSky|sogou" \
|awk '{print $1}'|sort|uniq -c|sort -rn \
|awk '{if($1>10)print "deny "$2";"}' >$blockips
/home/tianjingwen/nginx/nginxctl reload

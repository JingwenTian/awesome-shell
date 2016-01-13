#!/bin/sh

#usage: ~/bin/catProgress.sh swoole

string=$1

ps aux | grep -v grep | grep -v bin/sh | grep --color=auto $string

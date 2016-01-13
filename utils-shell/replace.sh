#!/bin/bash

#usage: ~/bin/replace.sh 'origin_string' 'new_string' './dir'

STR1=$1
STR2=$2
DIR=$3

perl -pi -e "s|$STR1|$STR2|g" `find $DIR -type f`

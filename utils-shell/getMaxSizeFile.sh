#!/bin/bash  
#查找最大文件
a=0  
for  name in *.*  
do  
    b=$(ls -l $name | awk '{print $5}')  
    if test $b -gt $a  
    then a=$b  
    namemax=$name 
    maxsize=$(du -sh $namemax) 
    fi  
done  
echo "the max file is $maxsize"

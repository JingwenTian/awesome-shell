##常用shell命令备忘

1. 倒序查看服务器各类进程数
	ps -ef| awk '{a[$8]++}END{for(i in a){print i,a[i] | "sort -r -k 2"}}'

2. rsync 同步命令备忘

	1. Basic Syntax:
		mkdir dir1
		mkdir dir2
		touch dir1/file{1..100}
		rsync -r dir1/ dir2  # -r 对子目录以递归模式处理
		rsync -a dir1/ dir2  # -a 相当于-rlptgoD，-r递归 -l拷贝链接文件；-p 保持文件原有权限；-t 保持文件原有时间；-g 保持文件原有用户组；-o 保持文件原有属主；-D 相当于块设备文件

---

##参考

1. http://www.tuicool.com/articles/ERbIVj

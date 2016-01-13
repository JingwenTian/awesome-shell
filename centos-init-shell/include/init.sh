#!/bin/sh
#各类初始化方法
# @Author: jingwentian
# @Date:   2015-11-15 12:59:47
# @Last Modified by:   jingwentian
# @Last Modified time: 2016-01-02 21:07:29

#设置时区
Set_Timezone()
{
    Echo_Blue "Setting timezone..."
    rm -rf /etc/localtime
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
}

#批量下载
Multi_Download()
{
	Echo_Blue "[+] Downloading files..."
	cd /home/src
	Download_Files http://tengine.taobao.org/download/tengine-2.1.1.tar.gz tengine-2.1.1.tar.gz 
	Download_Files http://us2.php.net/distributions/php-5.6.15.tar.bz2 php-5.6.15.tar.bz2
	Download_Files http://cdn.mysql.com/Downloads/MySQL-5.6/mysql-5.6.28.tar.gz mysql-5.6.28.tar.gz
	Download_Files http://pecl.php.net/get/pecl_http-2.1.2.tgz pecl_http-2.1.2.tgz
	Download_Files http://pecl.php.net/get/raphf-1.0.2.tgz raphf-1.0.2.tgz
	Download_Files http://pecl.php.net/get/propro-1.0.0.tgz propro-1.0.0.tgz
	Download_Files http://pecl.php.net/get/zip-1.10.2.tgz zip-1.10.2.tgz
	Download_Files http://blog.s135.com/soft/linux/nginx_php/pcre/pcre-8.10.tar.gz pcre-8.10.tar.gz
	Download_Files http://blog.s135.com/soft/linux/nginx_php/libiconv/libiconv-1.13.1.tar.gz libiconv-1.13.1.tar.gz
	Download_Files http://blog.s135.com/soft/linux/nginx_php/mcrypt/libmcrypt-2.5.8.tar.gz libmcrypt-2.5.8.tar.gz
	Download_Files http://blog.s135.com/soft/linux/nginx_php/mcrypt/mcrypt-2.6.8.tar.gz mcrypt-2.6.8.tar.gz
	Download_Files http://blog.s135.com/soft/linux/nginx_php/mhash/mhash-0.9.9.9.tar.gz mhash-0.9.9.9.tar.gz 
	Download_Files http://pecl.php.net/get/memcached-2.2.0.tgz memcached-2.2.0.tgz
	Download_Files http://pecl.php.net/get/PDO_MYSQL-1.0.2.tgz PDO_MYSQL-1.0.2.tgz
	Download_Files http://pecl.php.net/get/imagick-3.1.1.tgz imagick-3.1.1.tgz
	Download_Files http://www.imagemagick.org/download/ImageMagick.tar.gz ImageMagick.tar.gz
	Download_Files https://launchpad.net/libmemcached/1.0/1.0.9/+download/libmemcached-1.0.9.tar.gz libmemcached-1.0.9.tar.gz
	#Download_Files http://mrplus.googlecode.com/files/jdk-6u31-linux-x64.bin 
	Download_Files http://curl.haxx.se/download/curl-7.38.0.tar.gz curl-7.38.0.tar.gz

	Download_Files http://pecl.php.net/get/mongo-1.6.10.tgz mongo-1.6.10.tgz
	Download_Files http://memcached.org/files/memcached-1.4.24.tar.gz memcached-1.4.24.tar.gz
	Download_Files https://github.com/swoole/swoole-src/archive/swoole-1.7.20-stable.tar.gz
	Download_Files http://pecl.php.net/get/yaf-2.3.5.tgz 
}

#批量解压
Multi_Unzip()
{
	Echo_Blue "[+] Unzip files..."
	cd /home/src
	tar -axvf tengine-2.1.1.tar.gz
	tar -axvf php-5.6.15.tar.bz2
	tar -axvf mysql-5.6.28.tar.gz
	tar -zxvf pecl_http-2.1.2.tgz
	tar -zxvf raphf-1.0.2.tgz
	tar -zxvf propro-1.0.0.tgz
	tar -zxvf zip-1.10.2.tgz
	tar -zxvf pcre-8.10.tar.gz
	tar -zxvf libiconv-1.13.1.tar.gz
	tar -zxvf libmcrypt-2.5.8.tar.gz
	tar -zxvf mcrypt-2.6.8.tar.gz
	tar -zxvf mhash-0.9.9.9.tar.gz
	tar -zxvf memcached-2.2.0.tgz
	tar -zxvf PDO_MYSQL-1.0.2.tgz
	tar -zxvf imagick-3.1.1.tgz
	tar -zxvf ImageMagick.tar.gz
	tar -zxvf libmemcached-1.0.9.tar.gz
	tar -zxvf curl-7.38.0.tar.gz 
	tar -zxvf mongo-1.6.10.tgz
	tar -zxvf memcached-1.4.24.tar.gz
	tar -zxvf swoole-1.7.20-stable.tar.gz
	tar -zxvf yaf-2.3.5.tgz 

}

#初始化创建目录
Init_Dir()
{
	mkdir /home/src 
	mkdir /data 
	mkdir /data/pubsrv/ 
	mkdir /data/pubsrv/mysql/
	mkdir /data/mysql
	ln -s /data/pubsrv /home/pubsrv
}

Check_Hosts()
{
    if grep -Eqi '^127.0.0.1[[:space:]]*localhost' /etc/hosts; then
        echo "Hosts: ok."
    else
        echo "127.0.0.1 localhost.localdomain localhost" >> /etc/hosts
    fi
    ping -c1 evente.cn
    if [ $? -eq 0 ] ; then
        echo "DNS...ok"
    else
        echo "DNS...fail"
        echo -e "nameserver 208.67.220.220\nnameserver 114.114.114.114" > /etc/resolv.conf
    fi
}

#安装配置NTP(时间源保持时间同步的协议)
CentOS_InstallNTP()
{
    Echo_Blue "[+] Installing ntp..."
    yum install -y ntp
    ntpdate -u pool.ntp.org
    date
}

#清除安装历史
CentOS_RemoveAMP()
{
    Echo_Blue "[-] Yum remove packages..."
    rpm -qa|grep httpd
    rpm -e httpd httpd-tools
    rpm -qa|grep mysql
    rpm -e mysql mysql-libs
    rpm -qa|grep php
    rpm -e php-mysql php-cli php-gd php-common php

    yum -y remove httpd*
    yum -y remove mysql-server mysql mysql-libs
    yum -y remove php*
    yum clean all
}

#CentOS依赖安装等
CentOS_Dependent()
{
	Echo_Blue "[+] Yum installing dependent packages..."

	sed -i "s/#ClientAliveInterval 0/ClientAliveInterval 60/g" /etc/ssh/sshd_config 
	sed -i "s/#ClientAliveCountMax 3/ClientAliveInterval 60/g" /etc/ssh/sshd_config 
	sed -i "s/exclude/#exclude/g" /etc/yum.conf 
	yum -y install gcc gcc-c++ autoconf libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel pcre-devel openssl openssl-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers vim-common dos2unix readline readline-devel cmake bison libtool flex pkg-config patch gd gd-devel locate libevent libevent-devel openldap.x86_64 openldap-devel.x86_64 openldap-clients.x86_64 openssh-ldap.x86_64 libtiff-devel libtiff librsvg2-devel librsvg2 perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker lrzsz mailx libzip libzip-devel
	yum -y update 
	yum -y upgrade 

	echo "alias vi=\"vim\"" >> ~/.bash_profile 
	source ~/.bash_profile 

	/usr/sbin/groupadd mosh 
	/usr/sbin/useradd -g mosh mosh
}

#安装PCRE正则扩展
Install_Pcre()
{
    Echo_Blue "[+] Installing pcre-8.10"
    cd /home/src/pcre-8.10 
	./configure --enable-utf8 --enable-pcregrep-libz --enable-pcregrep-libbz2 --enable-pcretest-libreadline 
	make && make install 
}

#安装libiconv编码转换扩展
Install_Libiconv()
{
    Echo_Blue "[+] Installing libiconv-1.13.1"
    cd /home/src/libiconv-1.13.1 
    ./configure --prefix=/usr/local/ 
	make && make install
	ln -sf /usr/local/lib/libiconv.so.2 /usr/lib/libiconv.so.2
	#先硬塞到这里吧~~
	ln -sf /usr/lib64/libjpeg.so.62.1.0 /usr/lib/libjpeg.so 
	ln -sf /usr/lib64/libpng /usr/lib/libpng.so 
	ln -sf lib64/libldap-2.4.so.2.10.2 /usr/lib/libldap.so 
}

#安装加密算法扩展库
Install_Libmcrypt()
{
    Echo_Blue "[+] Installing libmcrypt-2.5.8"
    cd /home/src/libmcrypt-2.5.8 
	./configure 
	make && make install 
	cd libltdl/ 
	./configure --enable-ltdl-install 
	make && make install 
	ln -sf /usr/local/lib/libmcrypt.la /usr/lib/libmcrypt.la
    ln -sf /usr/local/lib/libmcrypt.so /usr/lib/libmcrypt.so
    ln -sf /usr/local/lib/libmcrypt.so.4 /usr/lib/libmcrypt.so.4
    ln -sf /usr/local/lib/libmcrypt.so.4.4.8 /usr/lib/libmcrypt.so.4.4.8
    ln -sf /usr/local/bin/libmcrypt-config /usr/bin/libmcrypt-config 
}

##安装加密算法扩展库,依赖libmcrypt,mhash
Install_Mcrypt()
{
    Echo_Blue "[+] Installing mcrypt-2.6.8"
    cd /home/src/mcrypt-2.6.8
    /sbin/ldconfig 
    ./configure
    make && make install
}

#安装Mhash扩展
Install_Mhash()
{
    Echo_Blue "[+] Installing mhash-0.9.9.9"
    cd /home/src/mhash-0.9.9.9  
    ./configure
    make && make install
    ln -sf /usr/local/lib/libmhash.a /usr/lib/libmhash.a
    ln -sf /usr/local/lib/libmhash.la /usr/lib/libmhash.la
    ln -sf /usr/local/lib/libmhash.so /usr/lib/libmhash.so
    ln -sf /usr/local/lib/libmhash.so.2 /usr/lib/libmhash.so.2
    ln -sf /usr/local/lib/libmhash.so.2.0.1 /usr/lib/libmhash.so.2.0.1
}

#安装PHP
Install_PHP()
{
	Echo_Blue "[+] Installing php-5.6.15"
	cd /home/src/php-5.6.15
	./configure --prefix=/home/pubsrv/php-5.6.15 --with-config-file-path=/home/pubsrv/php-5.6.15/etc --with-mysql=/home/pubsrv/mysql --with-mysqli=/home/pubsrv/mysql/bin/mysql_config --with-iconv-dir=/usr/local --with-freetype-dir --with-jpeg-dir=/usr/lib --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --enable-mbregex --enable-fpm --enable-mbstring --with-mcrypt --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-ldap --with-ldap-sasl --with-xmlrpc --enable-zip --enable-soap --enable-opcache --with-libdir=lib64 --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd


	make ZEND_EXTRA_LIBS='-liconv' 

	make install 
	cp php.ini-production /home/pubsrv/php-5.6.15/etc/php.ini 
	cp /home/pubsrv/php-5.6.15/etc/php-fpm.conf.default   /home/pubsrv/php-5.6.15/etc/php-fpm.conf

	echo "zend_extension=opcache.so" >> /home/pubsrv/php-5.6.15/etc/php.ini 
	#sed -i "s/;opcache.enable=0/opcache.enable=1/g" sed -i "s/;opcache.enable=0/opcache.enable=1/g”  #没有那个文件或目录
	sed -i "s/extension_dir = \"\"/extension_dir = \"\/home\/pubsrv\/php\/lib\/php\/extensions\/no-debug-non-zts-20060613\/\"/g" /home/pubsrv/php-5.6.15/etc/php.ini 
}

#安装MySQL
Install_MySQL()
{
	Echo_Blue "[+] Installing mysql-5.6.28"
	groupadd mysql 
	useradd -M -s /sbin/nologin mysql
	cd /home/src/mysql-5.6.28 

	#配置编译安装
	cmake . -DCMAKE_INSTALL_PREFIX=/home/pubsrv/mysql -DMYSQL_DATADIR=/data/mysql -DSYSCONFDIR=/etc -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DWITH_FEDERATED_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DMYSQL_UNIX_ADDR=/tmp/mysqld.sock -DMYSQL_TCP_PORT=3306 -DENABLED_LOCAL_INFILE=1 -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci

	# [编译参数说明]
	# -DCMAKE_INSTALL_PREFIX=/home/pubsrv/mysql \  		 #安装路径
	# -DMYSQL_DATADIR=/data/mysql \    	 	 			 #数据文件存放位置
	# -DSYSCONFDIR=/etc \                     			 #my.cnf路径
	# -DWITH_INNOBASE_STORAGE_ENGINE=1 \     		     #支持InnoDB引擎
	# -DWITH_MYISAM_STORAGE_ENGINE=1 \       			 #支持MyIASM引擎
	# -DWITH_PARTITION_STORAGE_ENGINE=1 \   			 #安装支持数据库分区
	# -DWITH_FEDERATED_STORAGE_ENGINE=1 \			     #支持frderated引擎
	# -DWITH_BLACKHOLE_STORAGE_ENGINE=1 \				 #支持blackhole引擎
	# -DWITH_MEMORY_STORAGE_ENGINE=1 \        			 #支持Memory引擎
	# -DWITH_READLINE=1 \               				 #快捷键功能
	# -DMYSQL_UNIX_ADDR=/tmp/mysqld.sock \   		 	 #连接数据库socket路径
	# -DMYSQL_TCP_PORT=3306 \             				 #端口
	# -DENABLED_LOCAL_INFILE=1 \                		 #允许从本地导入数据
	# -DEXTRA_CHARSETS=all \              				 #安装所有的字符集
	# -DDEFAULT_CHARSET=utf8 \                			 #默认字符
	# -DDEFAULT_COLLATION=utf8_general_ci

	make && make install 

	#改变目录权限
	chown mysql.mysql -R /home/pubsrv/mysql
	chown mysql.mysql -R /data/mysql

	cd /home/pubsrv/mysql/scripts
	./mysql_install_db --user=mysql --basedir=/home/pubsrv/mysql --datadir=/data/mysql #初始化数据库

	cd /home/pubsrv/mysql/support-files
	cp mysql.server /etc/init.d/mysqld #复制启动脚本
	chmod +x /etc/init.d/mysqld
	cp my-default.cnf /etc/my.cnf #复制配置文件 

	#将mysql的启动服务添加到系统服务中
	chkconfig --add mysqld #添加系统服务
	chkconfig mysqld on   #添加开机启动
	chkconfig --levels 245 mysqld off

	export PATH=$PATH:/home/pubsrv/mysql/bin    #添加环境变量 
	echo 'PATH=$PATH:/home/pubsrv/mysql/bin' >> /etc/profile 

	#启动mysql
	service mysql start 

	#设置密码
	/home/pubsrv/mysql/bin/mysqladmin -u root password 'ilovechina' #这里可以加入配置文件

	#设置密码方法:
	#1. 启动Mysql
	#2. 执行: /home/pubsrv/mysql/bin/mysqladmin -u root password 'new-password'
	#        /home/pubsrv/mysql/bin/mysqladmin -u root -h moshtest-1 password 'new-password'
	#   或者:
	#		 /home/pubsrv/mysql/bin/mysql_secure_installation

	#安全模式启动Mysql
	#/home/pubsrv/mysql/bin/mysqld_safe --user=mysql --datadir=/home/pubsrv/mysql/data/ &
	#/home/pubsrv/mysql/bin/mysqld_safe &

}

#安装图形处理扩展
Install_ImageMagick()
{
	Echo_Blue "[+] Installing ImageMagick"
	cd /home/src/ImageMagick-6.9.2-5/
	./configure --with-php-config=/home/pubsrv/php-5.6.15/bin/php-config 

	make ZEND_EXTRA_LIBS='-liconv'
	make install
}

#PHP调用ImageMagick功能的PHP扩展
Install_Imagick()
{
	Echo_Blue "[+] Installing imagick"
	cd /home/src/imagick-3.1.1 
	/home/pubsrv/php-5.6.15/bin/phpize 
	./configure --with-php-config=/home/pubsrv/php-5.6.15/bin/php-config 
	make && make install 
	echo "extension=imagick.so">>/home/pubsrv/php-5.6.15/etc/php.ini 

	sed -i "s/extension_dir = \"\"/extension_dir = \"\/home\/pubsrv\/php\/lib\/php\/extensions\/no-debug-non-zts-20060613\/\"/g" /home/pubsrv/php-5.6.15/etc/php.ini
}

#安装Libmemcached扩展
Install_Libmemcached()
{
	Echo_Blue "[+] Installing libmemcached"
	cd /home/src/libmemcached-1.0.9
	./configure --with-memcached --prefix=/usr/local/libmemcached
	make && make install
}

#安装Memcached扩展, 基于Libmemcached
Install_Memcached()
{
	Echo_Blue "[+] Installing Memcached"
	cd /home/src/memcached-2.2.0
	/home/pubsrv/php-5.6.15/bin/phpize
	./configure --enable-memcached --with-php-config=/home/pubsrv/php-5.6.15/bin/php-config --with-libmemcached-dir=/usr/local/libmemcached/  --disable-memcached-sasl
	make && make install
	echo "extension=memcached.so">>/home/pubsrv/php-5.6.15/etc/php.ini 
}

Install_Raphf()
{
	Echo_Blue "[+] Installing raphf"
	cd /home/src/raphf-1.0.2 
	/home/pubsrv/php-5.6.15/bin/phpize 
	./configure --with-php-config=/home/pubsrv/php-5.6.15/bin/php-config 
	make && make install 
	echo "extension=raphf.so">>/home/pubsrv/php-5.6.15/etc/php.ini 

}

#pecl_http-2.1.2 的依赖包
Install_Propro()
{	
	Echo_Blue "[+] Installing propro"
	cd /home/src/propro-1.0.0 
	/home/pubsrv/php-5.6.15/bin/phpize 
	./configure --with-php-config=/home/pubsrv/php-5.6.15/bin/php-config 
	make && make install 
	echo "extension=propro.so">>/home/pubsrv/php-5.6.15/etc/php.ini
}

Install_Curl()
{
	Echo_Blue "[+] Installing propro"
	cd /home/src/curl-7.38.0
	./configure 
	make && make install 
	mv /usr/bin/curl /usr/bin/curl.bak 
	ln -s /usr/local/bin/curl /usr/bin/curl
}

 Install_Pecl_http()
 {
 	Echo_Blue "[+] Installing pecl_http"
 	cd /home/src/pecl_http-2.1.2 
	/home/pubsrv/php-5.6.15/bin/phpize 
	./configure --with-php-config=/home/pubsrv/php-5.6.15/bin/php-config 
	make && make install 
	echo "extension=http.so">>/home/pubsrv/php-5.6.15/etc/php.ini
 }

 Install_Tengine()
 {
 	Echo_Blue "[+] Installing tengine"
 	cd /home/src/tengine-2.1.1/
	./configure --user=mosh --group=mosh --prefix=/home/pubsrv/nginx --with-http_stub_status_module --with-http_ssl_module 
	make && make install 

	cat >>/home/pubsrv/nginx/nginxctl<<eof
#!/bin/sh

BIN=/home/pubsrv/nginx/sbin/nginx;
PID=/home/pubsrv/nginx/logs/nginx.pid;
CNF=/home/pubsrv/nginx/conf/nginx.conf;
ulimit -SHn 10240
case $1 in
        start)
                $BIN -c $CNF
                exit $?;
                ;;
        stop)
                kill $(cat $PID);
                exit $?;
                ;;
        reload)
                kill -HUP $(cat $PID);
                exit $?;
                ;;
        rotate)
                kill -USR1 $(cat $PID);
                exit $?;
                ;;
        port)
                echo "Your port is 80";
                ;;
        *)
                echo "Usage: $0 {start|stop|reload|roate|port}";
                exit 1;
esac
eof

	chmod +x /home/pubsrv/nginx/nginxctl
 }
 

Install_Mongo()
{
	Echo_Blue "[+] Installing mongo"
 	cd /home/src/mongo-1.6.10

	/home/pubsrv/php-5.6.15/bin/phpize   
	./configure  --with-php-config=/home/pubsrv/php-5.6.15/bin/php-config 
	make && make install
	 
	echo extension=mongo.so >> /home/pubsrv/php-5.6.15/etc/php.ini
}

Install_Swoole()
{
	Echo_Blue "[+] Installing Swoole"
	cd /home/src/swoole-src-swoole-1.7.20-stable/
	/home/pubsrv/php-5.6.15/bin/phpize
	./configure  --with-php-config=/home/pubsrv/php-5.6.15/bin/php-config
	make && make install
	echo "extension=swoole.so">>/home/pubsrv/php-5.6.15/etc/php.ini
}

Install_Yaf()
{
	Echo_Blue "[+] Installing Yaf" 
	cd /home/src/yaf-2.3.5/
	/home/pubsrv/php-5.6.15/bin/phpize
	./configure --with-php-config=/home/pubsrv/php-5.6.15/bin/php-config 
	make && make install
	cat >>/home/pubsrv/php-5.6.15/etc/php.ini<<eof
extension=yaf.so
yaf.environ = product
yaf.library = NULL
yaf.cache_config = 0
yaf.name_suffix = 1
yaf.name_separator = ""
yaf.forward_limit = 5
yaf.use_namespace = 1
yaf.use_spl_autoload = 0
eof
}

#安装Git
Install_Git()
{
	Echo_Blue "[+] Installing Git"
	yum install git #CentOS
	#Ubuntu: apt-get install
	#Git初始化配置, 从配置文件中获取
	
}

#安装ZSH+On My Zsh
Install_Zsh()
{
	Echo_Blue "[+] Installing Zsh"
	yum install zsh
	chsh -s /bin/zsh #提示输入密码
	wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
	#oh my zsh 配置
}














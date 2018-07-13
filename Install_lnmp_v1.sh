#!/bin/bash


#################### 
#author:lishuo     #
#date:2018/7/11    #
#version:v3        #
####################



echo -e "\033[32m 安装nginx请输入1：\033[0m"
echo -e "\033[32m 安装php请输入2：\033[0m"
echo -e "\033[32m 安装mysql请输入3：\033[0m"
echo -e "\033[32m 安装lnmp环境请输入4：\033[0m"
echo -e "\033[41;37m 安装前请再三确认系统中的mysql,nginx等做好迁移工作\033[0m "
#read -p "请输入1 | 2| 3| 4 :" INSTALL
#################################################################################
#输入版本号

#安装Nginx
NGINX(){
echo -e "\033[32m 请输入你喜欢的版本，比如nginx常用的版本|1.3.4|1.3.5|1.3.6| \033[0m"
read -p "请输入Nginx版本号:" version
echo -e "\033[32m 您下载的版本是：nginx-$version.tar.gz \033[0m"
ls nginx-$version.tar.gz 
if [ $? -eq 0 ];then
   echo "$version 已经下载"
else
URL="http://nginx.org/download/nginx-$version.tar.gz"
wget $URL

if [ $? -ne 0  ];then 
   echo "您输入的版本有错误，请检查。"
   echo "格式为 1.3.4 此类格式"
   echo "查看更多版本请访问 http://nginx.org/"
else 
   echo -e  "\033[32m 系统正在下载中，请稍后...... \033[0m"
fi
fi
#################################################################################
yum -y install gcc gcc-c++ openssl openssl-devel
   yum -y install pcre pcre-devel
   
#################################################################################
NGX="nginx-$version.tar.gz"
NGXDIR="nginx-$version"
 
#if [   -d  $NGXDIR ];then
#   echo "该文件以存在"
#else
   
tar -zxvf  $NGX 
cd $NGXDIR
while : 
do
read -p "请输入Nginx安装目录，默认为:/usr/local/nginx/  请输入：yes/no:" ngpath
case $ngpath in 
yes)
   echo -e "\033[32m plses watting Nginx is install...........\033[0m"
./configure --prefix=/usr/local/nginx   --with-http_stub_status_module --with-http_ssl_module
make &&make install 
   if [ $? -eq 0 ];then
        echo "Nginx 安装成功！"
        exit 0
     else
        echo "Nginx 安装失败，请检查"
   fi
   ;;
no)
   read -p "请以绝对路径方式输入Nginx安装目录；"  ngstall
   echo -e "\033[32m plese waitting Nginx is install..........\033[0m"
./configure --prefix=$ngstall   --with-http_stub_status_module --with-http_ssl_module
make &&make install
   if [ $? -eq 0 ];then 
	echo "Nginx 安装成功！"
     else
	echo "Nginx 安装失败，请检查"
   fi
   ;;
*)
   echo "请输入yes或者no"
esac
done
}


#安装php
PHP(){
echo -e "\033[32m ************Install  php********  \033[0m"
 VER=`cat /etc/redhat-release |awk '{print $3}'`
 VER7=7

 ping -c4 -w4 www.baidu.com 
 if [ $? -eq 0 ];then
    if [ `echo "$VER < $VER7"|bc`  -lt 7 ];then
 yum -y remove php-common 
 rpm -Uvh http://download.Fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
 rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
 yum clean && yum repolist 
 yum install --enablerepo=remi,remi-php56 php php-opcache php-pecl-apcu php-devel php-mbstring php-mcrypt php-mysqlnd php-phpunit-PHPUnit php-pecl-xdebug php-pecl-xhprof php-pdo php-pear php-fpm php-cli php-xml php-bcmath php-process php-gd php-common
 php -v
    else 
        rpm -Uvh http://ftp.iij.ad.jp/pub/linux/fedora/epel/7/x86_64/e/epel-release-7-5.noarch.rpm 
        rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
         yum clean && yum repolist 
         yum install --enablerepo=remi,remi-php56 php php-opcache php-pecl-apcu php-devel php-mbstring php-mcrypt php-mysqlnd php-phpunit-PHPUnit php-pecl-xdebug php-pecl-xhprof php-pdo php-pear php-fpm php-cli php-xml php-bcmath php-process php-gd php-common
    php -v
    /etc/init.d/php-fpm start 
    fi
 else 
	echo "请检查您的网络"
 fi
}



#安装mysql
###############################################################################################
MYSQL(){
 echo -e  "\033[32m 正在安装mysql \033[0m"
 myver="mysql-5.6.35.tar.gz"
 mydir="mysql-5.6.35"
 yum -y install  gcc gcc-c++ gcc-g77 autoconf automake zlib* fiex* libxml* ncurses-devel libmcrypt* libtool-ltdl-devel* make cmake
 id mysql 
 if [ $? -eq 0 ];then 
    echo "mysql 用户以存在"
 else
    groupadd -g 701 mysql
    useradd -M -g mysql -u 1101 -s /sbin/nologin  mysql 
 fi 
 [ -f $myver ] || wget https://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.35.tar.gz --no-check-certificate
 tar -zxvf $myver
 cd $mydir 
 while :
 do
 read -p " 请输入mysql安装目录,默认/usr/local/mysql,请输入yes或者no: " mypath
 case $mypath in 
yes)
  [  ! -d /usr/local/mysql ] && mkdir -p /usr/local/mysql
 cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/usr/local/mysql/data -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DMYSQL_UNIX_ADDR=/var/lib/mysql/mysql.sock -DMYSQL_TCP_PORT=3306 -DENABLED_LOCAL_INFILE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci
 make &&make install
 [ -d /var/lib/mysql ] || mkdir -p /var/lib/mysql
 chown -R mysql.mysql /usr/local/mysql
 chown -R mysql:mysql /var/lib/mysql
# echo 'export PATH=/usr/local/mysql/bin:$PATH' >>/etc/profile
  echo 'PATH=/usr/local/mysql/bin:/usr/local/mysql/lib:$PATH'>>/etc/profile
  echo "export PATH" >>/etc/profile 
  source /etc/profile
 cat > /etc/my.cnf << EOF

[mysqld]
datadir=/usr/local/mysql/data
socket=/var/lib/mysql/mysql.sock
user=mysql
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0

[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/var/lib/mysql.pid
~                                                                               
~                              



EOF
 #sed -i  "4 adatadir =/usr/local/mysql/data" >> /etc/my.cnf
 #echo "lower_case_table_names=1">>/etc/my.cnf
 #sed -i  "5 asocket=/var/lib/mysql/mysql.sock" >> /etc/my.cnf
 /usr/local/mysql/scripts/mysql_install_db --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data 
 
 #注册服务
 cp  /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld
 
 #让chkconfig管理mysql服务
 chkconfig --add mysql
 #开机启动
 chkconfig mysqld on  
 service mysqld start
 /usr/local/mysql/bin/mysql_secure_installation 
 
;;


no)
  read -p "请以绝对路径方式输入mysql安装路径：" myinstall
  mkdir -p $myinstall
  echo "mysql 正在安装中，路径为$myinstall"    

 cmake -DCMAKE_INSTALL_PREFIX=$myinstall -DMYSQL_DATADIR=$myinstall/data -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DMYSQL_UNIX_ADDR=/var/lib/mysql/mysql.sock -DMYSQL_TCP_PORT=3306 -DENABLED_LOCAL_INFILE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci
 
make && make install 
 chown -R mysql.mysql $myinstall
  [ -d /var/lib/mysql ] || mkdir -p /var/lib/mysql
  chown -R mysql:mysql /var/lib/mysql
  echo 'PATH=`$myinstall`/bin:`$myinstall`/lib:$PATH'>>/etc/profile
  echo "export PATH" >>/etc/profile       
  source /etc/profile
   cat > /etc/my.cnf << EOF

[mysqld]
datadir=$myinstall/data
socket=/var/lib/mysql/mysql.sock
user=mysql
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0

[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/var/lib/mysql.pid
~                                                                               
~                              



EOF
 #sed -i  "4 adatadir =$myinstall/data" >> /etc/my.cnf
 #echo "lower_case_table_names=1">>/etc/my.cnf
 # sed -i  "5 asocket=/var/lib/mysql/mysql.sock" >> /etc/my.cnf
 $myinstall/scripts/mysql_install_db --user=mysql --basedir=$myinstall --datadir=$myinstall/data 
 
# echo "datadir =$myinstall/data" >> /etc/my.cnf
# echo "lower_case_table_names=1">>/etc/my.cnf
# echo "socket=/var/lib/mysql/mysql.sock" >> /etc/my.cnf
 
 #注册服务
 cp $myinstall/support-files/mysql.server /etc/init.d/mysqld
 #让chkconfig管理mysql服务
 chkconfig --add mysqld
 #开机启动
 chkconfig mysqld on
 service mysqld start
 $myinstall/bin/mysql_secure_installation  
    
 ;;

*)
 echo "请输入yes或者no"
esac
break 
done

}







read -p "请输入 1  2  3  4 :" INSTALL
case $INSTALL in 
1)
NGINX

 ;;

2)
PHP
 ;;
3)
MYSQL
 ;;
4)
 echo "LNMP 环境"
if [ ! -d /usr/local/nginx ] && [ ! -d $ngstall ];then
NGINX
else 
echo "nginx 已经安装"
fi
if [ ! -f /usr/bin/php  ];then
PHP
else
 read -p "php已经安装，确认继续安装php5.6吗,y/n:" $inphp
 case $inphp in 
y)
PHP
;;
n)
echo -e "\033[32m 以取消安装 033[0m"
;;
*)
echo -e "\033[32m 请输入y/n 033[0m"

esac

fi

MYSQL
 ;;
*)
 echo "plses input 1 2 3 4 "
 ;;
esac

#case $1 in 

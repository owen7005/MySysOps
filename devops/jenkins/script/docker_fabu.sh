#!/bin/bash
#########################################################################
# File Name: ff.sh
# Author: www.linuxea.com
# Email: usertzc@gmail.com
# Version:
# Created Time: 2016年12月31日 星期六 13时40分14秒
#########################################################################
hostport=10.0.1.49:5000
dfile=/wwwroot/docker
wwwname=web
www=/wwwroot/docker_test
cd $www && sudo git pull
ghead=`git reflog |grep "pull: Fast-forward"|head -1|awk '{print $1}'`
lhead=`git reflog |grep "pull: Fast-forward"|head -2|awk END'{print $1}'`
sudo cp -r $dfile/Dockerfile $www && cd $www
if [ $# == 1 ];then
	bbh=`echo $1`
#	ansible php -a "docker rmi -f $hostport/nginx_$lhead"
	ansible php -a "docker rm -f $wwwname"
	ansible php -a "docker pull $hostport/nginx_$bbh"
	ansible php -a "docker run --name $wwwname --net=host -v /data/logs/nginx:/data/logs/nginx -d $hostport/nginx_$bbh"
	sudo rm -rf $www/Dockerfile
else
	if [ `sudo docker images|grep $ghead|wc -l` = 0 ];then
		sudo docker build -t $hostport/nginx_$ghead .
		sudo docker push $hostport/nginx_$ghead
		ansible php -a "docker rmi -f $hostport/nginx_$lhead"
		ansible php -a "docker rm -f $wwwname"
		ansible php -a "docker pull $hostport/nginx_$ghead"
		ansible php -a "docker run --name $wwwname --net=host -v /data/logs/nginx:/data/logs/nginx -d $hostport/nginx_$ghead"
		sudo rm -rf $www/Dockerfile
	else
		echo '没有更新'
	fi
fi

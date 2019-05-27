#!/bin/bash
#########################################################################
# File Name: install.sh
# Author: www.linuxea.com
# Created Time: 2019年05月27日 星期一 11时23分51秒
#########################################################################
echo "Usage: $0 centos_install | debian_install | ubuntu_install "
docker_compose_install(){
	curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose
	ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
}
if [ `type docker |grep /usr/bin/docker|wc -l` = 1 ];then
	echo "docker-compose 已经安装"
	exit 1
else		
	docker_compose_install
fi
if [[ $# == 1 ]]; then
	case $1 in
	centos_install)
		if [ `type docker |grep /usr/bin/docker|wc -l` = 1 ];then
			echo "docker 已经安装"
			exit 1
		else		
			yum install -y yum-utils \
			device-mapper-persistent-data \
			lvm2
			yum-config-manager \
				--add-repo \
				https://download.docker.com/linux/centos/docker-ce.repo
			yum install docker-ce docker-ce-cli containerd.io  -y
		fi
	;;
	debian_install)
		if [ `type docker |grep /usr/bin/docker|wc -l` = 1 ];then
			echo "docker 已经安装"
			exit 1
		else
			apt-get update
			apt-get install \
				apt-transport-https \
				ca-certificates \
				curl \
				gnupg2 \
				software-properties-common -y
			add-apt-repository \
			"deb [arch=amd64] https://download.docker.com/linux/debian \
			$(lsb_release -cs) \
			stable"    
			curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -    
			apt-get install docker-ce docker-ce-cli containerd.io -y
		fi
	;;
	ubuntu_install)
		if [ `type docker |grep /usr/bin/docker|wc -l` = 1 ];then
			echo "docker 已经安装"
			exit 1
		else	
			apt-get update
			apt-get -y install \
				apt-transport-https \
				ca-certificates \
				curl \
				gnupg-agent \
				software-properties-common
			curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -    
			apt-get update
			add-apt-repository \
			"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
			$(lsb_release -cs) \
			stable"
			apt-get -y install docker-ce docker-ce-cli containerd.io
		fi
	;;
	*)
  echo "Usage: $0{centos_install|debian_install|ubuntu_install}" && exit9
  ;;
esac
fi
docker-compose --version
docker --version

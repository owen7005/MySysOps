#!/bin/bash
	docker_install() {
		if [ `type docker |grep /usr/bin/docker|wc -l` = 1 ];then 
			yum remove -y docker \
						docker-client \
						docker-client-latest \
						docker-common \
						docker-latest \
						docker-latest-logrotate \
						docker-logrotate \
						docker-engine
			yum install -y yum-utils \
				device-mapper-persistent-data \
				lvm2		
			yum-config-manager \
				--add-repo \
				https://download.docker.com/linux/centos/docker-ce.repo	  
			yum install docker-ce docker-ce-cli containerd.io -y
			systemctl start docker
			systemctl enable docker
		else 
			yum install -y yum-utils \
				device-mapper-persistent-data \
				lvm2		
			yum-config-manager \
				--add-repo \
				https://download.docker.com/linux/centos/docker-ce.repo	  
			yum install docker-ce docker-ce-cli containerd.io -y;
			systemctl start docker
			systemctl enable docker
		fi
	}
	docker_compose_install(){
		curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
		chmod +x /usr/local/bin/docker-compose
		ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
	}
docker_install
docker_compose_install
docker-compose --version
docker --version

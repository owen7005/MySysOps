pipeline {
	agent any
	environment { 
	def ITEMNAME2 = "linuxea" 
	def DESTPATH = "/data/tomcat/linuxea"
	}
	stages {	
		stage('网络检查') {
			steps {
				echo "检查连通性"
				script{
					try {
						sh 'ansible ${ITEMNAME2} -m ping'		
					} catch (e) {
					currentBuild.result = 'FAILURE'
					throw e
					}}}}
//		stage('拉取最新代码') {
//		    steps {
//			echo "git pull"
//				script {
//					sh "ansible ${ITEMNAME2} -m shell -a 'cd $DESTPATH && git pull'"
//						}
//					}
//				}
		stage('拉取最新代码') {
			steps {
				script {		
					try {
						sh "ansible ${ITEMNAME2} -m shell -a 'cd $DESTPATH && git pull'"	
					} catch (e) {
					currentBuild.result = 'FAILURE'
					throw e
					}}}}
		stage('重新启动') {
			steps {
				script {
					try {
						sh '''
							ansible ${ITEMNAME2} -m shell -a 'docker-compose -f /data/docker-compose.yaml down'
							ansible ${ITEMNAME2} -m shell -a 'docker-compose -f /data/docker-compose.yaml up -d'
						'''		
					} catch (e) {
					currentBuild.result = 'FAILURE'
					throw e
					}}}}
		}	
	}

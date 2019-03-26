pipeline {
	agent any
//	parameters { string(defaultValue: '', name: 'GIT_TAG', description: '请根据发布类型进行选择发布：\n1，输入->background<-更新后台\n2，输入->ag_background<-更新ag后台' ) }
	environment { 
	def ITEMNAME2 = "pt-ptapi-seluth-zipki" 
	def CONTAINER_NAME = "dt-api-seluth-zipkin"
	def DESTPATH = "/data/dt-api-seluth-zipkin"
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
		stage('30秒后检查') {
			steps {
				script {
				    sleep 30				
					try {
						sh '''
							ansible ${ITEMNAME2} -m shell -a "docker ps|grep ${CONTAINER_NAME}"
						'''		
					} catch (e) {
					currentBuild.result = 'FAILURE'
					throw e
					}}}}							
		}	
	}

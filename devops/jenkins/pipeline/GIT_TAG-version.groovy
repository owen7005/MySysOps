pipeline {
	agent any
	parameters { string(defaultValue: '', name: 'GIT_TAG', description: '请直接输入版本号:' ) }
	environment { 
	def ITEMNAME2 = "gfc-www" 
	def DESTPATH = "/data/wwwroot/gfc-new/"
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
						sh '''
							if [ ! -n "$GIT_TAG" ];then
								echo "请输入版本号"
								exit 1
							else
								ansible  ${ITEMNAME2} -m shell -a "cd $DESTPATH && git pull origin master && git checkout $GIT_TAG"
			                    ansible  ${ITEMNAME2} -m shell -a "chown -R 400.400 $DESTPATH"
							fi
						'''
							
					} catch (e) {
					currentBuild.result = 'FAILURE'
					throw e
					}}}}						
		}	
	}
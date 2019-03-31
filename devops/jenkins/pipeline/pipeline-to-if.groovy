pipeline {
	agent any
	parameters { string(defaultValue: '', name: 'GIT_TAG', description: '请根据发布类型进行选择发布：\n1，输入->linuxea<-更新后台\n2，输入->linuxeaftp<-更新ag后台' ) }
	environment { 
	def ITEMNAME2 = "com" 
	def DESTPATH = "/data/wwwroot/linuxea/"
	def DESTPATH2 = "/data/wwwroot/linuxeaftp/"
	}
	stages {	
		stage('网络检查') {
			steps {
				echo "检查连通性"
				script{
					def resultUpdateshell = sh script: 'ansible ${ITEMNAME2} -m ping'				
					if (resultUpdateshell == 0) {
						skip = '0'
						return
					}
					}
					}
					}
									
		stage('拉取最新代码') {
		    steps {
			echo "git pull"
				script {
					if (env.GIT_TAG == 'linuxea') {
						echo 'linuxea'
							sh "ansible ${ITEMNAME2} -m shell -a 'cd $DESTPATH && git pull'"
						} else {
						if (env.GIT_TAG == 'linuxeaftp') {
							echo 'linuxeaftp'
							sh "ansible ${ITEMNAME2} -m shell -a 'cd $DESTPATH2 && git pull'"						
							}
							}
						}
					}
				}
		}
	}

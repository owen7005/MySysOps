pipeline {
    agent  any
	parameters {
		string(name: 'DEPLOY_ENV', defaultValue: 'TESTING', description: 'The target environment' )
	}
	stages {
		stage ("show") {
			steps {	echo "${DEPLOY_ENV}"	}
			}
			}
		}
======================
pipeline {
    agent any
	parameters {
		string(name: 'DEPLOY_ENV', defaultValue: 'TESTING', description: '1，TESTING\n2，LATEST\n3，ROLLBACK', )
	}
	stages {
		stage ("TESTING") {
			steps {
				script {
					if (env.DEPLOY_ENV == 'TESTING') {
						echo 'TESTING'
						sh 'ansible webapp -m shell -a "ps aux|grep nginx|grep -v grep"'						
					} 
				}
			}
			}
		stage ("LATEST") {
			steps {
				script {
					if (env.DEPLOY_ENV == 'LATEST') {
						echo 'LATEST'
						sh 'ansible webapp -m shell -a "ps aux|grep nginx|grep -v grep"'						
					} 
				}
			}
			}
		stage ("ROLLBACK") {
			steps {
				script {
					if (env.DEPLOY_ENV == 'ROLLBACK') {
						echo 'ROLLBACK'
						sh 'ansible webapp -m shell -a "ps aux|grep nginx|grep -v grep"'						
					} 
				}
			}
			}
			}				
		}
		
	


==============================

pipeline {
    agent any
	parameters {
		string(name: 'DEPLOY_ENV', defaultValue: 'TESTING', description: '1，TESTING\n2，LATEST\n3，ROLLBACK', )
	}
	stages {
		stage ("TESTING") {
			steps {
				script {
					if (env.DEPLOY_ENV == 'TESTING') {
						echo 'TESTING'
						sh 'ansible webapp -m shell -a "ps aux|grep nginx|grep -v grep"'	
						} else {
						if (env.DEPLOY_ENV == 'LATEST') {
							echo 'LATEST'
							sh 'ansible webapp -m shell -a "ps aux|grep nginx|grep -v grep"'						
						} else { 
						echo "4" 
						echo "${DEPLOY_ENV}"
						}
						}		
						}
						}	
						}
						}
						}
================================================

pipeline {
    agent any
	parameters { string(defaultValue: '', description: '', name: 'GIT_TAG') }
	stages {	
		stage('代码推送') {
			steps {
				script {
					if (env.GIT_TAG == 'TESTING') {
						echo 'TESTING'
						sh 'ansible webapp -m shell -a "ps aux|grep nginx|grep -v grep"'	
						} else {
						if (env.GIT_TAG == 'LATEST') {
							echo 'LATEST'
							sh 'ansible webapp -m shell -a "ps aux|grep nginx|grep -v grep"'						
						} else { 
						echo "" 
						echo "${GIT_TAG}"
						}
						}		
						}
						}	
    	}
		}
		}
===========================================	
node {
    stage ("para") {
       properties([gitLabConnection(''), parameters([string(defaultValue: '', description: '', name: 'GIT_TAG')]), pipelineTriggers([])])
    }
    stage ("show") {
       echo "${GIT_TAG}"
    }
}
===============================================

node {
    stage ("para") {
       properties([gitLabConnection(''), parameters([string(defaultValue: '', description: '', name: 'GIT_TAG')]), pipelineTriggers([])])
    }
    if ( env.GIT_TAG == '0' ) {
        echo "0"
		stage('代码推送') {
			script {
				    echo "code sync"
		               }
    	   }		
    } else {
        echo "${GIT_TAG}"
    }
}

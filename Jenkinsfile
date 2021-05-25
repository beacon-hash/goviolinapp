pipeline {
    agent any
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'golang'
                }
            }
            steps {
                sh "cd ${GOPATH}/src/"
                sh "mkdir -p ${GOPATH}/src/goviolinapp"
                sh "cp -r ${WORKSPACE}/src/* ${GOPATH}/src/goviolinapp"
                sh "cd ${GOPATH}/src/goviolinapp"
                sh "go mod init && go build"
            }
        }
    }
}
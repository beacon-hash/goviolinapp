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
                sh 'cd ${GOPATH}/src/'
                sh 'mkdir -p ${GOPATH}/src/goviolinapp'
                sh 'cp -r ${WORKSPACE}/src/* ${GOPATH}/src/goviolinapp'
                sh 'cd ${GOPATH}/src/goviolinapp'
                sh 'go mod init main.go'
                sh 'go build'
            }
        }

        stage('Publish') {
            environment {
                registryCredential= 'dockerHub'
            }
            steps {
                script {
                    def appimage = docker.build registry + ":$BUILD_NUMBER"
                    docker.withRegistry('', registryCredential) {
                        appimage.push()
                        appimage.push('latest')
                    }
                }
            }
        }
    }
}
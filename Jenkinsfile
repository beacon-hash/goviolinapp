pipeline {
    environment {
        registry = "kerracan/instabugapps"
    }
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
                sh 'cp -r ${WORKSPACE}/* ${GOPATH}/src/goviolinapp'
                sh 'go build -o violin'
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

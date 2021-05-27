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

        stage('Deploy') {
            steps {
                withKubeConfig([
                    credentialsID: 'jenkins-admin',
                    serverUrl: 'https://192.168.49.2:8443',
                    contextName: 'minikube',
                    clusterName: 'minikube',
                    namespace: 'default'
                ]) {
                    sh 'kubectl apply -f ${WORKSPACE}/k8sDeployment.yml'
                }
            }
        }
    }
}

pipeline {
    agent any

    stage('Checkout') {
        
        steps {
            git "https://github.com/Ashot2001/testing_jenkins.git"
        }
    }

    stage('Build Docker Image') {
        
        steps {
            
            script {
            dockerImage = docker.build("my-nodejs-app")
            
            }
        }
    }

    stage('Test') {
        
        steps {
            script {
                dockerImage.isnide {
                    sh 'npm test'
                }
            }
        }
    }
}
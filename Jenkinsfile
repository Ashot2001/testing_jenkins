pipeline {
    agent { label 'node_agent' }

    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
        IMAGE_NAME = 'ashot001/my-nodejs-app:latest'  // Убедитесь, что это имя правильное
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Ashot2001/testing_jenkins.git'
            }
        }

        stage('Build and Test Docker Image') {
            steps {
                script {
                    dockerImage = docker.build(IMAGE_NAME)
                }
            }
        }

        stage('Publish Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    }
                    sh "docker push ${IMAGE_NAME}"  // Убедитесь, что переменная IMAGE_NAME используется здесь
                }
            }
        }
    }

    post {
        always {
            cleanWs()
            sh "docker logout"
        }
    }
}

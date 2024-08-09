pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
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
                    // Сборка и тестирование в одном шаге
                    dockerImage = docker.build('ashot001/my-nodejs-app')
                }
            }
        }

        stage('Publish Docker Image') {
            steps {
                script {
                    // Логин в Docker Hub и публикация образа
                    docker.withRegistry('https://index.docker.io/v2/', DOCKER_CREDENTIALS_ID) {
                        dockerImage.push('latest')
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}

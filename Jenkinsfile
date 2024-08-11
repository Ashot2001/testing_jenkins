pipeline {
    agent {label 'node_agent'}

    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
        IMAGE_NAME = 'ashot001/my-nodejs-app'
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
                    dockerImage = docker.build(IMAGE_NAME)
                    echo "Docker Image Built: ${dockerImage.id}"
                }
            }
        }

        stage('Publish Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                        echo "Logged into Docker Hub successfully"
                    }
                    // Публикация образа
                    docker.withRegistry('https://index.docker.io/v2/', DOCKER_CREDENTIALS_ID) {
                        dockerImage.push('latest')
                    }
                    echo "Docker Image Pushed: ${IMAGE_NAME}:latest"
                }
            }
        }
    }

    post {
        always {
            // Очистка рабочего пространства
            cleanWs()
            // Логаут из Docker Hub, если это необходимо
            sh "docker logout"
            echo "Workspace cleaned and logged out from Docker Hub"
        }
    }
}

pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'  // Убедитесь, что вы добавили свои Docker учетные данные в Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                // Клонируем репозиторий
               git branch: 'main', url: 'https://github.com/Ashot2001/testing_jenkins.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Построение Docker образа
                    dockerImage = docker.build('ashot001/my-nodejs-app')
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Запуск тестов внутри Docker контейнера
                    dockerImage.inside {
                        sh 'npm test'
                    }
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
            // Очистка рабочей директории
            cleanWs()
        }
    }
}

pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Retrieve .env files') {
            steps {
                sh 'cp /srv/aio-tools/secure_ressources_relationnelles/.env .env'
                sh 'cp /srv/aio-tools/secure_ressources_relationnelles/backend/.env backend/.env'
                sh 'cp /srv/aio-tools/secure_ressources_relationnelles/frontend/.env frontend/.env'
                sh 'sudo chmod 644 backend/.env'
            }
        }
        stage('Build Docker Containers') {
            steps {
                sh 'docker-compose up -d --build'
            }
        }
        stage('Run Backend Tests') {
            steps {
                // Tests PHPUnit
                dir('backend') {
                    sh 'docker-compose exec -T backend php artisan test'
                }
            }
        }
        stage('Run Frontend Tests') {
            steps {
                // Tests Cypress
                dir('frontend') {
                    sh 'docker-compose exec -T frontend npx cypress run'
                }
            }
        }
    }

    post {
        success {
            echo 'Build and tests succeeded!'
        }
        failure {
            echo 'Build or tests failed.'
        }
        always {
            sh 'docker-compose down'
        }
    }
}
pipeline {
    agent any
    environment {
        DB_PORT = '3307'
        FRONTEND_PORT = '3001'
        BACKEND_PORT = '8077'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Modify docker-compose.yml') {
            steps {
                sh '''
                    sed -i "s/3306:3306/$DB_PORT:3306/" docker-compose.yml
                    sed -i "s/3000:3000/$FRONTEND_PORT:3000/" docker-compose.yml
                    sed -i "s/8081:80/$BACKEND_PORT:80/" docker-compose.yml
                '''
            }
        }

        stage('Retrieve .env files') {
            steps {
                sh 'cp /srv/aio-tools/secure_ressources_relationnelles/.env .env'
                sh 'cp /srv/aio-tools/secure_ressources_relationnelles/backend/.env backend/.env'
                sh 'cp /srv/aio-tools/secure_ressources_relationnelles/frontend/.env frontend/.env'
                sh 'chmod 644 backend/.env'
                // Modifier le fichier .env du backend pour utiliser le nouveau port
                sh 'sed -i "s/DB_PORT=.*/DB_PORT=$DB_PORT/" backend/.env'
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
                    sh 'docker-compose exec -T laravel php artisan test'
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

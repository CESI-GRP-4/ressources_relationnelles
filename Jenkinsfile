pipeline {
    agent any
    environment {
        DB_PORT = '3307'  // Nouvelle variable d'environnement pour le port DB
        FRONTEND_PORT = '3001'  // Nouvelle variable d'environnement pour le port Frontend
        BACKEND_PORT = '8077'  // Nouvelle variable d'environnement pour le port Backend
        NGINX_HTTP_PORT = '8099'  // Nouvelle variable d'environnement pour le port HTTP de Nginx
        NGINX_HTTPS_PORT = '8443'  // Nouvelle variable d'environnement pour le port HTTPS de Nginx
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
                    sed -i "s/80:80/$NGINX_HTTP_PORT:80/" docker-compose.yml
                    sed -i "s/443:443/$NGINX_HTTPS_PORT:443/" docker-compose.yml
                    sed -i "s|/srv/aio-tools/data_ressources_relationnelles/:/var/lib/mysql|/srv/aio-tools/test_data_ressources_relationnelles/:/var/lib/mysql|" docker-compose.yml
                '''
            }
        }

        stage('Retrieve .env files') {
            steps {
                sh 'sudo cp /srv/aio-tools/secure_ressources_relationnelles/.env .env'
                sh 'sudo cp /srv/aio-tools/secure_ressources_relationnelles/backend/.env backend/.env'
                sh 'sudo cp /srv/aio-tools/secure_ressources_relationnelles/frontend/.env frontend/.env'
                sh 'sudo chmod 644 backend/.env'
            }
        }

        stage('Build Docker Containers') {
            steps {
                sh 'docker-compose up -d --build'
            }
        }

        stage('Install Cypress') {
            steps {
                dir('frontend') {
                    sh 'docker-compose exec -T frontend npx cypress install'
                }
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

        stage('Pause for Verification') {
            steps {
                script {
                    input message: "Pause for verification"
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

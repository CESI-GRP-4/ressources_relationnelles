pipeline {
    agent any
    environment {
        DB_PORT = '3307'
        FRONTEND_PORT = '3001'
        BACKEND_PORT = '8077'
        NGINX_HTTP_PORT = '8099'
        NGINX_HTTPS_PORT = '8443'
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
                sh 'cp /srv/aio-tools/secure_ressources_relationnelles/.env .env'
                sh 'cp /srv/aio-tools/secure_ressources_relationnelles/backend/.env backend/.env'
                sh 'cp /srv/aio-tools/secure_ressources_relationnelles/frontend/.env frontend/.env'
                sh 'chmod 644 backend/.env'
            }
        }

        stage('Build Docker Containers') {
            steps {
                sh 'docker-compose up -d --build'
            }
        }


        stage('Wait for DB to be ready') {
            steps {
                echo 'Waiting for 20 seconds to ensure the database is ready...'
                sh 'sleep 20'
            }
        }

        stage('Check Frontend Status') {
              steps {
                  script {
                      // Wait for the frontend container to be in a running state
                      sh 'docker-compose ps -q frontend | xargs docker inspect -f \'{{.State.Status}}\' | grep -q "running" || (echo "Frontend container is not running" && exit 1)'
                      
                      // Wait for the frontend to be accessible
                      sh 'timeout 60s bash -c "until curl -s http://localhost:$FRONTEND_PORT > /dev/null; do sleep 5; done" || (echo "Frontend is not accessible after 60 seconds" && exit 1)'
                      
                      // Optional: Check for a specific element in the frontend response
                 //      sh 'curl -s http://localhost:$FRONTEND_PORT | grep -q "<title>" || (echo "Frontend response does not contain expected content" && exit 1)'
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

        stage('Run Frontend Tests') {
            steps {
                echo 'Frontend tests not yet implemented.'
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
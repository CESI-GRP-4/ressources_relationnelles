pipeline {
    agent any
    environment {
        DB_PORT = '3307'
        FRONTEND_PORT = '3001'
        BACKEND_PORT = '8077'
        NGINX_HTTP_PORT = '8086'
        NGINX_HTTPS_PORT = '8444'
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
                    sed -i "s/8085:80/$NGINX_HTTP_PORT:80/" docker-compose.yml
                    sed -i "s/8443:443/$NGINX_HTTPS_PORT:443/" docker-compose.yml
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

                // Update the frontend .env file
                sh '''
                    sed -i "s|https://cube.aio-tools.com/api|http://91.108.112.237:$BACKEND_PORT/api|" frontend/.env
                '''
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
                dir('frontend') {
                    // Get the Docker network name used by your services
                    sh '''
                    NETWORK_NAME=$(docker-compose ps -q | xargs docker inspect -f '{{json .NetworkSettings.Networks }}' | jq -r 'keys[]' | head -n 1)

                    # Run Cypress tests
                    docker run --rm \
                        --network ${NETWORK_NAME} \
                        -v $PWD:/e2e \
                        -w /e2e \
                        -e NO_COLOR=1 \
                        cypress/included:13.13.3 \
                        npx cypress run
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Build and tests succeeded!'
            sh'''
                cd /srv/aio-tools/ressources_relationnelles
                docker-compose down
                git fetch
                git checkout jenkins
                git pull
                docker-compose up --build -d
            '''
        }
        failure {
            echo 'Build or tests failed.'
        }
        always{
            sh 'docker-compose down'
        }
    }
}
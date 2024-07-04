pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building...'
            }
        }
        stage('Test') {
            steps {
                script {
                    docker.image('cypress/included:7.0.0').inside {
                        sh 'npx cypress run'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }   
}

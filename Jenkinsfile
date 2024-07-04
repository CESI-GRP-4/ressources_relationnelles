pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/CESI-GRP-4/ressources_relationnelles'
            }
        }
        stage('Build') {
            steps {
                echo 'Building...'
            }
        }
        stage('Test') {
            steps {
                script {
                    docker.image('cypress/included:7.0.0').inside {
                        sh '''
                            cd front-end
                            npx cypress run
                        '''
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
        success {
            echo 'Build et déploiement terminés avec succès !'
        }
        failure {
            echo 'Échec du build ou du déploiement'
        }
        always {
            cleanWs()
        }
    }   
}

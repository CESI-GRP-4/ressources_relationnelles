```pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/CESI-GRP-4/ressources_relationnelles'
                script{
                    sh 'ls'
                }
            }
        }
        stage('Build and Test') {
            steps {
                script {
                    // Démarrer les services Docker Compose
                    sh 'docker-compose up -d --build'

                    // Exécute les tests
                    sh 'docker-compose run app npx cypress run'

                    // Arrêter les services Docker Compose
                    sh 'docker-compose down'
                }
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

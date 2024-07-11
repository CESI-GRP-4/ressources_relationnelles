pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                // Vérification du dépôt
                git branch: 'Jenkinsfile', url: 'https://github.com/CESI-GRP-4/ressources_relationnelles', credentialsId: '71d93206-f0a4-45be-ae69-c769b4a82d72'
            }
        }
        stage('Build and Test') {
            steps {
                script {
                    // Démarrer les services Docker Compose
                    sh 'pwd'
                    sh 'docker-compose up -d --build'

                    // Exécute les tests
                    sh 'docker-compose run app npx cypress run'
                    sh 'docker-compose exec app php artisan test'

                    // Arréter les services Docker Compose
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
            echo 'Echec du build ou du déploiement'
        }
        always {
            cleanWs()
        }
    }
}

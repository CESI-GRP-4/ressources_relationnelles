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
                    sh 'ls'
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

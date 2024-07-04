pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                // Vérification du dépôt
                git branch: 'Jenkinsfile', url: 'https://github.com/CESI-GRP-4/ressources_relationnelles'
                
                // Afficher le contenu du répertoire pour débogage
                script {
                    sh 'ls -la'
                }
            }
        }
        stage('Install Dependencies') {
            steps {
                script {
                    sh 'npm install'
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    sh 'npm run build'
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    // Démarrer les services Docker Compose
                    sh 'docker-compose up -d --build'
                    
                    // Exécuter les tests
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

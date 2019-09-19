pipeline {
    agent {
        docker { image 'node:7-alpine' }
    }
    stages {
        stage('Testing Docker Image') {
            steps {
                sh 'node --version'
            }
        }
    }
}

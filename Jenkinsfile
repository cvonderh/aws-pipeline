pipeline {
    agent {
        docker { image 'cvonderh/go-docker:latest' }
    }
    stages {
        stage('Testing Docker Image') {
            steps {
                sh 'go version'
            }
        }
    }
}

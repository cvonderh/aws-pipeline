pipeline {
    agent {
        docker { image 'cvonderh/go-docker:latest' }
    }
    stages {
        stage('Lint Docker Image') {
            steps {
                sh 'golint ./go-docker/go-docker'
            }
        }
    }
}

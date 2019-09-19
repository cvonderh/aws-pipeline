pipeline {
    agent {
        docker { image 'cvonderh/go-docker:latest' }
    }
    stages {
        stage('Lint Docker Image') {
            steps {
                sh '/home/ubuntu/work/bin/golint ./go-docker/go-docker'
            }
        }
    }
}

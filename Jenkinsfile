pipeline {
    agent {
        docker { image 'cvonderh/go-docker:latest' }
        //sh '/home/ubuntu/work/bin/golint ./go-docker/go-docker'
    }
    stages {
        stage('Lint Docker Image') {
            steps {
                sh 'go version'
            }
        }
    }
}

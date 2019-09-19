pipeline {
    agent {
        docker { image 'cvonderh/go-docker:latest' }
    }
    stages {
        stage('Test') {
            steps {
                sh 'go version'
            }
        }
    }
}

pipeline {
    agent none 
    stages {
        // PLACEHOLDER for stage to build locally from Dockerfile, then it will be tested
        // Lint the local conatiner before it is built and pushed
        stage{
            steps{
                sh 'echo linting now'
                sh '/home/ubuntu/work/bin/golint ./go-docker/go-docker'
            }
        }
        //
        stage('Example Build') {
            agent { docker 'cvonderh/go-docker:latest' } 
            steps {
                echo 'Hello, from docker-go'
                sh 'go version'
            }
        }
        stage('Example Test') {
            agent { docker 'openjdk:8-jre' } 
            steps {
                echo 'Hello, JDK'
                sh 'java -version'
            }
        }
    }
}

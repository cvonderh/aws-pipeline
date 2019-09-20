pipeline {
    agent none 
    stages {
        // PLACEHOLDER for stage to build locally from Dockerfile, then it will be tested
        // Lint the local conatiner before it is built and pushed
        stage('Linting go service'){
            agent any
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
                sh 'uname -a'
                //sh 'curl http://localhost:9090?name=Kraut'
                //sh 'docker ps -a'
            }
        }
        // Test with acurl command
        stage("Test service with curl"){
            agent any
            steps{
                sh 'docker run  go-docker:latest'
                //docker run -it -—rm -p 8080:3000 -p 8081:3001 -e RACK_ENV=development -e HOSTNAME=my-container my-rails-app:latest rackup

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

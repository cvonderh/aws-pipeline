pipeline {
    agent none 
    stages {
        // Build service using make
        stage("Build service from Makefile"){
            agent any
            steps{
                sh 'pwd'
                sh "cd ~/udacity/aws-pipeline"
                sh 'pwd'
                sh 'make -f Makefile'
            }
        }
        // Lint the local version of service before it is containerized
        stage('Linting go service'){
            agent any
            steps{
                sh 'echo linting now'
                sh '/home/ubuntu/work/bin/golint ./go-docker/go-docker'
                
            }
        }
        // PLACEHOLDER for stage to build locally from Dockerfile, then it will be tested
        stage('Test') {
            agent { dockerfile true }
            steps {
                echo 'Hello, from docker-go dockerfile build'
                sh 'go version'
                sh 'uname -a'
            }
        }
        //
        stage('Example Build') {
            agent { docker 'cvonderh/go-docker:latest' } 
            steps {
                echo 'Hello, from docker-go second build'
                sh 'go version'
                sh 'uname -a'
            }
        }
        // Test with acurl command
        stage("Test service with curl"){
            agent any
            steps{
                sh 'docker images ls'
                //sh 'docker pull cvonderh/go-docker:latest'
                sh 'docker run -d -p 9090:9090 cvonderh/go-docker'
                //sh 'docker run  go-docker:latest'
                //docker run -it -—rm -p 8080:3000 -p 8081:3001 -e RACK_ENV=development -e HOSTNAME=my-container my-rails-app:latest rackup
                 sh 'curl http://localhost:9090?name=Kraut'
            }
        }
        //After all testing and new image pushed to hub, clean up locally
        stage("clean up local"){
            agent any
            steps{
                sh 'docker ps -a'
                sh 'docker stop $(docker ps -a -q)'
                sh 'docker rm $(docker ps -a -q)'
                sh 'docker ps -a'
                sh 'docker images'
                sh 'docker rmi $(docker images -a -q)'
                sh 'docker images'
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

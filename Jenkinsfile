pipeline {
    agent none 
    stages {
        // Use make to build and test go service
        stage("Build go-hello service from Makefile"){
            agent any
            steps{
                sh 'make -C /home/ubuntu/udacity/aws-pipeline'
            }
        }
        // Lint the local version of service
        stage('Linting go service'){
            agent any
            steps{
                sh 'echo linting now'
                sh '/home/ubuntu/work/bin/golint /home/ubuntu/udacity/aws-pipeline/go-docker/go-docker'
                
            }
        }
        // Conatinerize hello-go service
        stage('Containerize go-hello service') {
            agent { dockerfile true }
            steps {
                echo 'Hello, from docker-go dockerfile build'
                sh 'go version'
                sh 'uname -a'
            }
        }
        //
        // stage('Run the new conatiner') {
        //     agent { docker 'cvonderh/go-docker:latest' } 
        //     steps {
        //         echo 'Hello, from docker-go second build'
        //         sh 'go version'
        //         sh 'uname -a'
        //     }
        // }
        // Test with a curl command
        stage("Run conatiner and test service with curl"){
            agent any
            steps{
                sh 'docker images ls'
                //sh 'docker pull cvonderh/go-docker:latest'
                sh 'docker run --rm -d -p 9090:9090 cvonderh/go-docker'
                //sh 'docker run  go-docker:latest'
                //docker run -it -—rm -p 8080:3000 -p 8081:3001 -e RACK_ENV=development -e HOSTNAME=my-container my-rails-app:latest rackup
                 sh 'curl http://localhost:9090?name=Kraut'
            }
        }
        //CREATE STEP TO PUSH TO DOCKERHUB
        //After all testing and new image pushed to hub, clean up locally
        stage("clean up local"){
            agent any
            steps{
                sh 'docker ps -a'
                sh 'docker stop $(docker ps -a -q)'
                sh 'docker rm $(docker ps -a -q)'
                sh 'docker ps -a'
                sh 'docker images'
               // sh 'docker rmi $(docker images -a -q)'
                sh 'docker images'
                //sh 'docker system prune -a'
                // Clean out the go-docker folder for next build
                sh 'rm go-docker/*'
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

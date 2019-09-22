pipeline {
    environment {
    registry = 'https://cloud.docker.com/cvonderh/go-docker'
    registryCredential = 'dockerhubl'
    dockerImage = ''
    }
    agent none 
    stages {
        // Use make to build and test go service here
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
        // stage('Containerize go-hello service') {
        //     agent { dockerfile  { dir '/home/ubuntu/udacity/aws-pipeline' } }
        //     steps {
        //         echo 'Hello, from docker-go dockerfile build'
        //         sh 'go version'
        //         sh 'uname -a'
        //     }
        // }
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
        // stage("Run container and test service with curl"){
        //     agent any
        //     steps{
        //         sh 'docker images ls'
        //         //sh 'docker pull cvonderh/go-docker:latest'
        //         sh 'docker run --rm -d -p 9090:9090 cvonderh/go-docker'
        //         //sh 'docker run  go-docker:latest'
        //         //docker run -it -—rm -p 8080:3000 -p 8081:3001 -e RACK_ENV=development -e HOSTNAME=my-container my-rails-app:latest rackup
        //          sh 'curl http://localhost:9090?name=Kraut'
        //     }
        // }
        stage('Building NEW WAY image') {
            steps{
                script {
                dockerImage = docker.build("go-docker", "/home/ubuntu/udacity/aws-pipeline")
                }
            }
        }
        // code placeholder
        stage('Deploy Image Dockerhub v5') {
            steps{
                script {
                docker.withRegistry( registry, registryCredential ) {
                    dockerImage.push()
                    }
                }
            }
            // steps{
            //     sh 'uname -a'
            // }
        }
        // stage('Publish to dockerhub v2') {
        //     when {
        //         branch 'master'
        //     }
        //     steps {
                
        //         withDockerRegistry([ credentialsId: "41af6e86-82ab-4e52-a11c-521749c59a8f", url: "" ]) {
        //         sh 'docker push cvonderh/go-docker:latest'
        //         }
        //     }
        // }
        //CREATE STEP TO PUSH TO DOCKERHUB dddd
        //After all testing and new image pushed to hub, clean up locally
        stage("clean up local images"){
            agent any
            steps{
                // sh 'docker ps -a'
                // sh 'docker stop $(docker ps -a -q)'
                // sh 'docker rm $(docker ps -a -q)'
                // sh 'docker ps -a'
                sh 'docker images'
               // sh 'docker rmi $(docker images -a -q)'
                sh 'docker images purge'
                sh 'docker images'
                //sh 'docker system prune -a'
                // Clean out the go-docker folder for next build
                sh 'rm -f go-docker/*'
            }
        }
    }
}

pipeline {
    // no global agent will be allocated for the entire Pipeline run and each stage section will need to contain its own agent section
    agent none{
        // Create the docker image anpush to docker hub
        node{
            sh 'uname -a'
            sh 'date'
        }
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
}

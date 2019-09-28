node {
    def app
   stage('Test go code') {
        
        echo 'Testing with golint'
        sh '/home/ubuntu/work/bin/golint -set_exit_status=true /home/ubuntu/udacity/aws-pipeline/service_hello.go'
        //sh '/home/ubuntu/work/bin/golint /home/ubuntu/udacity/aws-pipeline/service_hello.go'
    }
    //If pass build locally
    stage('Build service locally') {
        //Need to add build of initia image here using make

        sh 'make -C /home/ubuntu/udacity/aws-pipeline'
    }
    stage('Build and conatinerize service') {
        /* This builds the actual image */

        app = docker.build("cvonderh/go-docker", "/home/ubuntu/udacity/aws-pipeline")
    }

    stage('Push image Dockerhub') {
        /* 
			You would need to first register with DockerHub before you can push images to your account
		*/
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
            } 
    }
    stage('Deploy Service into EKS cluster') {
        withKubeConfig([credentialsId: 'jenkins-deployer',
            serverUrl: 'https://B1BDEB6FD3633562F2E5231FEEB19EEE.gr7.us-east-1.eks.amazonaws.com'
            ]) {
            sh 'kubectl run --image=cvonderh/go-docker:latest gohello-svc --port=9090'
            // example
            //kubectl set image deployment/my-deployment mycontainer=repo-name/whatever-app:<version>
            //sh 'kubectl set image deployment/gohello-svc gocontainer=cvonderh/go-docker:latest'
            sh 'kubectl expose deployment gohello-svc --port=9090 --name=gohello-svc-http --type=LoadBalancer'
            sh 'kubectl get pods'
        }
    }
}

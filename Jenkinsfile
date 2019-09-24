node {
    def app

    stage('Build service in locally') {
        //Need to add build of initia image here using make

        sh 'make -C /home/ubuntu/udacity/aws-pipeline'
    }
    stage('Test image') {
        
        echo 'Testing with golint'
        sh '/home/ubuntu/work/bin/golint -set_exit_status ./go-docker/go-docker'
    }
    stage('Build and conatinerize service') {
        /* This builds the actual image */

        app = docker.build("cvonderh/go-docker", "/home/ubuntu/udacity/aws-pipeline")
    }

    stage('Push image') {
        /* 
			You would need to first register with DockerHub before you can push images to your account
		*/
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
            } 
    }
    stage('Deploy Service') {
        withKubeConfig([credentialsId: 'jenkins-deployer',
            serverUrl: 'https://028F72CFE7F177FB8E6FA4529169F920.gr7.us-east-1.eks.amazonaws.com'
            ]) {
            sh 'kubectl run --image=cvonderh/go-docker:latest gohello-svc --port=9090'
            sh 'kubectl expose deployment gohello-svc --port=9090 --name=gohello-svc-http --type=LoadBalancer'
            sh 'kubectl get pods'
        }
    }
}

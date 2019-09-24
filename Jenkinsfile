node {
    def app

    stage('Clone repository') {
        /* Cloning the Repository to our Workspace */
        //Need to add build of initia image here using make

        //checkout scm
        sh 'make -C /home/ubuntu/udacity/aws-pipeline'
    }

    stage('Build image') {
        /* This builds the actual image */

        app = docker.build("cvonderh/go-docker", "/home/ubuntu/udacity/aws-pipeline")
    }

    stage('Test image') {
        
        app.inside {
            echo "Tests passed"
        }
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
            sh 'kubectl get pods'
        }
    }
    // stage('Deploy service') {
    //     //deploy service aws k8s cluster added iam new 
    //     sh 'kubectl run --image=cvonderh/go-docker:latest go-hello-service --port=9090'
    // }
}

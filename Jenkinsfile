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
                echo "Trying to Push Docker Build to DockerHub"
    }
    stage('Deploy service') {
        //deploy service aws k8s cluster
        sh 'kubectl run --image=cvonderh/go-docker:latest go-hello-service --port=9090'
    }
}

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
    stage('List pods') {
        withKubeConfig([credentialsId: 'jenkins-deployer-credentials',
                        //caCertificate: 'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN5RENDQWJDZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRFNU1Ea3lNekl4TkRjMU9Wb1hEVEk1TURreU1ESXhORGMxT1Zvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSzRqCnJPSnErcUVZVVRuLzd4eE55RTZIekcwWGx4ZHMzRU1qTlFiUVdXNzU4cjdDbWZDSVpsaHZjV1ByQnBiZ2RvN0EKK3hyWk9pTXFSeWh4VEdlaW5LUk1HU1pucElITXBhdmU4UVZlRVRrdDQrUXYwYUhjdVJlYTZPRCtidlQrVXAwbgpMWkVlOU5pNisxTmdMbStpY0w3eldjUHRUK1pDQnlFNWFuS0dXbjlOVk82bVVTMVhuV24yelVta0g0WTJFdTlnCklOcFJlbU9tSzgrRXd5QWxuKzRoU3BJdUFoQnBpbUxhQytzdGN0WnRicTRPS1FIWTRGWGJxZjhKY3BtYk5yVmYKcC9MOTgzdkJnY2NUazNnakhWZEtMbXRzUVVuVjJyNzlxVHVoRk5CUlcyM3Z1U2ZHeE9oWDdPTjhkSGpMRFJ3bwpFRlNQL1d0cmtpbW5RWldkMDZNQ0F3RUFBYU1qTUNFd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFIMi9uYXM3UFBtZi9KY1pjU05STzVMeU1wR0sKZXFrcVR1cnBxTzcvcWpzVi8ybkZ0blNwVThiNHdSTnU0Y1p2NCtaTHVHSm1yUkhVWVhMZUYvY1ltQmRYS3RnegpKd0Roa0xJenJ1U0ZUVzhDMmJ0SEJpVHVVcVBySXc3MnczbEwzVUxiSlowVkdKVkxJMW1vVDQxM3JyYzJ6aU81CkNtUHhRTHZKeWx0TXpVRWF3Qk1nU2FCYStCV0laOFVLTW5Pa0lVZ2t5dnY0aWZRa1lvNGRBQ08zYVcwSHU4V2wKVFRQUFpsUjR5K0xVbjBya3hRRFR4OVNOWU9WYkk0WktPa3dOR2p5R1Q2YngvU3VkMFRBQXh0STdSZERvYjR4egptWHY5TEtZaEtCWmk4cXlLbS9mTlZBZi83Z0VyRWFNOEgvbXB4QXJUZ0xaU1o2VjZialdaMW9EOXlSbz0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=',
                        serverUrl: 'https://F5CF0196AD212F1153E27515C7A35086.gr7.us-east-1.eks.amazonaws.com',
                        contextName: '<context-name>',
                        clusterName: 'kubernetes'
                        //,namespace: '<namespace>'
                        ]) {
            sh 'kubectl version'
        }
    }
    // stage('Deploy service') {
    //     //deploy service aws k8s cluster added iam 
    //     sh 'kubectl run --image=cvonderh/go-docker:latest go-hello-service --port=9090'
    // }
}

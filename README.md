# aws-pipeline
Jenkins continuous deployment pipeline

## Create Kubernetes cluster for the hello-go service
Use AWS EKS for the cluster.

Create cluster by running.

```eksctl create cluster --name udacity --version 1.14 --nodegroup-name udac-workers --node-type t3.medium --nodes 3 --nodes-min 1 --region=us-east-1 --zones=us-east-1a,us-east-1b,us-east-1c --nodes-max 4 --node-ami auto ```

We have to create a ServiceAccount in Kubernetes that will be used by Jenkins for deployment.

```kubectl create sa jenkins-deployer
kubectl create clusterrolebinding jenkins-deployer-role — clusterrole=cluster-admin — serviceaccount=jenkins-deployer```

Then run the command

```kubectl get secrets```

You have to select the secret starting with “jenkins-deployer” and get the credentials associated with it:

```kubectl describe secret jenkins-deployer-token-jvdmf```

Copy the value of the token and use to create credential in Jenkins.

## Cleaning up after.

Delete the cluster and worker nodes using EKS commands.

```  eksctl delete cluster --name=udacity ```

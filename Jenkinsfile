pipeline {
  agent {
    docker {
      image 'node:10-alpine'
      args '-p 20001-20100:3000'
    }
  }
  environment {
    CI = 'true'
    HOME = '.'
    npm_config_cache = 'npm-cache'
  }
  stages {
    stage('Install Packages') {
      steps {
        sh 'npm install'
      }
    }
    stage('Test and Build') {
      parallel {
        stage('Run Tests') {
          steps {
            sh 'npm run test'
          }
        }
        stage('Create Build Artifacts') {
          steps {
            sh 'npm run build'
          }
        }
      }
    }
    stage('Deployment') {
      parallel {
        stage('Staging') {
          when {
            branch 'blue'
          }
          steps {
            withAWS(region:'us-east-1',credentials:'admin-sa') {
              s3Delete(bucket: 'kraut-blue-udacity', path:'**/*')
              s3Upload(bucket: 'kraut-blue-udacity', workingDir:'build', includePathPattern:'**/*');
            }
            mail(subject: 'Blue Prod Build', body: 'New Deployment to kraut-blue', to: 'csvrandom@mail.com')
          }
        }
        stage('Production') {
          when {
            branch 'green'
          }
          steps {
            withAWS(region:'us-east-1',credentials:'admin-sa') {
              s3Delete(bucket: 'kraut-green-udacity', path:'**/*')
              s3Upload(bucket: 'kraut-geen-udacity', workingDir:'build', includePathPattern:'**/*');
            }
            mail(subject: 'Green Prod Build', body: 'New Deployment to kraut-green', to: 'csvrandom@mail.com')
          }
        }
      }
    }
  }
}

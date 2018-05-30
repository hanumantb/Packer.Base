pipeline {
  agent {
    node {
      label 'runner'
    }
  }
  options {
    disableConcurrentBuilds()
    timestamps()
  }
  stages {
    stage('Prepare') {
      steps {
        sh 'make prepare'
        stash includes: 'ansible/roles/vendor/*', name: 'ansible-vendor'
      }
    }
    parallel {
      stage('Ubuntu 18.04') {
        stage('Build') {
          steps {
            unstash 'ansible-vendor'
            sh 'make ubuntu1804-build'
          }
        }
        stage('Release') {
          environment {
            VAGRANT_CLOUD_TOKEN = credentials('vagrant-cloud-vvv-base')
          }
          steps {
            sh 'make ubuntu1804-upload'
          }
        }
      }
    }
  }
}

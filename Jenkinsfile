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
        stash includes: 'ansible/roles/vendor/**/*', name: 'ansible-vendor'
      }
    }
    stage('Build') {
      parallel {
        stage('Ubuntu 18.04') {
          steps {
            unstash 'ansible-vendor'
            sh 'make ubuntu1804-build'
            stash includes: 'builds/virtualbox-ubuntu1804.box', name: 'ubuntu1804-box'
          }
        }
      }
    }
    stage('Release') {
      parallel {
        stage('Ubuntu 18.04') {
          environment {
            VAGRANT_CLOUD_TOKEN = credentials('vagrant-cloud-vvv-base')
          }
          steps {
            unstash 'ubuntu1804-box'
            sh 'make ubuntu1804-upload'
          }
        }
      }
    }
  }
}

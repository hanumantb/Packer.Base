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
          agent {
            node {
              label 'runner'
            }
          }
          steps {
            unstash 'ansible-vendor'
            sh 'sudo /sbin/vboxconfig'
            sh 'make ubuntu1804-build'
            stash includes: 'builds/virtualbox-ubuntu1804.box', name: 'ubuntu1804-box'
          }
        }
        stage('Ubuntu 16.04') {
          agent {
            node {
              label 'runner'
            }
          }
          steps {
            unstash 'ansible-vendor'
            sh 'sudo /sbin/vboxconfig'
            sh 'make ubuntu1604-build'
            stash includes: 'builds/virtualbox-ubuntu1604.box', name: 'ubuntu1604-box'
          }
        }
        stage('Ubuntu 14.04') {
          agent {
            node {
              label 'runner'
            }
          }
          steps {
            unstash 'ansible-vendor'
            sh 'sudo /sbin/vboxconfig'
            sh 'make ubuntu1404-build'
            stash includes: 'builds/virtualbox-ubuntu1404.box', name: 'ubuntu1404-box'
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
        stage('Ubuntu 16.04') {
          environment {
            VAGRANT_CLOUD_TOKEN = credentials('vagrant-cloud-vvv-base')
          }
          steps {
            unstash 'ubuntu1604-box'
            sh 'make ubuntu1604-upload'
          }
        }
        stage('Ubuntu 14.04') {
          environment {
            VAGRANT_CLOUD_TOKEN = credentials('vagrant-cloud-vvv-base')
          }
          steps {
            unstash 'ubuntu1404-box'
            sh 'make ubuntu1404-upload'
          }
        }
      }
    }
  }
  post {
    always {
      cleanWs()
    }
  }
}

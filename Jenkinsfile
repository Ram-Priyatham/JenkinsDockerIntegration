#!groovy

pipeline {
  agent any
  parameters {
    choice(
      name: 'AppVersion',
      choices: ['Version1', 'Version2', 'Version3'],
      description: 'Select the version'
    )
  }
  stages {
    stage("Clone Repository"){
      steps {
          git branch: 'refs/tags/${params.AppVersion}', url: 'https://github.com/Ram-Priyatham/JenkinsDockerIntegration'
      }
    }
    stage('Docker Build') {
      steps {
      	sh 'docker build -t rampriyatham/demo-test:${params.AppVersion} .'
      }
    }
    stage('Docker Push') {
      steps {
      	withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
        	sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
          sh 'docker push rampriyatham/demo-test:${params.AppVersion}'
        }
      }
    }
  }
}
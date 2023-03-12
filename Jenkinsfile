#!groovy

pipeline {
  agent any
  parameters {
    choice(
      name: 'AppVersion',
      choices: ['v0.1.0', 'v0.2.0', 'v0.3.0'],
      description: 'Select the version'
    )
  }
  stages {
    stage("Clone Repository"){
      steps {
        script {
          def tag = params.AppVersion
          echo "${params.AppVersion}"
          // echo 'sh "git --version"'
          // git --version
          sh  "/usr/bin/git clone --branch 'v0.1.0' https://github.com/Ram-Priyatham/JenkinsDockerIntegration/"
          // git(branch: "refs/tags/v0.2.0", url: 'https://github.com/Ram-Priyatham/JenkinsDockerIntegration')
        }
      }
    }
    stage('Docker Build') {
      steps {
      	sh "docker build -t rampriyatham/demo-test:${params.AppVersion} ."
      }
    }
    stage('Docker Push') {
      steps {
      	withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
        	sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
          sh "docker push rampriyatham/demo-test:${params.AppVersion}"
        }
      }
    }
    // stage('')
  }
}
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
    // stage('Clear Workspace') {
    //   steps {
    //     deleteDir()
    //   }
    // }
    stage("Clone Repository"){
      steps {
        script {
          
          def tag = params.AppVersion
          echo "${params.AppVersion}"
          // sh  "/usr/bin/git clone --branch ${params.AppVersion} https://github.com/Ram-Priyatham/JenkinsDockerIntegration/"
          git(branch: 'master', url: 'https://github.com/Ram-Priyatham/JenkinsDockerIntegration')
          sh "git checkout tags/${params.AppVersion} -b"
        }
      }
    }
    stage('Docker Build') {
      steps {
        script{
          def releaseName = sh(returnStdout: true, script: 'git describe --abbrev=0 --tags').trim()
          // def dockerImageName = "example/:${releaseName}"
          // sh "cd JenkinsDockerIntegration"
          sh "docker build -t rampriyatham/demo-test:${params.AppVersion} ."
        }
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
    // withKubeConfig([credentialsId: 'minikube', serverUrl: 'https://192.168.49.2:8443', clusterName: 'minikube']) {
    //         sh "echo '${editedManifest}' | kubectl apply -f -"
    //       }
    stage('Docker Run'){
      steps{
        script{
          sh "kubectl create namespace cicd-task"
          sh "kubectl apply -f deployment.yaml --namespace=cicd-task"
          sh "kubectl apply -f service.yaml -n cicd-task"
        }
      }
    }
  }
}
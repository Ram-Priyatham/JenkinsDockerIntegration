@Library('my-shared-library') _
node {
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
          clonerepo(params.AppVersion);
        }
      }
    }
    stage('Docker Build') {
      steps {
        script{
          dockerbuild(params.AppVersion);
        }
      }
    }
    stage('Docker Push') {
      steps {
      	dockerpush(params.AppVersion);
      }
    }
    stage('Docker Run'){
      steps{
        script{
          dockerrun();
        }
      }
    }
  }
}

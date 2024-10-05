pipeline {
  agent any 
  tools{
        jdk 'jdk17'
  }

  environment {
    ARM_ACCESS_KEY = credentials('ARM_ACCESS_KEY')
    ARM_CLIENT_ID = credentials('ARM_CLIENT_ID')
    ARM_CLIENT_SECRET = credentials('ARM_CLIENT_SECRET')
    ARM_SUBSCRIPTION_ID = credentials('ARM_SUBSCRIPTION_ID')
    ARM_TENANT_ID = credentials('ARM_TENANT_ID')
    SCANNER_HOME=tool 'sonar-scanner'
    BUILD_TAG = "build-${env.BUILD_NUMBER}-${env.BRANCH_NAME}"
  }

   stages {
        stage('clean workspace'){
            steps{
                cleanWs()
            }
        }
        stage('Checkout from Git'){
            steps{
                git branch: 'main', url: 'https://github.com/AnuragKishor-Git/terraform-azure-lab.git'
            }
        }
        stage("Sonarqube Analysis "){
            steps{
                withSonarQubeEnv('sonar-server') {
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=terra_test \
                    -Dsonar.projectKey=terra_test '''
                }
            }
        }
        stage("quality gate"){
           steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'Sonar-token'
                }
            }
        }
    stage('Terraform - init') {
      steps {
          sh 'terraform init -upgrade -input=false'
      }
    }

    stage('Terraform - validate') {
      steps {
          sh 'terraform validate'
      }
    }

    stage('Terraform - plan') {
      steps {
          sh 'terraform plan -out=tfplan -input=false'
      }
    }

    stage('Terraform - action') {
      steps {
          sh 'terraform $action -input=false tfplan'
      }
    }

  }

  post {
    always {
      cleanWs()
    }
  }
} // pipeline

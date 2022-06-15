pipeline {
  agent {
    node "agent-terraform"
  }

  environment {
    BRANCH = 'main'
    REPO = 'https://github.com/jansouza/terraform-azure-lab.git'

    ARM_ACCESS_KEY = credentials('ARM_ACCESS_KEY')
    ARM_CLIENT_ID = credentials('ARM_CLIENT_ID')
    ARM_CLIENT_SECRET = credentials('ARM_CLIENT_SECRET')
    ARM_SUBSCRIPTION_ID = credentials('ARM_SUBSCRIPTION_ID')
    ARM_TENANT_ID = credentials('ARM_TENANT_ID')
  }

  stages {

    stage('Checkout Source') {

      steps {
        git branch: "$BRANCH",
            url: "$REPO"
      }
    }

    stage('Terraform - init') {
      steps {
          sh 'terraform init -upgrade'
      }
    }

    stage('Terraform - validate') {
      steps {
          sh 'terraform validate'
      }
    }

    stage('Terraform - plan') {
      steps {
          sh 'terraform plan'
      }
    }

    stage('Terraform - apply') {
      steps {
          sh 'terraform apply -auto-approve'
      }
    }

  }

  post {
    always {
      cleanWs()
    }
  }
} // pipeline

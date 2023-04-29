pipeline {
  agent any
  environment {
  TF_IN_AUTOMATION = 'true'
  TF_CLI_CONFIG_FILE = credentials('tf-credentials')
  }
  stages {
    stage('Init') {
    
      steps {
        sh 'ls' 
        
        sh 'terraform init -no-color'
        }
    }
    
    stage('plan') {
    
      steps {
      
        sh 'terraform plan -no-color -lock=false'
     }
        
    } 
    stage('plan') {
      steps {
      sh 'terraform apply -auto-approve -no-color -lock=false'
   }
  }
  stage('destroy') {
      steps {
      sh 'terraform destroy -auto-approve -no-color -lock=false'
   }
  }
  }
  }
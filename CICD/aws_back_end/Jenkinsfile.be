pipeline {
    agent {
        label 'agent1'
    }

    environment {
        AWS_CREDENTIAL = 'AWS-Credentials-Root-AccessKey'
        AWS_REGION = 'ap-southeast-2'
        scripts_path = "../../CICD/aws_back_end/scripts"
    }

    parameters {
        booleanParam(name: 'destroy', defaultValue: false, description: 'Want to terraform Destroy?')
        choice(name: 'workspace', choices: ['uat', 'prod'], description: 'Workspace deployment')
    }
    stages {
        stage('Initializing') {
            steps {
                dir("application/aws_back_end"){                  
                    sh "chmod +x ${scripts_path}/*.sh"
                    sh "${scripts_path}/init.sh "                   
                }
            }
        }
        stage('tf init') {
            steps {
                dir("application/aws_back_end"){
                    withAWS(credentials: "${AWS_CREDENTIAL}", region: "${AWS_REGION}") {
                  
                    sh "${scripts_path}/tf_init.sh "
                    }
                }
            }
        }
        stage('tf workspace') {
            steps {
                dir("application/aws_back_end"){
                    withAWS(credentials: "${AWS_CREDENTIAL}", region: "${AWS_REGION}") {
                  
                    sh "${scripts_path}/tf_workspace.sh ${params.workspace}"
                    }
                }
            }
        }
        stage('tf apply') {     
                        when {
                    expression { params.destroy == false }
            }    
            steps{
                dir("application/aws_back_end"){
                    withAWS(credentials: "${AWS_CREDENTIAL}", region: "${AWS_REGION}") {
                 
                    sh "${scripts_path}/tf_apply.sh "
                    }
                }
            }
        }
        stage('tf destroy') {  
                        when {
                    expression { params.destroy == true }
            }       
            steps{
                dir("application/aws_back_end"){
                    withAWS(credentials: "${AWS_CREDENTIAL}", region: "${AWS_REGION}") {
               
                    sh "${scripts_path}/tf_destroy.sh "
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
        success {
            echo "********* Successful *********\nCongratulations!\n"

        }
        failure {
            echo "********* Fail *********\nOops!\n"
        }
    }
}

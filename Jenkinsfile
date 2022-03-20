
def ECR_REPO
pipeline {
    agent any
    environment{
        dockerHome = tool 'myDocker'
        mavenHome = tool 'myMaven'
        PATH = "$dockerHome/bin:$mavenHome/bin:$PATH"
    }
    stages{
        stage("Code Build"){
            steps{
                git branch: 'develop', url: 'https://github.com/rohitzinzuvadia/spring-boot-sample-app'
                sh 'mvn clean package -DskipTests=True'
            }
        }
        stage("Create ECR "){
            options {
                skipDefaultCheckout()
            }
            steps{
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS-PERSONAL']]) {
                    script{
                        dir('deployment/terraform/ecr') {
                            sh 'terraform init -backend-config=backend-dev-config.tfvars'
                            sh 'terraform plan'
                            //sh 'terraform apply -auto-approve'
                            sh 'terraform destroy'
                        }
                        ECR_REPO = readJSON file: 'deployment/terraform/ecr/output.json'
                    }
                }
            }
        }
        stage("Build Image & Push "){
            steps{
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS-PERSONAL']]) {
                    script{
                        sh '$(aws ecr get-login --no-include-email --region ap-south-1)'
                        sh 'docker build -t ${ECR_REPO.ecr_repository_name.value}:dev -f deployment/Docker/Dockerfile .'
                        sh 'docker push ${ECR_REPO.ecr_repository_name.value}:dev'
                    }
                }
            }
        }    
        stage("Deploy ECS Task"){
            steps{
                echo "========executing A========"
            }
        }
    }
    post{
        always{
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}
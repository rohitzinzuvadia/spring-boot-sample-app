
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
                            sh 'terraform destroy -auto-approve'
                            //sh 'terraform destroy -target aws_ecr_repository.spring-boot-sample-app'
                        }
                    }
                }
            }
        }
        stage("Build Image & Push"){
            steps{
                echo "Build Image & Push"
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS-PERSONAL']]) {
                    script{
                        sh '$(aws ecr get-login --no-include-email --region ap-south-1)'
                        sh 'docker build -t ${account_name}/spring-boot-sample-app:dev -f deployment/Docker/Dockerfile .'
                        sh 'docker push ${account_name}/spring-boot-sample-app:dev'
                    }
                }
            }
        }    
        stage("Deploy ECS Task"){
            steps{
                echo "Deploy ECS Task"
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS-PERSONAL']]) {
                    script{
                        dir('deployment/terraform/ecs') {
                            sh 'terraform init -backend-config=backend-dev-config.tfvars'
                            sh 'terraform plan'
                            sh 'terraform validate'
                            sh 'terraform apply -auto-approve'
                            //sh 'terraform destroy -target aws_ecr_repository.spring-boot-sample-app'
                        }
                    }
                }    
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
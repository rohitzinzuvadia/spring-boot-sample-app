pipeline{
    agent any
    stages{
        stage("Code Build"){
            steps{
                git branch: 'develop', url: 'https://github.com/rohitzinzuvadia/spring-boot-sample-app'
                sh 'mvn clean package -DskipTests=True'
            }
        }
        stage("Create ECR "){
            steps{
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-personal']]) {
                    dir('deployment/terraform/ecr') {
                         sh 'terraform init -backend-config=backend-dev-config.tfvars'
                         sh 'terraform plan'
                         sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
        stage("Build Image & Push "){
            steps{
                echo "========executing A========"
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
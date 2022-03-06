pipeline{
    agent{
        label "node"
    }
    stages{
        stage("Code Build"){
            steps{
                echo "========executing A========"
            }
        }
        stage("Create ECR "){
            steps{
                echo "========executing A========"
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
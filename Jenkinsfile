pipeline {
    agent any

    environment {
        TERRAFORM_DIR = "terraform"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/akshatbajpai01/StellarTrack.git'
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${TERRAFORM_DIR}") {
                    sh 'terraform init'
                }
            }
        }

        stage('Deploy') {
            steps {
                dir("${TERRAFORM_DIR}") {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Restart NGINX') {
            steps {
                sh 'sudo systemctl restart nginx'
            }
        }
    }

    post {
        failure {
            echo 'Deployment failed. Attempting rollback...'
            sh 'bash terraform/rollback.sh || echo "No rollback script found"'
        }
    }
}

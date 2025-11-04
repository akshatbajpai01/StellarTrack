pipeline {
    agent any

    environment {
        // Update the NGINX path for Linux
        NGINX_PATH = '/var/www/html/stellartrack'
    }

    stages {

        stage('Checkout') {
            steps {
                git url: 'https://github.com/rishabkm/StellarTrack.git',
                    branch: 'main'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Deploy') {
            steps {
                dir('terraform') {
                    // Apply infrastructure changes using Terraform
                    sh 'terraform apply -auto-approve'
                }
            }
            post {
                failure {
                    // Run rollback script if deployment fails
                    sh 'bash terraform/rollback.sh || echo "No rollback script found"'

                    script {
                        // Optional: trigger Jenkins rebuild if deployment fails
                        def buildUrl = "http://localhost:8080/job/automation/${BUILD_NUMBER}/rebuild"
                        sh "curl -X POST ${buildUrl} || true"
                    }
                }
            }
        }

        stage('Restart NGINX') {
            steps {
                // Restart NGINX service on Linux
                sh '''
                    echo "Restarting NGINX service..."
                    sudo systemctl restart nginx
                    echo "NGINX restarted successfully!"
                '''
            }
        }
    }
}

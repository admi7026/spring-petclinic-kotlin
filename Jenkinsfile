
    pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building the Docker image...'
                // Build Docker image using Dockerfile in your repository
                script {
                    docker.build('your-image-name:latest')
                }
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running basic test...'
                // Add your test commands here
            }
        }

         stage('Code Quality Analysis') {
            steps {
                echo 'Running code quality analysis...'
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying to staging environment...'
                script {
                    def dockerImage = docker.build("myapp:latest")
                    dockerImage.run("-d -p 8888:8080")  // Changed port mapping to use host port 8888
                }
            }
        }

        stage('Release') {
            steps {
                echo 'Releasing...'
                // Add your release commands here
            }
        }
        stage('Monitoring and Alerting') {
            steps {
                echo 'Setting up monitoring and alerting...'
                // Add monitoring and alerting commands here
            }
        }
        stage('Declarative: Post Actions') {
            steps {
                echo 'Cleaning up...'
                deleteDir()
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            // Clean up workspace
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}

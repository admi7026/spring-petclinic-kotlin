
    pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building the Docker image...'
                script {
                    docker.build('your-image-name:latest')
                }
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running basic test...'
            
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
                    dockerImage.run("-d -p 8888:8080") 
                }
            }
        }

        stage('Release') {
            steps {
                echo 'Releasing...'
               
            }
        }
        stage('Monitoring and Alerting') {
            steps {
                echo 'Setting up monitoring and alerting...'
               
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

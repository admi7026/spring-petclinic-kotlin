
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
     stages {
        stage('Test') {
            steps {
                echo 'Running basic test...'
            }
        }
       tools {
        // Use the installed SonarQube Scanner
        SonarQubeScanner 'SonarQubeScanner'
    }
    stages {
        stage('Code Quality Analysis') {
            steps {
                script {
                    // Run SonarQube analysis
                    withSonarQubeEnv('YourSonarQubeServer') {
                        sh 'sonar-scanner'
                    }
                }
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
                echo 'Releasing to production...'
                // Example: Use AWS CodeDeploy
                bat 'aws deploy create-deployment --application-name MyApp --deployment-group-name MyDeploymentGroup --s3-location bucket=mybucket,key=myapp.zip,bundleType=zip'
            }
        }

        stage('Monitoring and Alerting') {
            steps {
                echo 'Setting up monitoring and alerting with New Relic...'
                script {
                    // Add your New Relic setup script here
                    bat 'newrelic-admin run-program java -jar your-app.jar'
                }
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

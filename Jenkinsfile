pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building the application...'
                // Build the application using Gradle
                sh './gradlew build'
                // Archive the build artifact
                archiveArtifacts artifacts: '**/build/libs/*.jar', allowEmptyArchive: true
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                // Run JUnit tests using Gradle
                sh './gradlew test'
                // Publish test results
                junit '**/build/test-results/test/*.xml'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying to staging environment...'
                script {
                    // Stop any existing container using the same name
                    sh 'docker stop myapp || true'
                    // Remove the container if it exists
                    sh 'docker rm myapp || true'
                    // Build and run the Docker container
                    sh 'docker build -t myapp:latest .'
                    sh 'docker run -d -p 8080:8080 --name myapp myapp:latest'
                }
            }
        }

        stage('Release') {
            steps {
                echo 'Releasing to production...'
                // Example: Use AWS CodeDeploy
                sh 'aws deploy create-deployment --application-name MyApp --deployment-group-name MyDeploymentGroup --s3-location bucket=mybucket,key=myapp.zip,bundleType=zip'
            }
        }

        stage('Monitoring and Alerting') {
            steps {
                echo 'Setting up monitoring and alerting...'
                // Example: Configure Datadog monitoring
                sh 'datadog-agent start'
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



pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building the application...'
                // Build the application using Gradle
                bat './gradlew build'
                // Archive the build artifact
                archiveArtifacts artifacts: '**/build/libs/*.jar', allowEmptyArchive: true
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                // Run JUnit tests using Gradle
                bat './gradlew test'
                // Publish test results
                junit '**/build/test-results/test/*.xml'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying to staging environment...'
                script {
                    def dockerImage = docker.build("myapp:latest")
                    dockerImage.run("-d -p 8080:8080")
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
                echo 'Setting up monitoring and alerting...'
                // Example: Configure Datadog monitoring
                bat 'datadog-agent start'
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
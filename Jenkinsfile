pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building the application...'
                bat './gradlew build'
                archiveArtifacts artifacts: '**/build/libs/*.jar', allowEmptyArchive: true
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                bat './gradlew test'
                junit '**/build/test-results/test/*.xml'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying to staging environment...'
                bat 'docker build -t myapp:latest .'
                bat 'docker run -d -p 8080:8080 myapp:latest'
            }
        }

        stage('Release') {
            steps {
                echo 'Releasing to production...'
                bat 'aws deploy create-deployment --application-name MyApp --deployment-group-name MyDeploymentGroup --s3-location bucket=mybucket,key=myapp.zip,bundleType=zip'
            }
        }

        stage('Monitoring and Alerting') {
            steps {
                echo 'Setting up monitoring and alerting...'
                bat 'datadog-agent start'
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
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

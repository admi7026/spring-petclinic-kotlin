
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
                echo 'Running JUnit tests...'
                // Run JUnit tests using Gradle (assuming you're using Gradle for your project)
                script {
                    docker.image('your-image-name:latest').inside {
                        sh './gradlew test'
                    }
                }
            }
        }
    
        stage('Code Quality Analysis') {
            steps {
                echo 'Running SonarQube analysis...'
                script {
                    def scannerHome = tool 'SonarQube Scanner'
                    withSonarQubeEnv('SonarQube') { // 'SonarQube' is the name of the SonarQube server configured in Jenkins
                        bat "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=my_project_key -Dsonar.sources=src -Dsonar.host.url=http://your_sonarqube_server:9000 -Dsonar.login=my_sonarqube_token"
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

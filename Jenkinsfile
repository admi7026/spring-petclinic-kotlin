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
 stage('Debugging') {
            steps {
                echo 'Checking environment...'
                sh 'echo $PATH' // Print the PATH variable for debugging
                sh 'which nohup' // Check if nohup is accessible
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

        stage('Code Quality Analysis') {
            steps {
                echo 'Running SonarQube analysis...'
                script {
                    def scannerHome = tool 'SonarQube Scanner'
                    withSonarQubeEnv('SonarQube') { // 'SonarQube' is the name of the SonarQube server configured in Jenkins
                        sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=jenkins-integration -Dsonar.sources=src -Dsonar.host.url=http://localhost:9000 -Dsonar.login=sqp_a44c2f15754f276ef6be6d404a058b693404daf2"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying to staging environment...'
                // Placeholder command or your deployment command goes here
                sh 'echo "Deploying to staging environment..."'
            }
        }

        stage('Release') {
            steps {
                echo 'Releasing to production...'
                // Placeholder command or your deployment command goes here
                sh 'echo "Releasing to production..."'
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

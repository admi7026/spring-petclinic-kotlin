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
 stage('Code Quality Analysis') {
            steps {
                echo 'Running SonarQube analysis...'
                script {
                    def scannerHome = tool 'SonarQube Scanner'
                    withSonarQubeEnv('SonarQube') { // 'SonarQube' is the name of the SonarQube server configured in Jenkins
                        bat "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=jenkins-integration -Dsonar.sources=src -Dsonar.host.url=http://localhost:9000 -Dsonar.login=sqp_a44c2f15754f276ef6be6d404a058b693404daf2"
                    }
                }
            }
        }
        stage('Release') {
            steps {
                echo 'Releasing to production...'
                // Placeholder command or your deployment command goes here
                bat 'echo "Deploying to production..."'
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

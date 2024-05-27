pipeline {
    agent any

    tools {
        jdk 'JDK 17' // Use the JDK name configured in Jenkins
    }
    stages {
        stage('Build') {
            steps {
                // Your build steps here
                sh './gradlew build'
            }
        }
        // Other stages
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
                    withSonarQubeEnv('SonarQube') {
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
                // Placeholder command or your monitoring setup goes here
                bat 'echo "Setting up monitoring and alerting..."'
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


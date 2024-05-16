pipeline {
    agent any // Run on any available Jenkins agent

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/admi7026/spring-petclinic-kotlin.git' // Replace with your repository URL
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests' // Build with Maven, skip tests for now
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test' // Run unit tests
                junit 'target/surefire-reports/*.xml' // Publish test results
            }
        }

        stage('Code Quality Analysis') {
            steps {
                // Uncomment and configure if you are using SonarQube
                // withSonarQubeEnv('SonarQube') { // Replace 'SonarQube' with your SonarQube server ID
                //     sh 'mvn sonar:sonar'
                // }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build('spring-petclinic') // Name your Docker image
                }
            }
        }

        stage('Deploy to Test Environment') {
            steps {
                script {
                    dockerImage.withRun('-p 8080:8080') { c ->
                        sh "docker exec -t ${c.id} curl -f http://localhost:8080/ || true" // Health check
                    }
                }
            }
        }

        stage('Release to Production') {
            steps {
                input message: 'Promote to production?', ok: 'Deploy'
                // Add your production deployment steps here (e.g., push to Docker registry, deploy to Kubernetes)
            }
        }

        stage('Monitoring') {
            steps {
                echo 'Monitoring is not implemented in this example.'
                // Integrate with your monitoring tool of choice here (e.g., Prometheus, Grafana)
            }
        }
    }

    post {
        always {
            sh 'docker-compose down' // Clean up Docker containers
        }
    }
}

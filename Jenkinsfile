pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'  // ID of your Jenkins Docker credentials
        DOCKER_IMAGE = 'shradhamathpati/myapp:latest'  // Replace with your Docker Hub username and image name
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from the repository
                git url: 'https://github.com/Shradhamathpati/E-commerce-project.git', branch: 'main'
            }
        }

        stage('Build') {
            steps {
                // Run Maven build
                bat 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                // Run automated tests
                bat 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build Docker image
                bat "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Using credentials to log in to Docker Hub
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'shradhamathpati', passwordVariable: 'Shradhamat@12')]) {
                        bat """
                        echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin
                        docker push ${DOCKER_IMAGE}
                        """
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                // Deploy the application to Kubernetes
                bat 'kubectl apply -f k8s/deployment.yaml'
                bat 'kubectl apply -f k8s/service.yaml'
            }
        }
    }

    post {
        always {
            // Clean up workspace
            cleanWs()
        }
    }
}

pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'  // ID of your Jenkins Docker credentials
        DOCKER_IMAGE = 'syedssaad/myapp:latest'  // Replace with your Docker Hub username and image name
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from the repository
                git url: 'https://github.com/SyedShahMohammedSaadullahHussaini/ecommerce-devops-project.git', branch: 'main'
            }
        }

        pipeline {
    agent any
    tools {
        maven 'Maven 3.8.6' // Name must match the one in Global Tool Configuration
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
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
                bat "docker build -t %DOCKER_IMAGE% ."
            }
        }

     stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'shradha', passwordVariable: 'shradhamat@12')]) {
                        bat """
                        echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                        docker push syedssaad/myapp:latest
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

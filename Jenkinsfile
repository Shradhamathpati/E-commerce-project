pipeline {
    agent any

    tools {
        maven 'Maven-3.8.6' // Ensure Maven is configured in Jenkins
    }

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
        DOCKER_IMAGE = 'shradhamathpati/myapp:latest'
        JAVA_HOME = 'C:\\Path\\to\\Java\\jdk' // Set Java path if on Windows
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Shradhamathpati/E-commerce-project.git', branch: 'main'
            }
        }

        stage('Build') {
            steps {
                script {
                    try {
                        bat 'mvn clean package'
                    } catch (Exception e) {
                        echo "Build failed. Analyzing logs..."
                        error("Check Maven logs for details.")
                    }
                }
            }
        }

        stage('Test') {
            steps {
                bat 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
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
                bat 'kubectl apply -f k8s/deployment.yaml'
                bat 'kubectl apply -f k8s/service.yaml'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}

pipeline {

    agent any

    environment {
        DOCKER_IMAGE = "abdulwasaykp/time-tracker"
        DOCKER_TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Build & Test') {
            steps {
                sh '''
                    mvn clean package \
                    -DargLine="--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.reflect=ALL-UNNAMED"
                '''
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                    docker build \
                        -t ${DOCKER_IMAGE}:${DOCKER_TAG} \
                        -t ${DOCKER_IMAGE}:latest .
                '''
            }
        }

        stage('Docker Hub Push') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhubcred',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {
                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login \
                            -u "$DOCKER_USERNAME" \
                            --password-stdin

                        docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                        docker push ${DOCKER_IMAGE}:latest

                        docker logout
                    '''
                }
            }
        }

        stage('Docker Pull') {
            steps {
                sh '''
                    docker pull ${DOCKER_IMAGE}:${DOCKER_TAG}
                '''
            }
        }

        stage('Deploy to Ubuntu') {
    steps {
        sshagent(['ubuntu-deploy-key']) {
            sh '''
                ssh -o StrictHostKeyChecking=no osboxes@192.168.18.179 "
                    docker pull ${DOCKER_IMAGE}:${DOCKER_TAG} &&
                    docker rm -f time-tracker-app || true &&
                    docker run -d \
                        --name time-tracker-app \
                        -p 8081:8080 \
                        ${DOCKER_IMAGE}:${DOCKER_TAG}
                "
                        echo "Applications deployed  successfully with tomcat."
                        echo "URL: http://192.168.18.97:8081/time-tracker/"  
                  '''
            }
        }
    }
}



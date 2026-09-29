pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Build completed'
            }
        }

        stage('Test') {
            steps {
                echo 'Tests completed'
            }
        }
    }
}

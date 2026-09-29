pipeline {
    agent any

    environment {
        MAVEN_OPTS = '--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.reflect=ALL-UNNAMED'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/abdulwasaykp-source/time-tracker.git'
            }
        }

        stage('Build & Test') {
            steps {
                sh '''
                    mvn clean package \
                    -DargLine="--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.reflect=ALL-UNNAMED"
                '''
            }
        }

        stage('Verify WAR') {
            steps {
                sh '''
                    echo "Checking generated WAR file..."
                    ls -lh web/target/
                    test -f web/target/time-tracker-web-0.5.0-SNAPSHOT.war
                '''
            }
        }

        stage('Deploy') {
            steps {
                echo 'WAR build successful. Ready for Docker/Tomcat deployment.'
            }
        }
    }
}

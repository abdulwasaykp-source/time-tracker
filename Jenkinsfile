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
              sh '''
            docker rm -f time-tracker-app || true

            docker run -d \
              --name time-tracker-app \
              -p 8081:8080 \
              -v /var/lib/docker/volumes/jenkins_home/_data/workspace/2nd-pipline/web/target/time-tracker-web-0.5.0-SNAPSHOT.war:/usr/local/tomcat/webapps/time-tracker.war \
              tomcat:9.0

            echo "Applications deployed successfully."
            echo "URL: http://192.168.18.97:8081/time-tracker/"
        '''
         }
      }
    }
}

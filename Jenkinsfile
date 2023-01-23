pipeline {
        agent {
  label 'docker'
        } 

    stages {
        stage('Checkout Code') {
            steps {
           
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'sample-app']], userRemoteConfigs: [[url: 'https://github.com/digitalocean/sample-nodejs.git']]])
            }
        }
        stage('Build') {
            steps {
                    sh '''docker build . -t 127.0.0.1:8083/node:${BUILD_ID} '''
               
            }
        }
        stage('Test') {
            steps {
                sh 'docker run  --name node-test -itd -p 3000:3000 127.0.0.1:8083/node:${BUILD_ID} '
                sh 'curl localhost:3000'
                sh 'docker stop node-test'
                sh 'docker rm node-test'
   
            }
        }
        stage('Push to Docker Hub ') {
            steps {
                sh "docker push 127.0.0.1:8083/node:${BUILD_ID} "

            }
        }
    }
    post {
        always {
             chuckNorris()  
              
            }
        aborted {
             slackSend channel: '#general', message: 'build was aborted'
         }
        failure {
              slackSend channel: '#general', message: 'build is failing '
         }
        fixed {
          slackSend channel: '#general', message: 'someone fixed the build, now its ok.'
         }
    }

}

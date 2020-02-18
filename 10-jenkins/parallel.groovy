pipeline {
    agent none
    
    stages {
        stage('Run parallel'){
            parallel {
                stage('Hello') {
                    agent any
                    steps {
                        sh "echo Hello && sleep 10"
                    }
                }
                stage('World') {
                    agent any
                    steps {
                        sh "echo World && sleep 5"
                    }
                }
                stage('Number') {
                    agent any
                    steps {
                        sh "echo Number && sleep 7"
                    }
                }
            }
        }
    }
}

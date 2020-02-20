pipeline {
    agent none
    
    stages {
        stage('Run parallel'){
            parallel {
                stage('Hello1') {
                    agent any
                    steps {
                        sh "echo Hello && sleep 15"
                    }
                }
                stage('Hello2') {
                    agent any
                    steps {
                        sh "echo Hello && sleep 2"
                    }
                }
                stage('Hello3') {
                    agent any
                    steps {
                        sh "echo Hello && sleep 6"
                    }
                }
                stage('Hello') {
                    agent { label 'linux' }
                    steps {
                        sh "echo Hello && sleep 10"
                    }
                }
                stage('World') {
                    agent { label 'linux' }
                    steps {
                        sh "echo World && sleep 5"
                    }
                }
                stage('Number') {
                    agent { label 'linux' }
                    steps {
                        sh "echo Number && sleep 7"
                    }
                }
            }
        }
    }
}

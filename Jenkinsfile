pipeline {

    agent any

    environment {
        //once you create ACR in Azure cloud, use that here
        registryName = "socprojectacr"
        registryCredential = 'ACR'
        registryUrl = 'socprojectacr.azurecr.io'
        dockerImage = ''
    }

    tools {
        maven 'maven-3.8.7'
    }

    stages {

        stage ('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/tbarik1982/soc-capstone-bookstore.git']])
            }
        }

        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }

        stage ('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage ('Build Docker image') {
            steps {

                script {
                    dockerImage = docker.build registryName
                }
            }
        }

        // Uploading Docker images into ACR
        stage('Upload Image to ACR') {
             steps{
                 script {
                    docker.withRegistry( "http://${registryUrl}", registryCredential ) {
                    dockerImage.push()
                    }
                }
             }
        }

        stage("deploying the app"){
                sh "kubectl apply -f /inet/projects/kubernetes-deployment.yml"
        }
    }

}


node(){
    stage("git clone"){
       checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'GITHUB', url: 'https://github.com/Saiteju1997/Capstone-B19-bookstoreV1.0.git']]])      }
    stage('SonarQube analysis') {
        def scannerHome = tool 'Sonar-3.2';
        def mavenhome = tool  name: 'Maven2' , type: 'maven';
        withSonarQubeEnv('Sonar') {
        sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.3.0.603:sonar'
      }
    }    
    stage("build-upload artifacts"){
        def server = Artifactory.server 'jfrog'
        def rtMaven = Artifactory.newMavenBuild()
        rtMaven.resolver server: server, releaseRepo: 'libs-release', snapshotRepo: 'libs-snapshot'
        rtMaven.deployer server: server, releaseRepo: 'libs-release-local', snapshotRepo: 'libs-snapshot-local'
        rtMaven.tool = 'Maven2'
        def buildInfo = rtMaven.run pom: 'pom.xml', goals: 'clean package'
    }
    stage("copying required files"){
        sh "scp -o StrictHostKeyChecking=no target/*.war root@docker-master:/inet/projects"
        sh "scp -o StrictHostKeyChecking=no Dockerfile root@docker-master:/inet/projects"
        sh "scp -o StrictHostKeyChecking=no kubernetes-deployment.yml root@k8smaster:/inet/projects"
   }


    stage("Building the Docker image"){ 
        sh 'docker build -t bookstore.app.v1.$BUILD_ID /inet/projects'
        sh 'docker tag bookstore.app.v1.$BUILD_ID steju480/bookstore.app.v1.$BUILD_ID'
        sh 'docker tag bookstore.app.v1.$BUILD_ID steju480/bookstore.app.v1'
    }
    stage("Docker image push"){
        withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'password', usernameVariable: 'user')]) {
            sh "docker login -u ${user} -p ${password}"
            sh 'docker login -u steju480 -p Steju@1997'
            sh 'docker push steju480/bookstore.app.v1.$BUILD_ID'
            sh 'docker push steju480/bookstore.app.v1'
            sh 'docker rmi steju480/bookstore.app.v1.$BUILD_ID'
            sh 'docker rmi steju480/bookstore.app.v1' 
            sh 'docker rmi bookstore.app.v1.$BUILD_ID'
          }                        
      }  
     stage("deploying the app"){     
        sh 'aws eks --region <region-code> update-kubeconfig --name mycluster'
        sh "kubectl delete -f /inet/projects/kubernetes-deployment.yml"
        sh "kubectl create -f /inet/projects/kubernetes-deployment.yml"

}      

node {
    def registry = 'victorrosario/capstone-project'
    stage('Checking out git repo') {
      echo 'Checkout...'
      checkout scm
    }
    stage('Checking environment') {
      echo 'Checking environment...'
      sh 'git --version'
      echo "Branch: ${env.BRANCH_NAME}"
      sh 'docker -v'
    }
    stage("Linting") {
      echo 'Linting....'

      sh '/usr/bin/hadolint Dockerfile'
    }
    stage('Building image') {
	    echo 'Building Docker image...'
      withCredentials([usernamePassword(credentialsId: 'AWS_Creds', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
	     	sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
	     	sh "docker build -t ${registry} ."
	     	sh "docker tag ${registry} ${registry}"
	     	sh "docker push ${registry}"
      }
    }
    stage('Deploying') {
      echo 'Deploying to AWS...'
      dir ('./') {
        withAWS(credentials: 'aws-credentials', region: 'us-east-1') {
            sh "aws eks --region us-east-1 update-kubeconfig --name CapstoneEKS-VUUZkwHTDVPa"
            sh "kubectl apply -f AWS/aws-auth-cm.yaml"
            sh "kubectl set image deployments/capstone-app capstone-app=${registry}:latest"
            sh "kubectl apply -f AWS/capstone-app-deployment.yml"
            sh "kubectl get nodes"
            sh "kubectl get pods"
            sh "aws cloudformation update-stack --stack-name udacity-capstone-nodes --template-body file://AWS/worker_nodes.yml --parameters file://AWS/worker_nodes_parameters.json --capabilities CAPABILITY_IAM"
        }
      }
    }
    stage("Cleaning up") {
      echo 'Cleaning up...'
      sh "docker system prune"
    }
}
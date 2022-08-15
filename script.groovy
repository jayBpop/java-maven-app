def buildJar() {
    echo "Building the application"
    sh 'mvn clean'
    sh 'mvn install'
} 

def buildImage() {
    echo "Building Docker Image"
    sh 'docker build -t hdevop/myrepo:firstjavaapp-2.1 .'
    }

def pushImage(){
    echo "Pushing the image to docker hub"
    withCredentials([usernamePassword(credentialsId:'docker-hub-repo', passwordVariable:'password', usernameVariable:'username')])
            {
                  sh 'echo $password | docker login -u $username --password-stdin'
                  sh 'docker push hdevop/myrepo:firstjavaapp-2.1'
            }

}
def deployApp() {
    echo "deploying the application to the server successfully..."
} 

return this

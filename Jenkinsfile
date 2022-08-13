pipeline
{
    agent any
    
        tools{
              maven 'maven'
              jdk 'jdk8'
        }
        stages{
            stage("Maven packaging and creating jar"){
                steps{
                    script{
                        echo "Building the application"
                        sh 'mvn clean'
                        sh 'mvn package'
                    }

                }

            }
            stage("Building Docker Image"){
                steps{
                    script{
                        echo "Building Docker Image"
                        sh 'docker build -t hdevop/myrepo:firstjavaapp-2.0 .'
                    }
                }
            }
            stage("Pushing the image to Docker hub"){
                steps{
                    script{
                        echo "Pushing the image to docker hub"
                        withCredentials([usernamePassword(credentialsId:'docker-hub-repo', passwordVariable:'password', usernameVariable:'username')])
                        sh 'echo $password | docker login -u $username --password-stdin'
                        sh 'docker push hdevop/myrepo:firstjavaapp-2.0'
                    }
                }
            }
            stage("Deploying to the server") {
                steps{
                    script{
                        echo "Deployed the application to the server"
                    }
                }
            }
        }
    
}
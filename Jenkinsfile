
@Library ('jenkins-shared-library')

def gv
pipeline
{
    agent any
    
        tools{
              maven 'maven'
              jdk 'jdk8'
        }
        stages{
              stage("Init"){
                 steps{
                     script{
                        gv = load "script.groovy"
                     }
                 }
              }

            stage("Maven packaging and creating jar"){
                steps{
                    script{
                       buildJar()
                    }

                }

            }
            stage("Building Docker Image"){
                steps{
                    script{
                            buildDockerImage()
                    }
                }
            }
            stage("Pushing the image to Docker hub"){
                steps{
                    script{
                            pushDockerImage()
                    }
                }
            }
            stage("Deploying to the server") {
                steps{
                    script{
                       gv.deployApp()
                    }
                }
            }
        }
    
}

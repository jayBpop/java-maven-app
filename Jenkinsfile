
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
                            buildDockerImage 'hdevop/myrepo:jsl_java_app-2.0'
                    }
                }
            }
            stage("Pushing the image to Docker hub"){
                steps{
                    script{
                            pushDockerImage 'hdevop/myrepo:jsl_java_app-2.0'
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

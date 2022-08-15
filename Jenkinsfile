#!/usr/bin/env groovy

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
                       gv.buildJar()
                    }

                }

            }
            stage("Building Docker Image"){
                steps{
                    script{
                            gv.buildDockerImage()
                    }
                }
            }
            stage("Pushing the image to Docker hub"){
                steps{
                    script{
                            gv.pushDockerImage()
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

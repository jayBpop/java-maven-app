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
            stage("App versioning as per automatic job build"){
                steps{
                    script{
                        gv.appVersion()
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
                            gv.buildImage()
                    }
                }
            }
            stage("Pushing the image to Docker hub"){
                steps{
                    script{
                            gv.pushImage()
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
            stage("Commit version update from jenkins to app !...."){
                steps{
                    script{
                        gv.versionCommit()
                    }
                }
            }
        }
    
}

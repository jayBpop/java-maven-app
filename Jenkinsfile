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
            stage("Provision server"){
                environment{
                    AWS_ACCESS_KEY_ID = credentials('jenkins_aws_access_key_id')
                    AWS_SECRET_KEY_ID= credentials('jenkins_aws_secret_key_id')
                    TF_VAR_env_prefix ='test'
                } 
                steps{
                    script{
                        dir('terraform'){
                        sh "terraform init"
                        sh "terraform apply --auto-approve"
                        
                        EC2_PUBLIC_IP =sh(
                            script: "terraform output app-server-ip",
                            returnStdout: true)
                            .trim()
                        }
                            
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

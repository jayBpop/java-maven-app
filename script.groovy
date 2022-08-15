def appVersion() {
    echo "Versioning the application automatically!!..."
    sh 'mvn build-helper:parse-version versions:set \
                        -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} \
                        versions:commit'

     def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                    def version = matcher[0][1]
                    env.IMAGE_NAME = "$version-$BUILD_NUMBER"

}
def buildJar() {
    echo "Building the application"
    sh 'mvn clean'
    sh 'mvn package'
} 

def buildImage() {
    echo "Building Docker Image"
    sh "docker build -t hdevop/myrepo:${IMAGE_NAME} ."
    }

def pushImage(){
    echo "Pushing the image to docker hub"
    withCredentials([usernamePassword(credentialsId:'docker-hub-repo', passwordVariable:'password', usernameVariable:'username')])
            {
                  sh 'echo $password | docker login -u $username --password-stdin'
                  sh "docker push hdevop/myrepo:${IMAGE_NAME}"
            }

}
def deployApp() {
    echo "deploying the application to the server successfully...!!!"
    echo "testing webhook!!!!!"
} 
def versionCommit() {
    echo "Commit updated version to repo...."
    withCredentials([usernamePassword(credentialsId: 'git-hub-id', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        // git config here for the first time run
                        sh 'git config --global user.email "captainsparrow560@gmail.com"'
                        sh 'git config --global user.name "jayBpop"'

                        sh "git remote set-url origin https://${USER}:${PASS}@https://github.com/jayBpop/java-maven-app.git"
                        sh 'git add .'
                        sh 'git commit -m "ci: version bump"'
                        sh 'git push origin HEAD:main'
                    }


}
return this

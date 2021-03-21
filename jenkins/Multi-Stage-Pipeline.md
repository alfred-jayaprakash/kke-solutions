# Jenkins Multi Stage Pipeline
## Introduction
Following up on the [Single stage pipeline](./Single-Stage-Pipeline.md), this task involves setting up a multi-stage build pipeline. The pipeline need to have 2 stages:
* Deploy stage - Pulls code from GIT repo and pushes to a directory on the storage server
* Test stage - Tests that that code push was successfully by running some commands

## Solution
### Step 1: Install the required plugins in Jenkins
* `Select port to view on Host 1` and connect to port `8081`. Login using the Jenkins admin user and password given in the question
* Under  `Jenkins > Manage Jenkins >  Manage Plugins` click `Available` and search for `GIT` plugin.
* Select the `GIT` plugin and click `Download now and install after restart`
* In the following screen, click checkbox `Restart Jenkins when installation is complete and no jobs running`. Wait for the screen to become standstill.
* You can try to refresh your browser after a few secs.
* Repeat the above steps and install `Pipeline` and `SSH Pipeline Steps` plugins also
* Note that you can seach for multiple plugins, select them and finally click `Download now and install after restart`. When you select one and search for the next one, the previous one disappears. But it is still selected behind-the-scenes and gets installed along when you click `Download now and install after restart`

### Step 2: Setup Credentials for GIT user
* Under `Jenkins > Manage Jenkins > Manage Credentials`, click `Global` under `Stores scoped to Jenkins` and `Add Credentials`
* Leave kind as `Username with Password` and Scope as `Global (..)`
* Setup GIT credentials for Sarah:
```
Username: sarah
Password: Sarah_pass123
ID: GIT_CREDS
```

### Step 3: Create a Pipeline Job
* Click `New item` and in the following screen create a job as per question:
```
Name: datacenter-webapp-job (Select 'Pipeline' - Don't select 'Multibranch pipeline') and click Ok
```
* Under `Pipeline`, make sure definition is `Pipeline script`
* In the `Script` text area provide the following (change the `git url` under `Deploy` stage and `appserver ports` under `Test` stage according to the question):
```groovy
//
// Setup up the Remote connection for SSH Build Pipeline step
//
def remote = [:]
remote.name = 'ststor01'
remote.host = 'ststor01'
remote.user = 'natasha'
remote.password = 'Bl@kW'
remote.allowAnyHosts = true   
            
pipeline {
    // Run on agent with label 'ststor01'
    agent { label 'ststor01' }

    // Pipeline stages 
    stages {
        // Deploy stage
        stage('Deploy') {
            steps {
                echo 'Deploying ...'
                // Connect to GIT and download the repo code
                // Use the Jenkins Credentials by ID: GIT_CREDS
                git credentialsId: 'GIT_CREDS', url: 'http://git.stratos.xfusioncorp.com/sarah/web.git'
                // Transfer all the files we downloaded to /tmp of ststor01
                sshPut remote: remote, from: '.', into: '/tmp'
                // Finally move all the files from /tmp to /data on ststor01
                sshCommand remote: remote, command: "mv -f /tmp/${JOB_NAME}/* /data"
            }
        }

        // Test stage
        stage('Test') {
            environment {
                // Update the below value as per the text given in question
                INDEX_CONTENT = 'Welcome to xFusionCorp Industries'
            }

            steps {
                // Now test that the content from default page from HTTPD on each 
                // of the appservers is same as the index.html content required as
                // per question
                sh '((curl http://stapp01:8080/ | grep -F "$INDEX_CONTENT") && true)'
                sh '((curl http://stapp02:8080/ | grep -F "$INDEX_CONTENT") && true)'
                sh '((curl http://stapp03:8080/ | grep -F "$INDEX_CONTENT") && true)'
            }
        }
    }
}
```
TODO: Improve above code by not hardcoding the remote password
* Click `Save`

### Step 5: Commit changes to index.html
* SSH to ststor01 using SSH user `sarah`
* Change to `/home/sarah/web`
* Edit `index.html` as per the question
```html
Welcome to xFusionCorp Industries
```
* Commit the file using the following steps:
```
git add index.html
git commit -m "updated"
git push origin master
```

### Verification
* Click the newly created Pipeline Job and click `Build Now`
* You should see a new build getting triggered and completed successfully
* Check the `Console Output` to check whether files were pulled from GIT repo and transferred to `ststor01` sucessfully. Also the `Test` stage should report successful test.
* Access LB URL: `Select port to view on Host 1` and connect to port `80`
  * You should see index page with your changes

## Addendum
While the `Test` stage here is specific to the question, in real world, a more robust solution would've been to check that the content from GIT is same as the content served from Apache servers. This would've been the best way to check that the `Deploy` stage was successful

In other words, if deployment fails, the test stage fails regardless of the content of `index.html`.

The following is a more robust version of the code, which however will get failed by KKE Verification process as the verification process is expecting the code to only work when the `index.html` content is `Welcome to xFusionCorp Industries`:
```groovy
// Test stage
stage('Test') {
    environment {
        // Store the index.html content we received from GIT in a variable
        INDEX_CONTENT = sh(script: 'cat index.html', , returnStdout: true).trim()
    }
    
    steps {
        sh 'echo "Content from GIT: $INDEX_CONTENT"'
        // Now test that the content from default page from HTTPD on each 
        // of the appservers is same as the index.html content from GIT
        sh '((curl http://stapp01:8080/ | grep -F "$INDEX_CONTENT") && true)'
        sh '((curl http://stapp02:8080/ | grep -F "$INDEX_CONTENT") && true)'
        sh '((curl http://stapp03:8080/ | grep -F "$INDEX_CONTENT") && true)'
    }
}
```

---
For tips on getting better at KodeKloud Engineer Jenkins tasks, [click here](./README.md)
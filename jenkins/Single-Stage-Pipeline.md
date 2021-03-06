# Jenkins Single Stage Pipeline
## Introduction
This task involves setting up a single-stage build pipeline. There are 2 key steps:
* Setup a Slave Node on ststor01. Easiest way is to install Java on ststor01 and then use [SSH Build Agents](https://plugins.jenkins.io/ssh-slaves/) plugin to automatically setup the Agent from the Jenkins UI via SSH.
* Create a Build Pipeline that pulls code from a GIT Repo and pushes it to a directory on the storage server. Here, you can use [SSH Pipeline Steps](https://www.jenkins.io/doc/pipeline/steps/ssh-steps/) and [GIT](https://www.jenkins.io/doc/pipeline/steps/git/) plugins to implement the pipeline steps.

**Tip:** You can use [Pipeline Snippet Generator](https://www.jenkins.io/doc/book/pipeline/getting-started/#snippet-generator) to generate the pipeline code by selecting GIT or SSH in the dropdown and providing required values. [Pipeline Snippet Generator](https://www.jenkins.io/doc/book/pipeline/getting-started/#snippet-generator) can be accessed by clicking the link `Pipeline Syntax` on your  Pipeline Job page in the `Pipeline` section. 

## Solution
### Step 1: Install the required plugins in Jenkins
* `Select port to view on Host 1` and connect to port `8081`. Login using the Jenkins admin user and password given in the question
* Under  `Jenkins > Manage Jenkins >  Manage Plugins` click `Available` and search for `Pipeline` plugin.
* Select the `GIT` plugin and click `Download now and install after restart`
* In the following screen, click checkbox `Restart Jenkins when installation is complete and no jobs running`. Wait for the screen to become standstill.
* You can try to refresh your browser after a few secs.
* Repeat the above steps and install `Pipeline`, `SSH Build Agents` and `SSH Pipeline Steps` plugins also
* Note that you can seach for multiple plugins, select them and finally click `Download now and install after restart`. When you select one and search for the next one, the previous one disappears. But it is still selected behind-the-scenes and gets installed along when you click `Download now and install after restart`

### Step 2: Add a new Slave Node
* SSH to storage server i.e. ststor01 using `natasha` and install Java: `yum install -y java`
* In Jenkins Admin Console, add a new slave node under  `Jenkins > Manage Jenkins >  Manage Nodes and Clouds > New Node`
* Provide following values
```
Node Name: Storage Server
(Permanent Agent)
Remote root directory: /home/natasha
Labels: ststor01
Launch Method: Launch Agents via SSH
```
* Additional options will be revealed. Configure as follows:
```
Host: ststor01
Credentials: natasha (Add on-the-fly by clicking 'Add Button > Jenkins' and configuring natasha's credentials)
Host Key Verification Strategy: Non verifying Verification Strategy
```
* Click `Save`
* Wait for a few seconds for the agent to be configured
* Refresh the nodes list. You should see the newly added `Storage Server` displayed with all system statistics. This means the node setup was successful.

### Step 3: Setup Credentials for GIT user
* Under `Jenkins > Manage Jenkins > Manage Credentials`, click `Global` under `Stores scoped to Jenkins` and `Add Credentials`
* Leave kind as `Username with Password` and Scope as `Global (..)`
* Setup GIT credentials for Sarah:
```
Username: sarah
Password: Sarah_pass123
ID: GIT_CREDS
```

### Step 4: Create a Pipeline Job
* Click `New item` and in the following screen create a job as per question:
```
Name: datacenter-webapp-job (Select 'Pipeline' - Don't select 'Multibranch pipeline') and click Ok
```
* Under `Pipeline`, make sure definition is `Pipeline script`
* In the `Script` text area provide the following:
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
                // Connect to GIT and download the repo code
                // Use the Jenkins Credentials by ID: GIT_CREDS
                git credentialsId: 'GIT_CREDS', url: 'http://git.stratos.xfusioncorp.com/sarah/web_app.git'
                // Transfer all the files we downloaded to /tmp of ststor01
                sshPut remote: remote, from: '.', into: '/tmp'
                // Finally move all the files from /tmp to /data on ststor01
                sshCommand remote: remote, command: "mv -f /tmp/${JOB_NAME}/* /data"
            }
        }
    }
}
```
TODO: Improve above code by not hardcoding the remote password
* Click `Save`
* Click the newly created Pipeline Job and click `Build Now`
* You should see a new build getting triggered and completed successfully
* Check the `Console Output` to check whether files were pulled from GIT repo and transferred to `ststor01` sucessfully
* Go to back to the terminal and check that you see a `index.html` under `/data` folder of the storage server

### Step 5: Commit changes to index.html
* SSH to ststor01 using SSH user `sarah`
* Change to `/home/sarah/web_app`
* Edit `index.html` as per the question
```html
Welcome to the Nautilus Industries
```
* Commit the file using the following steps:
```
git add index.html
git commit -m "updated"
git push origin master
```
### Verification
* Click the newly created Pipeline Job again and click `Build Now`
* You should see a new build getting triggered and completed successfully
* Check the `Console Output` to check whether files were pulled from GIT repo and transferred to `ststor01` sucessfully
* Access LB URL: `Select port to view on Host 1` and connect to port `80`
  * You should see index page with your changes

---
For tips on getting better at KodeKloud Engineer Jenkins tasks, [click here](./README.md)
# Jenkins Single Stage Pipeline
## Solution
### Step 1: Add a new Slave Node
* `Select port to view on Host 1` and connect to port `8081`. Login using the Jenkins admin user and password given in the question
* Under  `Jenkins > Manage Jenkins >  Manage Nodes and Clouds > New Node`
* Provide following values
```
Node Name: Storage Server
(Permanent Agent)
Remote root directory: /home/natasha
Labels: ststor01
```
* Click `Save`
* TODO: Need to add the steps to setup Slave node

### Step 2: Install the required plugins in Jenkins
* Under  `Jenkins > Manage Jenkins >  Manage Plugins` click `Available` and search for `Pipeline` plugin.
* Select the `Pipeline` plugin and click `Download now and install after restart`
* In the following screen, click checkbox `Restart Jenkins when installation is complete and no jobs running`. Wait for the screen to become standstill.
* You can try to refresh your browser after a few secs.
* Repeat the above steps and install `GIT`, `SSH Pipeline Steps` plugins also

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
def remote = [:]
remote.name = 'ststor01'
remote.host = 'ststor01'
remote.user = 'natasha'
remote.password = 'Bl@kW'
remote.allowAnyHosts = true   
            
pipeline {
    agent any
     
    stages {
        stage('Deploy') {
            steps {
                git credentialsId: 'GIT_CREDS', url: 'http://git.stratos.xfusioncorp.com/sarah/web_app.git'
                sshPut remote: remote, from: '.', into: '/tmp'
                sshCommand remote: remote, command: "mv -f /tmp/${JOB_NAME}/* /data"
            }
        }
    }
}

```
* Click `Save`
* Click the newly created Pipeline Job and click `Build Now`
* You should see a new build getting triggered and completed successfully
* Check the `Console Output` to check whether files were pulled from GIT repo and transferred to `ststor01` sucessfully
* Go to back to the terminal and check that you see a `index.html` under `/data` folder of the storage server

### Step 5: Commit changes to index.html
* SSH to ststor01 using SSH user `sarah`
* Change to `/home/sarah/web`
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
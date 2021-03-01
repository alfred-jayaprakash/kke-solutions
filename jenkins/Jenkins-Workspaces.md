# Jenkins Workspaces
## Solution
### Step 1: Install Gitea and Publish over SSH Plugins in Jenkins
* `Select port to view on Host 1` and connect to port `8081`. Login using the Jenkins admin user and password given in the question
* Under  `Jenkins > Manage Jenkins >  Manage Plugins` click `Available` and search for `Gitea` plugin.
* Select the plugin and click `Download now and install after restart`
* In the following screen, click checkbox `Restart Jenkins when installation is complete and no jobs running`. Wait for the screen to become standstill.
* You can try to refresh your browser after a few secs.
* Repeat the above steps and install `Publish over SSH` plugins also

### Step 2: Setup Credentials for GIT user
* Under `Jenkins > Manage Jenkins > Manage Credentials`, click `Global` under `Stores scoped to Jenkins` and `Add Credentials`
* Leave kind as `Username with Password` and Scope as `Global (..)`
* Setup GIT credentials for Sarah:
```
Username: sarah
Password: Sarah_pass123
ID: sarah
```

### Step 3: Configure Publish Over SSH
* In same page i.e. `Jenkins > Manage Jenkins > Configure System` under `Publish over SSH > SSH Servers` click `Add` and provide the following values:
```
Name: ststor01
Hostname: ststor01
Username: natasha
Remote Directory: /data
(Click Advanced and select 'Use Password authentication...')
Passphrase/Password: Bl@kW
```
* Click `Test Configuration` to test that the connection is successful

### Step 4: Copy GIT Repo URL
* `Select port to view on Host 1` and connect to port `8000`. Login using the GITEA user and password given in the question e.g. Sarah
* Click the repo `sarah/web` on the right side
* Copy the GIT Clone HTTP URL (next to the clipboard icon). Usually it looks like `http://git.stratos.xfusioncorp.com/sarah/web.git`

### Step 5: Verify Permissions for /data directory
* SSH to `ststor01` using `natasha` 
* Grant full permissions to `/data` folder: `sudo chmod 777 /data`

### Step 6: Create a Parameterized Build
* `Select port to view on Host 1` and connect to port `8081`. Login using the Jenkins admin user and password given in the question
* Click `New item` and in the following screen:
```
Name: app-job (Keep 'Freestyle Project' as selected) and click Ok
```
#### Configure Choice Parameter
* Under `General` click the option `This project is parameterized`
* This will reveal additional option `Add Parameter`
* Click `Add Parameter > Choice Parameter` and input the following values as per question:
```
Name: Branch
Choices:
version1
version2
version3
```
#### Configure Custom Workspace based on Choice Parameter
* Click `Advanced` and select `Choose custom workspace`
* Give the directory as `$JENKINS_HOME/$Branch`

#### Configure GIT Branch based on Choice Parameter
* Under `Source Code Management` click the option `Git`
* This will reveal additional options. Configure as follows:
```
Repository URL: http://git.stratos.xfusioncorp.com/sarah/web.git
Credentials: sarah/*****
```
* Set the `Branches to Build` to the value i.e. `*/$Branch`

#### Configure SSH transfer to Storage server
* Under `Build Environment` click `Send files or execute commands over SSH after the build runs`. It reveals additional options to configure `Transfer`:
```
Source files: **/*
```
* Click `Save`

### Verification
* Click the newly created Job and click `Build With Parameters`
* Choose any of the values from the drop-down e.g. `version1`
* You should see a new build getting triggered and complete successfully.
* Check the `Console Output` to see that `SSH: Transferred 1 file(s)`
* Go to back to the terminal and check that you see a `index.html` under `/data` folder of the storage server
* Access LB URL: `Select port to view on Host 1` and connect to port `80`
  * You should see index page with your changes
---
For tips on getting better at KodeKloud Engineer Jenkins tasks, [click here](./README.md)
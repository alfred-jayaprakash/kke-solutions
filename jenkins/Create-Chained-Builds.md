# Create Chained Builds in Jenkins
## Solution
### Step 1: Install Gitea and SSH Plugins in Jenkins
* `Select port to view on Host 1` and connect to port `8081`. Login using the Jenkins admin user and password given in the question
* Under  `Jenkins > Manage Jenkins >  Manage Plugins` click `Available` and search for `Gitea` plugin.
* Select the plugin and click `Download now and install after restart`
* In the following screen, click checkbox `Restart Jenkins when installation is complete and no jobs running`. Wait for the screen to become standstill.
* You can try to refresh your browser after a few secs.
* Repeat the above steps and install `SSH` and `Publish over SSH` plugins also

### Step 2: Setup Credentials for GIT and SSH user
* Under `Jenkins > Manage Jenkins > Manage Credentials`, click `Global` under `Stores scoped to Jenkins` and `Add Credentials`
* Leave kind as `Username with Password` and Scope as `Global (..)`
* Setup credentials for Sarah:
```
Username: sarah
Password: Sarah_pass123
ID: Sarah
```
* Same way, add credentials for natasha (sudo user for Storage server):
```
Username: natasha
Password: Bl@kW
ID: natasha
```
### Step 3: Add SSH Hosts in Jenkins
* Click `Jenkins > Manage Jenkins > Configure System`
* Under `SSH Remote Hosts` click `Add Host` and provide the following values:
```
Hostname: ststor01
Port: 22
Credentials: Choose 'natasha' from the list
Pty: Select checkbox
```

### Step 4: Configure Publish Over SSH
* Click `Jenkins > Manage Jenkins > Configure System`
* Under `Publish over SSH > SSH Servers` click `Add` and provide the following values:
```
Name: ststor01
Hostname: ststor01
Username: natasha
(Click Advanced and select 'Use Password authentication...')
Passphrase/Password: Bl@kW
```
* Click `Test Configuration` to test that the connection is successful

### Step 4: Copy GIT Repo URL
* `Select port to view on Host 1` and connect to port `8000`. Login using the GIT user and password given in the question e.g. Sarah
* Click the repo `Sarah/web`
* Copy the GIT Clone HTTP URL (next to the clipboard icon). Usually it looks like `http://git.stratos.xfusioncorp.com/sarah/web.git`

### Step 5: Create Build Job
* Go back to Jenkins Console
* Click `New item` and in the following screen:
```
Name: nautilus-app-deployment (Keep 'Freestyle Project' as selected) and click Ok
```
* Under `General > Source Code Management` click the option `Git`
* This will reveal additional options. Configure as follows:
```
Repository URL: http://git.stratos.xfusioncorp.com/sarah/web.git
Credentials: sarah/*****
```
* Leave the `Branches to Build` to the default value i.e. `*/master`
* Now under `Build Triggers`, click `Trigger builds remotely..`. For Authentication Token, you can given a value as `KODEKLOUDENGINEER`

* Note down the Jenkins URL and create a Build Hook URL based on that. Build HOOK URL will be: `JENKINS_URL/job/nautilus-app-deployment/build?token=TOKEN_NAME`
e.g. `https://xxxx.katacoda.com/job/nautilus-app-deployment/build?token=KODEKLOUDENGINEER`

* Click `Build > Add Build Step > Send files or execute commands over SSH`. It reveals additional options to configure `Transfer`:
```
Source files: **/*
Remote Directory: /data
```

### Step 5: Setup Gitea Webhooks
* Go back to Gitea UI
* Click the repo settings (Spanner Icon) and click the `Webhooks` tab. Click `Add Webook > Gitea`
* Under Target URL, copy paste the URL that you copied in the previous step

## Verification
* Click that build and click `Console Output` and verify that the `echo` command is printing the correct values for `env` and `Stage` parameter. You should see something like:
```
Running as SYSTEM
Building in workspace /var/jenkins_home/workspace/parameterized-job
[parameterized-job] $ /bin/sh -xe /tmp/jenkins6109190682713673426.sh
+ echo Build Development
Build Development
Finished: SUCCESS
```
---
For tips on getting better at KodeKloud Engineer Jenkins tasks, [click here](./README.md)
# Create Chained Builds in Jenkins
## Introduction
This is, by far, one of the longest tasks that I have completed so far. Given the sheer number of steps involved, it took me around 25 minutes to complete all the steps, thereby forefeiting my bonus points. I don't regret though.

This task is quite similar to, but has more steps than, [Deployment using Jenkins](./Deployment-Using-Jenkins.md) task.

The task involves the following 3 key steps:
1. Create a Jenkins build job that pulls _all_ files from a GIT repo and pushes to a directory on the storage server. To achieve this, you need to install [Gitea](https://plugins.jenkins.io/gitea/) and [Publish over SSH](https://plugins.jenkins.io/publish-over-ssh/) plugins in Jenkins
2. Task expects that when a file is committed to the GIT repo, the above build is automatically trigger. This requires enabling a [Webhook](https://en.wikipedia.org/wiki/Webhook) on the Build job and setting up this Webhook on the Gitea UI. You need to also install [Build Authorization Token Root](https://plugins.jenkins.io/build-token-root/) plugin in Jenkins to allow Gitea to trigger the Jenkins build without authenticating
3. Finally, the task expects you to create another Jenkins build job that can run SSH commands on the appservers and restart the 'httpd' service. For this, you need to install [SSH](https://plugins.jenkins.io/ssh) plugin and also enable 'password-less sudo' on all the appservers. Most importantly, this build job should get triggered automatically by the first build job.

Happy learning and good luck with your attempt!

## Solution
### Step 1: Enable password-less sudo in all appservers
* SSH to each of the appserver and run `sudo visudo`
* In the resulting file, at the end of the file add password-less sudo for respective sudo user:
stapp01:
```
tony ALL=(ALL) NOPASSWD: ALL
```
stapp02:
```
steve ALL=(ALL) NOPASSWD: ALL
```
stapp03:
```
banner ALL=(ALL) NOPASSWD: ALL
```

### Step 2: Install Gitea and SSH Plugins in Jenkins
* `Select port to view on Host 1` and connect to port `8081`. Login using the Jenkins admin user and password given in the question
* Under  `Jenkins > Manage Jenkins >  Manage Plugins` click `Available` and search for `Gitea` plugin.
* Select the plugin and click `Download now and install after restart`
* In the following screen, click checkbox `Restart Jenkins when installation is complete and no jobs running`. Wait for the screen to become standstill.
* You can try to refresh your browser after a few secs.
* Repeat the above steps and install `Build Authorization Token Root`, `SSH` and `Publish over SSH` plugins also
* Note that you can seach for multiple plugins, select them and finally click `Download now and install after restart`. When you select one and search for the next one, the previous one disappears. But it is still selected behind-the-scenes and gets installed along when you click `Download now and install after restart`

### Step 3: Setup Credentials for GIT and SSH users
* Under `Jenkins > Manage Jenkins > Manage Credentials`, click `Global` under `Stores scoped to Jenkins` and `Add Credentials`
* Leave kind as `Username with Password` and Scope as `Global (..)`
* Setup GIT credentials for Sarah:
```
Username: sarah
Password: Sarah_pass123
ID: sarah
```
* Same way, add SSH credentials for tony, steve, banner (sudo users for the respective servers):
```
Username: tony
Password: Ir0nM@n
ID: tony
```
### Step 4: Add SSH Hosts in Jenkins
* Click `Jenkins > Manage Jenkins > Configure System`
* Under `SSH Remote Hosts` click `Add Host` and provide the following values:
```
Hostname: stapp01
Port: 22
Credentials: Choose 'tony' from the list
Pty: Select checkbox
```
* Click `Check Connection` to make sure connection is successful
* Repeat steps to add stapp02 and stapp03 hosts

### Step 5: Configure Publish Over SSH
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

### Step 6: Copy GIT Repo URL
* `Select port to view on Host 1` and connect to port `8000`. Login using the GITEA user and password given in the question e.g. Sarah
* Click the repo `sarah/web` on the right side
* Copy the GIT Clone HTTP URL (next to the clipboard icon). Usually it looks like `http://git.stratos.xfusioncorp.com/sarah/web.git`

### Step 7: Create Upstream Build Job
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
* Now under `Build Triggers`, click `Trigger builds remotely..`. For Authentication Token, you can give the value as `KODEKLOUDENGINEER`
* Note down the Jenkins URL and separately create a Webhook URL based on the URL. Webhook URL will be in the form `<JENKINS_URL>/buildByToken/build?job=NAME&token=SECRET`
e.g. `https://xxxx.katacoda.com/buildByToken/build?job=nautilus-app-deployment&token=KODEKLOUDENGINEER`
* Under `Build Environment` click `Send files or execute commands over SSH after the build runs`. It reveals additional options to configure `Transfer`:
```
Source files: **/*
```
Note: `**/*` file pattern ensures that the build job pulls all files from the repo and pushes them to the storage server and not just the index.html
* Click `Save`
* Click the newly created Job and click `Build Now`
* You should see a new build getting triggered and complete successfully.
* Check the `Console Output` to see that `SSH: Transferred 1 file(s)`
* Go to back to the terminal and check that you see a `index.html` under `/data` folder of the storage server

### Step 8: Setup Gitea Webhooks
* Go back to Gitea UI
* Click the settings under the repository (Spanner Icon) and click the `Webhooks` tab. Click `Add Webook > Gitea`
* Under Target URL, copy paste the URL that you copied in the previous step i.e. `https://xxxx.katacoda.com/buildByToken/build?job=nautilus-app-deployment&token=KODEKLOUDENGINEER`
* Click `Add Webhook`
* Click the webhook again and click `Test delivery` to check the hook works. This will send a fake event to Jenkins
* Go back to Jenkins UI and check if a new build is triggered under `nautilus-app-deployment` job
* This means the hook works fine

### Step 9: Create Downstream Build Job
* Go back to Jenkins Console
* Click `New item` and in the following screen:
```
Name: manage-services (Keep 'Freestyle Project' as selected) and click Ok
```
* Under `Build Triggers` click `Build after other projects are builds`. It reveals additional options to configure `Projects to Watch`:
```
Projects to Watch: nautilus-app-deployment
Trigger only if Build is stable (default)
```
* Under `Build` add a `Build Step` with `Execute shell script on remote host using SSH`
and under `SSH Site` select `tony@stapp01:22`
* In the command text area, provide the following:
```
sudo systemctl restart httpd
sudo systemctl status httpd
```
* Repeat the above steps to add host and commands `steve@stapp02:22` and `banner@stapp03:22` as well
* Click `Save`
* Click the newly created Job and click `Build Now`
* You should see a new build getting triggered and complete successfully.
* Check the `Console Output` to see that the restart service commands ran without any issues

### Step 10: Commit changes to index.html
* SSH to ststor01 using SSH user `sarah`
* Change to `/home/sarah/web`
* Edit `index.html` as per the question
```html
Welcome to the xFusionCorp Industries
```
* Commit the file using the following steps:
```
git add index.html
git commit -m "updated"
git push origin master
```

## Verification
* Check in Jenkins UI. You should see a `nautilus-app-deployment` build triggered followed by a `manage-services` build triggered
* Check the `Console Output` of both jobs to make sure the build steps were completed successfully without any failures
* Go to back to the terminal and check that you see the new `index.html` under `/data` folder of the storage server
* Access LB URL: `Select port to view on Host 1` and connect to port `80`
  * You should see index page with your changes
* In the terminal of storage server, create another new HTML file,`panda.html`, with any sample content to your liking. Commit this file in to the remote repo.
* Check once again in Jenkins UI. You should see a `nautilus-app-deployment` build triggered followed by a `manage-services` build triggered
* Check the `Console Output` of both jobs to make sure the build steps were completed successfully without any failures
* You should also now see the new `panda.html` under `/data` directory of the storage server
* Back on the LB URL, check if you can see the bobby.html page: `<LB URL>/panda.html`

---
For tips on getting better at KodeKloud Engineer Jenkins tasks, [click here](./README.md)
# Create Scheduled Builds in Jenkins
## Introduction
The task expects you to copy log files from one of the appserver to a location on storage server on a particular schedule e.g. Every 11 minutes. 

To accomplish this, you need to setup password-less sudo and password-less SSH (using SSH keys) first. Then you need to setup a Scheduled Build Job that copies files from appserver to the '/tmp' folder on the storage server. Then move the files from '/tmp' folder to the actual location.

## Solution
### Step 1: Enable password-less sudo in the specific appserver and ststor01
* SSH to the specific appserver mentioned in question and run `sudo visudo`
* In the resulting file, at the end of the file add password-less sudo for respective sudo user:
stapp03:
```
tony ALL=(ALL) NOPASSWD: ALL
```
* Repeat the above steps to enable 'passwordless-sudo' for natasha in ststor01

### Step 2: Enable password-less SCP in the specific appserver
* SSH to the specific appserver mentioned in question
* Run the following commands to enable password-less SCP:
```
sudo su
ssh-keygen -t rsa (leave all options to their defaults)
ssh-copy-id natasha@ststor01
```
* Repeat the above steps to enable 'passwordless-sudo' for natasha in ststor01

### Step 3: Install SSH Plugins in Jenkins
* `Select port to view on Host 1` and connect to port `8081`. Login using the Jenkins admin user and password given in the question
* Under  `Jenkins > Manage Jenkins >  Manage Plugins` click `Available` and search for `SSH` plugin.
* Select the `SSH` plugin and click `Download now and install after restart`
* In the following screen, click checkbox `Restart Jenkins when installation is complete and no jobs running`. Wait for the screen to become standstill.
* You can try to refresh your browser after a few secs.

### Step 4: Setup Credentials for SSH users
* Under `Jenkins > Manage Jenkins > Manage Credentials`, click `Global` under `Stores scoped to Jenkins` and `Add Credentials`
* Leave kind as `Username with Password` and Scope as `Global (..)`
* Add SSH credentials for the sudo users of the respective servers (banner and natasha):
```
Username: banner
Password: BigGr33n
ID: banner
```
### Step 5: Add SSH Hosts in Jenkins
* Click `Jenkins > Manage Jenkins > Configure System`
* Under `SSH Remote Hosts` click `Add Host` and provide the following values:
```
Hostname: stapp03
Port: 22
Credentials: Choose 'banner' from the list
Pty: Select checkbox
```
* Click `Check Connection` to make sure connection is successful
* Repeat steps to ststor01 host

### Step 6: Create a Scheduled Build Job
* Go back to Jenkins Console
* Click `New item` and in the following screen:
```
Name: copy-logs (Keep 'Freestyle Project' as selected) and click Ok
```
* Under `Build Triggers`, select `Build Periodically` and provide the `Schedule` as per the question:
```
*/11 * * * *
```
* Now, under `Build`, add a `Build Step` with `Execute shell script on remote host using SSH`
and under `SSH Site` select `banner@stapp03:22`
* In the command text area, provide the following:
```
scp -o StrictHostKeyChecking=no -r /etc/httpd/logs/ natasha@ststor01:/tmp
```
* Add another `Build Step` with `Execute shell script on remote host using SSH`
and under `SSH Site` select `natasha@ststor01:22`
* In the command text area, provide the following:
```
sudo mv /tmp/logs/access_log /usr/src/sysops
sudo mv /tmp/logs/error_log /usr/src/sysops
```
* Click `Save`

## Verification
* Click the `copy-logs` job and run `Build Now`
* Check the `Console Output` to check whether the files were transferred and moved successfully
* SSH to `ststor01` and check under `/usr/src/sysops` (or directory as per question) and make sure `access_log` and `error_log` exists

---
For tips on getting better at KodeKloud Engineer Jenkins tasks, [click here](./README.md)
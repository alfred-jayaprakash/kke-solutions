# Create Scheduled Builds in Jenkins
## Introduction
The task expects you to copy log files from one of the appserver to a location on storage server on a particular schedule e.g. Every 11 minutes. 

To accomplish this, you need to setup password-less sudo and password-less SSH (using SSH keys) first. Then you need to setup a Scheduled Build Job that copies files from appserver to the '/tmp' folder on the storage server. Then move the files from '/tmp' folder to the actual location.

For setting up the Scheduled Build job, you need to setup a crontab expression. You can use [Crontab Guru](https://crontab.guru/) to build the expression.

## Solution
### Step 1: Enable password-less sudo and password-less SSH
* SSH to the specific appserver mentioned in question and run `sudo visudo`
* In the resulting file, at the end of the file add password-less sudo for respective sudo user. For example, in stapp03 you would do:
```
banner ALL=(ALL) NOPASSWD: ALL
```
* Switch to root to enable password-less SCP to storage server:
```
sudo su
ssh-keygen -t rsa (leave all options to their defaults)
ssh-copy-id natasha@ststor01
```
* Now test password-less SSH by performing a SSH to storage server, `ssh natasha@ststor01`. You should not be asked for password.
* Once you are in the storage server run `sudo visudo` again and provide natasha's password
* In the resulting file, at the end of the file add password-less sudo for natasha:
```
natasha ALL=(ALL) NOPASSWD: ALL
```

### Step 2: Install SSH Plugins in Jenkins
* `Select port to view on Host 1` and connect to port `8081`. Login using the Jenkins admin user and password given in the question
* Under  `Jenkins > Manage Jenkins >  Manage Plugins` click `Available` and search for `SSH` plugin.
* Select the `SSH` plugin and click `Download now and install after restart`
* In the following screen, click checkbox `Restart Jenkins when installation is complete and no jobs running`. Wait for the screen to become standstill.
* You can try to refresh your browser after a few secs.

### Step 3: Setup Credentials for SSH users
* Under `Jenkins > Manage Jenkins > Manage Credentials`, click `Global` under `Stores scoped to Jenkins` and `Add Credentials`
* Leave kind as `Username with Password` and Scope as `Global (..)`
* Add SSH credentials for the sudo users of the respective servers (banner and natasha):
```
Username: banner
Password: BigGr33n
ID: banner
```
### Step 4: Add SSH Hosts in Jenkins
* Click `Jenkins > Manage Jenkins > Configure System`
* Under `SSH Remote Hosts` click `Add Host` and add the required appserver as follows:
```
Hostname: stapp03
Port: 22
Credentials: Choose 'banner' from the list
Pty: Select checkbox
```
* Click `Check Connection` to make sure connection is successful
* Repeat steps to add `ststor01` host

### Step 5: Create a Scheduled Build Job
* Go back to Jenkins Console
* Click `New item` and in the following screen:
```
Name: copy-logs (Keep 'Freestyle Project' as selected) and click Ok
```
* Under `Build Triggers`, select `Build Periodically` and provide the `Schedule` as per the question. In this example, the job is configured to run every 11 minutes:
```
*/11 * * * *
```
* Now, under `Build`, add a `Build Step` with `Execute shell script on remote host using SSH`
and under `SSH Site` select `banner@stapp03:22`
* In the command text area, provide the following:
```
sudo scp -o StrictHostKeyChecking=no -r /etc/httpd/logs/ natasha@ststor01:/tmp
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
* Click the `copy-logs` job again and run `Build Now`
* Check the `Console Output` to check whether the files were transferred and moved successfully
* SSH to `ststor01` and check under `/usr/src/sysops` (or directory as per question) and make sure `access_log` and `error_log` files are copied

---
For tips on getting better at KodeKloud Engineer Jenkins tasks, [click here](./README.md)
# Add Slave Nodes in Jenkins
## Introduction
This task requires you to setup the 3 appservers as Slave Nodes in Jenkins. To achieve this, you can make use of the [SSH Build Agents](https://plugins.jenkins.io/ssh-slaves/) plugin to simplify the setup of the nodes. For `SSH Build Agents` to work correctly, you need to intsall Java in the Appserver nodes.

## Solution
### Step 1: Install SSH Build Agent plugin in Jenkins
* `Select port to view on Host 1` and connect to port `8081`. Login using the Jenkins admin user and password given in the question
* Under  `Jenkins > Manage Jenkins >  Manage Plugins` click `Available` and search for `Pipeline` plugin.
* Select the `SSH Build Agents` plugin and click `Download now and install after restart`
* In the following screen, click checkbox `Restart Jenkins when installation is complete and no jobs running`. Wait for the screen to become standstill.
* You can try to refresh your browser after a few secs.

### Step 2: Install Java in the Appservers
* SSH to each appserver (stapp01, stapp02 and stapp03) and install Java: `sudo yum install -y java`

### Step 3: Add Slave Nodes
* In Jenkins Admin Console, add a new slave node under  `Jenkins > Manage Jenkins >  Manage Nodes and Clouds > New Node`
* Provide following values
```
Node Name: App_server_1
(Permanent Agent)
Remote root directory: /home/tony/jenkins
Labels: stapp01
Launch Method: Launch Agents via SSH
```
* Additional options will be revealed. Click the `Add Button > Jenkins` next to `Credentials` to add credentials for tony, steve and banner:
 * Leave kind as `Username with Password` and Scope as `Global (..)`
 * Add SSH credentials for the sudo users of the respective servers (tony, steve and banner):
  ```
  Username: tony
  Password: Ir0nM@n
  ID: tony
  ```
* Configure remaining Node SSH options as follows:
```
Host: stapp01
Credentials: tony (From the list you added earlier)
Host Key Verification Strategy: Non verifying Verification Strategy
```
* Click `Save`
* Repeat the above steps to add `stapp02`
```
Node Name: App_server_2
(Permanent Agent)
Remote root directory: /home/steve/jenkins
Labels: stapp02
Launch Method: Launch Agents via SSH
Host: stapp02
Credentials: steve (From the list you added earlier)
Host Key Verification Strategy: Non verifying Verification Strategy
```
* ... and `stapp03`
```
Node Name: App_server_3
(Permanent Agent)
Remote root directory: /home/banner/jenkins
Labels: stapp03
Launch Method: Launch Agents via SSH
Host: stapp03
Credentials: banner (From the list you added earlier)
Host Key Verification Strategy: Non verifying Verification Strategy
```

## Verification
* Wait for a few seconds for the agents to be configured
* Refresh the nodes list. You should see the newly added nodes(`App_server_1`, `App_server_2` and `App_server_3`) displayed with all system statistics. This means the nodes setup was successful
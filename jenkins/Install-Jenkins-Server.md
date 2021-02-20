# Install Jenkins Server
## Solution
* First SSH to the jenkins server as per the question as the root user (root password given in question)
* Enable the Jenkins repo using the following steps:
```
apt-get update
apt install python-software-properties
apt install openjdk-8-jdk
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt install apt-transport-https
apt-get update
```
* Install Jenkins using apt and start the service:
```
apt install jenkins
service jenkins start
service jenkins status
```
* Print the initial Admin password and note it down: `cat /var/lib/jenkins/secrets/initialAdminPassword`
* Now open `Select Port to View on Host 1` and provide the port specified in the question under Note e.g. 8081. This will open the Jenkins Administrator Console.
* Use the initial Admin password you copied and login 
* Select Default installation and wait for it to complete
* In the following 'Create Admin' screen, create a admin user with all the values given in the question
* After completing, you will be taken to Dashboard

## Verification
* Logout from the Dashboard above. You will see the Login page.
* Use the ID and Password from the question e.g.theadmin/Adm!n321 to login. Ensure you are able to see the Dashboard again.
---
For tips on getting better at KodeKloud Engineer Jenkins tasks, [click here](./README.md)

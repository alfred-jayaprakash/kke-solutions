# Jenkins Tasks
## General Jenkins Tips
  * Note that you can seach for multiple plugins, select them and finally click `Download now and install after restart`. When you select one and search for the next one, the previous one disappears. But it is still selected behind-the-scenes and gets installed along when you click `Download now and install after restart`
  * Some of the Jenkins tasks require you to create a Build Job executes some commands on the nautilus appservers or storage server. To achieve this, enable password-less sudo on the server. Check out [Deployment using Jenkins](./Deployment-Using-Jenkins.md) task for steps
  * Some of the Jenkins tasks require you to get code from GIT repo and transfer it to the storage server.  For this, you need to install [Publish over SSH](https://plugins.jenkins.io/publish-over-ssh/) plugin in Jenkins
  * Some tasks even require you to trigger build automatically based on changes pushed to the GIT repo. For this, you need to enable a [Webhook](https://en.wikipedia.org/wiki/Webhook) on the Build job and setting up this Webhook on the Gitea UI. You need to also install [Build Authorization Token Root](https://plugins.jenkins.io/build-token-root/) plugin in Jenkins to allow Gitea to trigger the Jenkins build without authenticating
  * You can make use of the free [Katakoda Docker Playground](https://www.katacoda.com/courses/docker/playground) to practice Jenkins changes. So the recommendation is to:
    * Open the task in Kodekloud Engineer, note down the question and press `Try Later`
    * Open KataKoda Playground, in the commandline run `docker run --name jenkins -p 8080:8080 -d jenkins/jenkins`
    * After the container starts up, you can `Select port to view on Host 1` and give `8080`. This opens up the Jenkin Administration Portal in the browser.
    * You need the default administrator password for first time setup. For this, you need to exec the shell command on the container: `docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword`. This prints out the default administrator password.
    * Use the password to login and setup jenkins as required
    * You can play around with jenkins until you are confident to attempt the question
    * Reopen question in Kodekloud Engineer, and follow the same approach

## Common mistakes
* Not running the build Job more than once. Because some tasks explicitly state that the Build Job should be such that it can be run more than once
---
For general tips on getting better at KodeKloud Engineer tasks, [click here](../README.md)
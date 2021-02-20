# Jenkins Tasks
## General Jenkins Tips
  * You can make use of the free [Katakoda Docker Playground](https://www.katacoda.com/courses/docker/playground) to practice Jenkins changes. So the recommendation is to:
    * Open the task in Kodekloud Engineer, note down the question and press `Try Later`
    * Open KataKoda Playground, in the commandline run `docker run --name jenkins -p 8080:8080 -d jenkins/jenkins`
    * After the container starts up, you can `Select port to view on Host 1` and give `8080`. This opens up the Jenkin Administration Portal in the browser.
    * You need the default administrator password for first time setup. For this, you need to exec the shell command on the container: `docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword`. This prints out the default administrator password.
    * Use the password to login and setup jenkins as required
    * You can play around with jenkins until you are confident to attempt the question
    * Reopen question in Kodekloud Engineer, and follow the same approach

---
For general tips on getting better at KodeKloud Engineer tasks, [click here](../README.md)
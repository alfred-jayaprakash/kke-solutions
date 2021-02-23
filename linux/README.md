# System Administration Tasks
## General Tips
* Always verify your task using one or more of the approaches below:
  * Use Curl command to the test the task. This is particular useful for verifying tasks that involve HTTP/S servers e.g. Apache, Nginx, Firewalld, Iptables. Usage is: `curl <HTTP URL>`. Examples:
    * Simple URL fetch: `curl http://stapp01:8080/`. You should get a valid HTML content returned back.
    * Check HTTP headers (Especially useful to verify tasks that involve restricting access)
      `curl -I http://stapp01:8080/`. You should see a valid HTTP Header with HTTP Return code.
    * To ignore any certificate errors and still fetch the content, use option `-k`
      `curl -k http://stapp01:8080/` or `curl -Ik http://stapp01:8080`
    * To connect as a specfic user (checking PAM or Htaccess tasks):
      `curl -u javed:ax23Xsdg http://stapp01:8080/` ('javed' is the user and 'ax23Xsdg' is the password)
  * You can also use Telnet to verify connectivity to a specific port: `telnet stapp01 8080`. Ensure that you do not see any connection errors.
  * For some tasks, you need to use browser by clicking `Open Port on Host 1` tab to open the site on specific port (especially the Wordpress task)
  * For tasks that involve iptables, use `iptables -nvL` to list all the rules in a simple-to-understand format
  * For some tasks, it may be time-saving and less error-prone if you rather create a shell script, with all the required commands, offline using your favourite IDE. This is how you will actually perform tasks in real-world. You can then copy-paste the script to each required host and execute it. This will help you to easily go for bonus points. e.g. Tasks that require you to configure Iptables or Firewalld
  * Most of the Linux tasks are based on Centos environment. Hence you can make use of the free [Katakoda Centos Playground](https://www.katacoda.com/courses/centos/playground) to practice changes. This is pretty useful for tasks that involve Httpd, Nginx, MariaDB, PostgreSQL, Firewalld or Iptables. This maximizes the learning process. So the recommendation is to:
    * Open the task in Kodekloud Engineer, note down the question and press `Try Later`
    * Open KataKoda Playground and play around until you are confident to attempt the question
    * Reopen question in Kodekloud Engineer, and follow the same approach
    * Note:
      * To find out the OS Flavor and version, run `cat /etc/*release*`
      * Centos Playground will allow processes such as httpd to listen only on port 8080
      * You can access browser by click `Opening Port on Host 1` similar to KKE
      * For similar environment on Ubuntu, [Katakoda Ubuntu Playground](https://www.katacoda.com/courses/ubuntu/playground)

## Common mistakes
* Not reading the question properly. Especially, when you redo the same question, all the names and port values would've changed in the new question. So pay attention to that. 
* To restart a systemd service after performing changes (like nginx.conf,httpd.conf, sshd.config), you run `sudo systemctl restart <service>` and not `sudo systemctl start <service>`. The problem with using `start` option is, if the service is already running then nothing is done. So your changes never take effect.
* For Firewalld tasks, most people miss out on reloading the firewall rules by running `sudo firewall-cmd --reload`
* For Iptables tasks, forgetting to persist the iptables rules is another common mistake: `sudo service iptables save`


---
For general tips on getting better at KodeKloud Engineer tasks, [click here](../README.md)

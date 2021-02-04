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
  * For some tasks, it may be time-saving and less error-prone if you rather create a shell script with all the required commands and execute them on all the required hosts. This will help you to easily go for bonus points. e.g. Tasks that require you to configure Iptables or Firewalld

---
For general tips on getting better at KodeKloud Engineer tasks, [click here](../README.md)

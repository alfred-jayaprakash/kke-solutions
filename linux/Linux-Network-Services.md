## Linux Process Troubleshooting
## Solution
The task is actually simpler than it sounds. In this example, let's take that the Apache Port is 8089.
* You first have to identify which appserver's Apache is down using curl or telnet from Jump Host e.g.`curl http://stapp01:8089`.
* Then go to that host and try to start httpd service. You will notice the start fails with a port already in use error
* Identify which process is listening on the same port i.e. 8089 using `sudo netstat -lntp | grep 8089` (If 'netstat' is not available, install using `sudo yum install net-tools`). Netstat will also show the process id (pid) of the conflicting process.
* Simply kill the process (`sudo kill -9 <pid>`) and start httpd
* Run `systemctl status httpd` to check that httpd service is in running

## Verification
* Test connectivity again from Jump Host to all 3 appservers using curl i.e. `curl http://stapp01:8089/`. You should see the default index page HTML printed.

---
For tips on getting better at KodeKloud Engineer Linux Administration tasks, [click here](./README.md)
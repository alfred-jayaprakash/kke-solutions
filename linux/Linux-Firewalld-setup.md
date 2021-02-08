# Linux Firewalld Setup
## Introduction
* For this task, after installing Firewalld, you are required to add 2 rules: a normal rule and a rich rule
* Most people fail this task because they miss reloading the firewall-cmd, after adding the rules, by running `firewall-cmd --reload`

## Solution
* SSH to one of the appservers and note down the Apache port and Nginx ports respectively
  * Apache port is specified under `/etc/httpd/conf/httpd.conf` (Look for the line `Listen: `)
  * Nginx port is specified under `/etc/nginx/nginx.conf` (Look for the line `listen [::]::`)
* Create a bash script offline with the below content using a text editor. Then copy-paste the script to all the hosts and execute it (Replace the port 8888 and 9999 with Nginx and Apache ports respectively). This is not only time-saving but also less error-prone.
```UNIX
#!/bin/bash
yum install firewalld -y
systemctl start firewalld
systemctl enable firewalld
firewall-cmd --zone=public --permanent --add-port=8888/tcp
firewall-cmd --zone=public --permanent --add-rich-rule='rule family=ipv4 source address=172.16.238.14 port=9999 protocol=tcp accept'
firewall-cmd --reload
firewall-cmd --list-all --zone=public
 ```  
* Execute the script `sudo ./script.sh`
* Verify the successful completion

## Verification
* Execute curl command from Jump Host to the Apache port on all hosts. You should get a connection timed out. For example - `curl -I http://stapp01:9999/`
* Execute curl command from Jump Host to the Nginx port on all hosts. You should see a valid response. For example - `curl -I http://stapp01:8888/`
* Execute the same curl command from Loadbalancer Host (stlb01) to the Nginx and Apache ports on all hosts (You should SSH to stlb01 first). For both Nginx and Apache ports, you should receive valid responses from respective servers.

---
For tips on getting better at KodeKloud Engineer Linux Administration tasks, [click here](./README.md)

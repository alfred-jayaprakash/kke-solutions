# Setup and configure Iptables
## Introduction
* Note that there's one DROP ALL rule at position 5. Hence, any rules you insert should be before position 5. So use the option `-I <position>` to insert rule before Position 5. 
* Need to do the task on all 3 appservers. 

## Solution
* SSH to one of the appservers and note down the Apache port and Nginx ports respectively
  * Apache port is specified under `/etc/httpd/conf/httpd.conf` (Look for the line `Listen: `)
  * Nginx port is specified under `/etc/nginx/nginx.conf` (Look for the line `listen [::]::`)
* Create a bash script in all the appserver hosts with the below content (Replace the port 8888 and 9999 with Nginx and Apache ports respectively)
```UNIX
#!/bin/bash
yum install firewalld -y
systemctl start firewalld
systemctl enable firewalld
firewall-cmd --zone=public --permanent --add-port=8888/tcp
firewall-cmd --add-rich-rule='rule family=ipv4 source address=172.16.238.14 port port=9999 protocol=tcp accept' --permanent
firewall-cmd --reload
firewall-cmd show --zone=public
 ```  
* Execute the script `sudo ./script.sh`
* Verify the successful completion

## Verification
* Execute curl command from Jump Host to the Apache port on all hosts. You should get a connection timed out. For example - `curl -I http://stapp01:9999/`
* Execute curl command from Jump Host to the Nginx port on all hosts. You should see a valid response. For example - `curl -I http://stapp01:8888/`
* Execute the same curl command from Loadbalancer Host (stlb01) to the Nginx and Apache ports on all hosts (You should SSH to stlb01 first). For both Nginx and Apache ports, you should receive valid responses from respective servers.

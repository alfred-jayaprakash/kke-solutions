# Solution
## Introduction
* `iptables -nvL` is your friend to finish this task. 
* Note that there's one DROP ALL rule at position 5. Hence, any rules you insert should be before position 5. So use the option `-I <position>` to insert rule before Position 5. 
* Need to do the task on all 3 appservers. 

## Solution
* Create a bash script in all the appserver hosts with the below content
```UNIX
#!/bin/bash
yum install iptables-services -y
systemctl start iptables
systemctl enable iptables
iptables -I INPUT 5 -s 172.16.238.14 -p TCP --dport 5000 -j ACCEPT
iptables -I INPUT 6 -p TCP --dport 5000 -j DROP
service iptables save
systemctl restart iptables
systemctl status iptables
iptables -nvL
 ```   

* Execute the script `sudo ./script.sh`
* Verify the successful completion

## Verification
* Execute curl command from Jump Host to the given ports on all hosts. You should get a connection failure.
For example
`curl http://stapp01:8080/`
* Execute the same curl command from Loadbalancer Host (stlb01) to the given ports on all hosts (You should SSH to stlb01 first). You should get the default index page served.

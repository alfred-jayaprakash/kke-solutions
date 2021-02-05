# Setup and configure Iptables
## Introduction
* `iptables -nvL` is your friend to finish this task. 
* Note that there's one DROP ALL rule at position 5. Hence, any rules you insert should be before position 5. So use the option `-I <position>` to insert rule before Position 5. 
* Need to do the task on all 3 appservers. 

## Solution
* Create a bash script in all the appserver hosts with the below content (Replace the port 5000 with the port as per the question)
* The solution basically inserts 2 rules: 1 ACCEPT Rule and 1 DROP rule at Position 5 an 6 to accept connection from STLB01 only and drop all other connections respectively
```UNIX
#!/bin/bash
yum install iptables-services -y
systemctl start iptables
systemctl enable iptables
iptables -I INPUT 5 -s 172.16.238.14 -p TCP --dport 5000 -j ACCEPT
iptables -I INPUT 6 -p TCP --dport 5000 -j DROP
service iptables save
systemctl status iptables
iptables -nvL
 ```  
* Execute the script `sudo ./script.sh`
* Verify the successful completion

### Alternative Solution
* An alternative solution is by using a NOT directive (! operator) and replace the 'Drop All' rule at position 5
```UNIX
#!/bin/bash
yum install iptables-services -y
systemctl start iptables
systemctl enable iptables
iptables -R INPUT 5 -s ! 172.16.238.14 -p TCP --dport 5000 -j DROP
service iptables save
systemctl status iptables
iptables -nvL
 ``` 

## Verification
* Execute curl command from Jump Host to the given ports on all hosts. You should get a connection timed out. For example - `curl -I http://stapp01:5000/`
* Execute the same curl command from Loadbalancer Host (stlb01) to the given ports on all hosts (You should SSH to stlb01 first). You should see a valid response returned from the servers.

---
For tips on getting better at KodeKloud Engineer Linux Administration tasks, [click here](./README.md)


## Install and configure Web Application
## Introduction
The task is simpler than its sounds. As `/data` on `ststor01` is mounted on all appservers under `/var/www/html`, it's just enough to copy the two directories mentioned in the question under `/data` on `/ststor01` and it magically appears on `/var/www/html` on all 3 appservers. No further configurations are required in `httpd.conf` other than changing the listen port as per question. The two URL paths will automatically work.

## Solution
### Step 1 - Transfer static files
* Copy the directories mentioned in the question from Jump Host to `/data` on `/ststor01` and it is automatically reflected on all appservers.
```
scp -r /home/thor/news natasha@ststor01:/data
scp -r /home/thor/cluster natasha@ststor01:/data
```
Note: 
* If `scp` doesn't work, install `openssh-clients` on `ststor01` and restart sshd service: `sudo systemctl restart sshd`
* If you get permission denied error to copy files directly to `/data`, then first `scp` to `/tmp` on ststor01 (`scp -r ... natasha@ststor01:/tmp`)and then SSH to ststor01 and mv the files under `/data`: `mv /tmp/news /tmp/cluster /data`

### Step 2 - Install and configure Apache
* Perform the following steps in each appserver host by first opening a SSH connection
* Install httpd: `sudo yum install -y httpd`
* Now edit `/etc/httpd/conf/httpd.conf` in each server to change the Listen port to 8080
* Restart and Enable httpd
```
sudo systemctl restart httpd
sudo systemctl enable httpd
```

## Verification
* Use curl command to verify that you are able to load HTML from the newly added paths in each appservers. You should see a valid HTML page returned back.
```
curl http://stapp01:8080/news/
curl http://stapp01:8080/cluster/
curl http://stapp02:8080/news/
curl http://stapp02:8080/cluster/
curl http://stapp03:8080/news/
curl http://stapp03:8080/cluster/
```
* Finally, access the Loadbalancer URL by clicking `Select port to view on Host 1`, and adding port `80` click on Display Port. Edit, the address bar to add the paths `/news/` and `/cluster/` to check you can see the respective pages.

---
For tips on getting better at KodeKloud Engineer Linux Administration tasks, [click here](./README.md)

## Install and configure Web Application
## Solution
* Perform the following steps in each appserver host by first opening a SSH connection
* Install httpd and openssh-clients (for scp to work)
`sudo yum install -y httpd openssh-clients`
* Restart the SSHD to enable scp: `sudo systemctl restart sshd`
* Copy the folders mentioned in the question from Jump Host to each appserver host
```
scp -r /home/thor/news tony@stapp01:/tmp
scp -r /home/thor/cluster tony@stapp01:/tmp

scp -r /home/thor/news steve@stapp02:/tmp
scp -r /home/thor/cluster steve@stapp02:/tmp

scp -r /home/thor/news banner@stapp03:/tmp
scp -r /home/thor/cluster banner@stapp03:/tmp 
```
* SSH back to the appserver hosts and move the folders under `/var/www/html` e.g. `sudo mv /tmp/news /var/www/html/` and `sudo mv /tmp/cluster /var/www/html/`
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
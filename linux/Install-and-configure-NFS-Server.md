## Install and configure NFS Server
## Solution
### NFS Server setup in Storage Server (ststor01)
Perform the following steps in the storage server (ststor01)
* Install NFS server and start the nfs-server service
```
sudo yum install -y nfs-utils nfs-utils-lib
sudo systemctl start nfs-server
sudo systemctl enable nfs-server
sudo systemctl status nfs-server
sudo systemctl enable rpcbind
```
* Verify that both the services are up
```
sudo chkconfig nfs-server on
sudo systemctl chkconfig rpcbind on
```
* Create the directory that needs to be exported as per the question: `mkdir /webdata`
* Now edit `/etc/exports` and add the following export entries to export this directory to all 3 appserver hosts
```
/webdata  stapp01(rw,sync,no_subtree_check,no_root_squash,fsid=0)
/webdata  stapp02(rw,sync,no_subtree_check,no_root_squash,fsid=0)
/webdata  stapp03(rw,sync,no_subtree_check,no_root_squash,fsid=0)
```
* Export the configuration: `sudo exportfs -a`
* Verify that the directory has been exported correctly by running: `sudo showmount -e ststor01`

### NFS client setup in App Servers 
Perform the following steps on each of the app servers
* Install NFS utils: `sudo yum install -y nfs-utils nfs-utils-lib`
* Mount the exported NFS share on to a local directory as per the question:
`mount -t nfs ststor01:/webdata /var/www/html`
* Verify the mount has completed successfully: `sudo df -h`. You should see the new mount listed

### Verification
* Exit to Jump Host and perform a scp of the index.html to the export directory on ststor01:
`scp natasha@ststor01:/webdata`
* SSH to individual app servers and check that you are able to see the `index.html` under the mounted directory i.e. `/var/www/html`
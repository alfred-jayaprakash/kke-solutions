## Install and configure NFS Server
## Solution
### NFS Server setup in Storage Server (ststor01)
Perform the following steps in the storage server (ststor01)
* Install NFS Utils and start the nfs-server and rpcbind services
```
sudo yum install -y nfs-utils nfs-utils-lib
sudo systemctl start nfs-server
sudo systemctl enable nfs-server
sudo systemctl start rpcbind
sudo systemctl enable rpcbind
```
* Verify that nfs-server and rpcbind have started
```
sudo systemctl status nfs-server
sudo systemctl status rpcbind
sudo chkconfig nfs-server on
sudo chkconfig rpcbind on
```
* Create the directory that needs to be exported as per the question: `mkdir /webdata`
* Now edit `/etc/exports` and add the following export entries to export this directory to all 3 appserver hosts
```
/webdata  stapp01(rw,sync,no_root_squash)
/webdata  stapp02(rw,sync,no_root_squash)
/webdata  stapp03(rw,sync,no_root_squash)
```
* Export the configuration: `sudo exportfs -a`

#### NFS Server setup verification
* Go back to Jump Host and run: `sudo showmount -e ststor01`. You should see the exported directory.

### NFS client setup in App Servers 
Perform the following steps on each of the app servers
* Mount the exported NFS share on to a local directory as per the question (in this example, it is `/var/www/html`):
`sudo mount -t nfs ststor01:/webdata /var/www/html`
* Verify the mount has completed successfully: `sudo mount | grep nfs`. You should see the new mount listed

### Task Verification
* Exit to Jump Host and perform a scp of the index.html to the export directory on ststor01:
`scp natasha@ststor01:/webdata`
* SSH to individual app servers and check that you are able to see the `index.html` under the mounted directory i.e. `/var/www/html`

---
For tips on getting better at KodeKloud Engineer Linux Administration tasks, [click here](./README.md)

## Install and configure SFTP
## Solution
* SSH to the required host
* Create a new group: `sudo groupadd sftpusers`
* Create the given user and add it to the group by running `sudo useradd javed -g sftpusers` (In this example `javed` is the user to be created)
* Set the password to the user as given in the question by running: `sudo passwd javed`
* Create the landing directory (`chroot` directory in the question). It's important that this directory and it's parent are owned by `root` and set permissions `0755`. In this example, `/var/www/webdata` is the landing directory mentioned in the question.
```
sudo mkdir -p /var/www/webdata
sudo chown -R root:root /var/www
sudo chmod -R 755 /var/www
```
* Now modify the`/etc/ssh/sshdconfig` as follows to force SFTP-only for all users belonging to the newly created group. 
  * Make sure to comment the existing `Subsystem  sftp  /usr/libexec/openssh/sftp-server` line. 
  * Change the value of `ChrootDirectory` below as per question. In the below example, `/var/www/webdata` is configured:
 ```
 Subsystem sftp internal-sftp 
 Match Group sftpusers 
    ForceCommand internal-sftp 
    ChrootDirectory /var/www/webdata 
    PasswordAuthentication yes 
    PermitTTY no 
    AllowTcpForwarding no 
    X11Forwarding no 
    PermitTunnel no 
    AllowAgentForwarding no 
 ```
* Restart sshd `systemctl restart sshd`
 
## Verification
* From the same host, try to do a SSH using the newly created user. e.g. `ssh javed@localhost`. It should fail with an error `This service allows sftp connections only`.
* Try to do a SFTP using the newly created user. e.g. `sftp javed@localhost`. Connection should succeed.

---
For tips on getting better at KodeKloud Engineer Linux Administration tasks, [click here](./README.md)
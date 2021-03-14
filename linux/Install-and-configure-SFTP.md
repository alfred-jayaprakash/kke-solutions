
## Install and configure SFTP
## Solution
* SSH to the required host and add the user e.g. `sudo useradd javed` 
* Set the password to the user as given in the question e.g. `sudo passwd javed`
* Create the landing directory (`chroot` directory in the question) and given ownership to `root` user:
```
sudo mkdir -p /var/www/webdata
sudo chown -R root:root /var/www
sudo chmod -R 755 /var/www
```
* Now modify the`/etc/ssh/sshdconfig` as follows to force SFTP-only for the newly created (Make sure to comment the existing `Subsystem  sftp  /usr/libexec/openssh/sftp-server` line):
 ```
 Subsystem sftp internal-sftp 
 Match User javed 
    X11Forwarding no 
    AllowTcpForwarding no 
    PermitTTY no 
    ForceCommand internal-sftp 
    PasswordAuthentication yes 
    ChrootDirectory /var/www/webdata 
    PermitTunnel no 
    AllowAgentForwarding no 
 ```
* Restart sshd `systemctl restart sshd`
 
## Verification
* From the same host, try to do a SSH using the newly created user. e.g. `ssh javed@localhost`. It should fail with an error `This service allows sftp connections only`.
* Try to do a SFTP using the newly created user. e.g. `sftp javed@localhost`. It should succeed.

---
For tips on getting better at KodeKloud Engineer Linux Administration tasks, [click here](./README.md)
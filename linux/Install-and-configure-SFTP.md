
## Install and configure SFTP
## Solution
* SSH to the required host and add the user e.g. `sudo useradd javed -s /sbin/nologin` 
* Set the password to the user as given in the questino e.g. `sudo passwd javed`
* Create the landing directory (chroot directory in the question) and make the new user the owner:
```
sudo mkdir -p /var/www/webdata
sudo chown javed:javed /var/www/webdata 
sudo chmod 755 /var/www/webdata
```
* Modify permissions to the parent folder i.e. /var/www to grant access and ownership to root user
```
sudo chown root:root /var/www/
sudo chmod 755 /var/www
```
* Now modify the`/etc/ssh/sshdconfig` as follows to force SFTP-only for the newly created (Make sure not to duplicate `Subsystem sftp` in the file):
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
* Try to do a SSH to the host using the newly created user. e.g. `ssh javed@stapp03`. It should fail.
* Try to do a SFTP to the host using the newly created user. e.g. `sftp javed@stapp03`. It should succeed.

---
For tips on getting better at KodeKloud Engineer Linux Administration tasks, [click here](./README.md)
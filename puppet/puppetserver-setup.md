# Puppetserver Setup
## Solution
* Install the puppetserver first
```UNIX
rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
yum install puppetserver -y
```
* Edit the puppetserver configuration at `/etc/sysconfig/puppetserver` and update the JAVA_ARGS as required: `JAVA_ARGS="-Xms512m -Xmx512m ...."`

* Start the puppetserver
```
systemctl start puppetserver
systemctl enable puppetserver
systemctl status puppetserver
```

## Verification
* Ensure puppetserver is running by using the following command:
`/opt/puppetlabs/server/apps/puppetserver/bin/puppetserver -v`

---
For general tips on getting better at KodeKloud Engineer Puppet tasks, [click here](./README.md)


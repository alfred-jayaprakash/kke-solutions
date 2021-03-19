# Install Puppet Agent
## Solution
* SSH to required appserver host first
* Enable puppet repo and install puppet-agent
```UNIX
sudo rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
sudo yum install puppet-agent -y
```
* Start the puppet agent: `sudo systemctl start puppet`

## Verification
* Verify that the puppet service has started: `sudo systemctl status puppet`

---
For general tips on getting better at KodeKloud Engineer Puppet tasks, [click here](./README.md)


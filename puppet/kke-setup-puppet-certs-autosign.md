# Setup Puppet Certs Autosign
## Solution
### Configure AutoSign in Puppet server
* Create a new `autosign.conf` file under `/etc/puppetlabs/puppet/` directory with the following content:
```
jump_host.stratos.xfusioncorp.com
stapp01.stratos.xfusioncorp.com
stapp02.stratos.xfusioncorp.com
stapp03.stratos.xfusioncorp.com
```

### Add puppet alias in the Jump Host
* Edit `/etc/hosts` file and add the `puppet` alias next to the jump host entry i.e. `jump_host.stratos.xfusioncorp.com`
```
...
...
172.16.238.3    jump_host.stratos.xfusioncorp.com jump_host puppet
172.16.239.5    jump_host.stratos.xfusioncorp.com jump_host puppet
```
* Restart puppetserver: `systemctl restart puppetserver`

### Add puppet alias in the Appserver Hosts
Perform the next set of steps in each appserver host
* SSH to the appserver host
* Same way as Jump Host, edit `/etc/hosts` file and add the `puppet` alias next to the jump host entry 
```
...
172.16.238.3    jump_host.stratos.xfusioncorp.com puppet
...
...

```
* Run `puppet agent -tv`. You should see the new certificate generated and printed something like this:
```
Info: Creating a new RSA SSL key for stapp01.stratos.xfusioncorp.com
Info: csr_attributes file loading from /home/tony/.puppetlabs/etc/puppet/csr_attributes.yaml
Info: Creating a new SSL certificate request for stapp01.stratos.xfusioncorp.com
Info: Certificate Request fingerprint (SHA256): 
.....
Info: Downloaded certificate for stapp01.stratos.xfusioncorp.com from https://puppet:8140/puppet-ca/v1
.....
....
```

## Verification
* In the Jump Host, verify that you are able to see the newly generated certificates by running `puppetserver ca list --all`. You should see all the certificates printed like this:
```
Signed Certificates:
    stapp02.stratos.xfusioncorp.com         (SHA256)  
    .......
    jump_host.stratos.xfusioncorp.com       (SHA256)  
    ....       alt names: ["DNS:puppet", "DNS:jump_host.stratos.xfusioncorp.com"] ...
    stapp03.stratos.xfusioncorp.com         (SHA256)  
    ....
    stapp01.stratos.xfusioncorp.com         (SHA256)  
    ......
```

---
For general tips on getting better at KodeKloud Engineer Puppet tasks, [click here](./README.md)


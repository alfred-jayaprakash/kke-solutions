# Puppet Setup Firewall Rules
## Solution
* Install `puppet-firewalld` module by running `puppet module install puppet-firewalld` on Jump host
* On Jump host create the required inventory file with the name given as per the question i.e.`/etc/puppetlabs/code/environments/production/manifests/code.pp` and content as below.
```ruby
node 'stapp01.stratos.xfusioncorp.com' {
  include firewall_node1
}

node 'stapp02.stratos.xfusioncorp.com' {
  include firewall_node2
}

node 'stapp03.stratos.xfusioncorp.com' {
  include firewall_node3
}
```
* In the same folder, create the required implementation file with the name given as per the question i.e.`/etc/puppetlabs/code/environments/production/manifests/demo.pp` and content as below [Change the values of ports below according to the question]
```ruby
class { 'firewalld': }

class firewall_node1 {
  firewalld_port { 'Open port 3000 in the public zone':
    ensure   => present,
    zone     => 'public',
    port     => 3000,
    protocol => 'tcp',
  }
}

class firewall_node2 {
  firewalld_port { 'Open port 9006 in the public zone':
    ensure   => present,
    zone     => 'public',
    port     => 9006,
    protocol => 'tcp',
  }
}

class firewall_node3 {
  firewalld_port { 'Open port 8091 in the public zone':
    ensure   => present,
    zone     => 'public',
    port     => 8091,
    protocol => 'tcp',
  }
}
```
* Run the puppet verifications steps:
  * On Jump host: `puppet parser validate code.pp` and `puppet parser validate demo.pp`. You should not see any errors.
  * SSH to one of the appservers hosts and run `sudo puppet agent -tv --noop` first to dry-run the code. Check there are no issues.
  * Finally run `sudo puppet agent -tv` in each of the appserver hosts to implement the firewall changes. Note: No need to run `firewall-cmd --reload`. The puppet code automatically does that.

## Verification
* Run `curl http://<host>:<port>/` from Jump Host to the speific ports on each appserver (as per the question) to test connectivity e.g. `curl http://stapp01:3000/`. You should get back a valid HTML page as Apache is running on specific ports on each appserver.

---
For general tips on getting better at KodeKloud Engineer Puppet tasks, [click here](./README.md)


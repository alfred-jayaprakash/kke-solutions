#
# Step 1: This is the code file. Save this file under 
#         /etc/puppetlabs/code/environments/production/manifests 
#         as a file with the name specified in the question e.g. demo.pp
# Step 2: Run the puppet verifications steps mentioned in ./README.md
# Step 3: Verify: Finally, SSH to each hosts and run `sudo puppet agent -tv` 
#         Run `curl http://<host>:<port>/` in Jump Host to test connectivity
#         e.g. http://stapp01:3000/
#
# For tips on getting better at Puppet tasks, check out the README.md
# in this folder
#
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


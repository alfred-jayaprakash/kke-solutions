#
# Step 1: Run `puppet module install puppet-firewalld`
# Step 2: This is the inventory file. Save this file under 
#         /etc/puppetlabs/code/environments/production/manifests 
#         as a file with the name specified in the question e.g. code.pp
# Step 3: Proceed to 'kke-setup-firewall-rules-2.pp' for remaining steps
#
# For tips on getting better at Puppet tasks, check out the README.md
# in this folder
#
node 'stapp01.stratos.xfusioncorp.com' {
  include firewall_node1;
}

node 'stapp02.stratos.xfusioncorp.com' {
  include firewall_node2;
}

node 'stapp03.stratos.xfusioncorp.com' {
  include firewall_node3;
}


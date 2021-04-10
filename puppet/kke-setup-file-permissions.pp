#
# Step 1: Save this file under /etc/puppetlabs/code/environments/production/manifests 
#         as a file with the name specified in the question e.g. apps.pp
# Step 2: Change file, permissions and node values according to question
# Step 3: Run the puppet verifications steps mentioned in ../puppet/README.md
# Step 4: Verify: Run the puppet agent in the required host and check that 
#                 /opt/finance/ecommerce.txt has correct content and permissions
#
# For tips on getting better at Puppet tasks, check out the README.md
# in this folder
#
class file_modifier {
  # Update ecommerce.txt under /opt/finance
  file { '/opt/finance/ecommerce.txt':
    ensure => 'present',
    content => 'Welcome to xFusionCorp Industries!',
    mode => '0655',
  }
}

node 'stapp02.stratos.xfusioncorp.com' {
  include file_modifier
}

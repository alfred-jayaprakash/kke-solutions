#
# Step 1: Save this file under /etc/puppetlabs/code/environments/production/manifests 
#         as a file with the name specified in the question e.g. apps.pp
# Step 2: Change filename, directory and node values according to question
# Step 3: Run the puppet verifications steps mentioned in ../puppet/README.md
# Step 4: Verify: Run the puppet agent in the required host and check that /opt/finance has 
#         official.txt file in it
#
# For tips on getting better at Puppet tasks, check out the README.md
# in this folder
#
class file_creator {
  # Now create official.txt under /opt/finance
  file { '/opt/finance/official.txt':
    ensure => 'present',
  }
}

node 'stapp03.stratos.xfusioncorp.com' {
  include file_creator
}

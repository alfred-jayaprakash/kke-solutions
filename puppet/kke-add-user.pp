#
# Step 1: Save this file under /etc/puppetlabs/code/environments/production/manifests 
#         as a file with the name specified in the question e.g. apps.pp
# Step 2: Change username and uid according to question
# Step 3: Run the puppet verifications steps mentioned in ../puppet/README.md
# Step 4: Verify: Run the puppet agent in the required host and check that user
#         has been added i.e. 'cat /etc/passwd | grep anita'
#
# For tips on getting better at Puppet tasks, check out the README.md
# in this folder
#
class user_creator {
  user { 'anita':
    ensure   => present,
    uid => 1553,
  }
}

node 'stapp01.stratos.xfusioncorp.com', 'stapp02.stratos.xfusioncorp.com', 'stapp03.stratos.xfusioncorp.com' {
  include user_creator
}

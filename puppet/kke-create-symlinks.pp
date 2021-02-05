#
# Step 1: Save this file under /etc/puppetlabs/code/environments/production/manifests 
#         as a file with the name specified in the question e.g. news.pp
# Step 2: Run the puppet verifications steps mentioned in ../puppet/README.md
# Step 3: Verify: After completing the runs in each agent, check that /var/www/html has 
#         media.txt file in it
#
# For tips on getting better at Puppet tasks, check out the README.md
# in this folder
#
class symlink {
  # First create a symlink to /var/www/html
  file { '/opt/devops':
    ensure => 'link',
    target => '/var/www/html',
  }
  
  # Now create media.txt under /opt/devops
  file { '/opt/devops/media.txt':
    ensure => 'present',
  }
}

node 'stapp01.stratos.xfusioncorp.com', 'stapp02.stratos.xfusioncorp.com', 'stapp03.stratos.xfusioncorp.com' {
  include symlink
}

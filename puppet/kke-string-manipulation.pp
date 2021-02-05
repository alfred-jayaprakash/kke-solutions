#
# Step 1: Save this file under /etc/puppetlabs/code/environments/production/manifests 
#         as a file with the name specified in the question e.g. news.pp
# Step 2: Perform validation steps as per my guide ../puppet/README.md
# Step 3: SSH to stapp01 and verify the content of /opt/dba/beta.txt
#
# For tips on getting better at Puppet tasks, check out the README.md
# in this folder
#
class data_replacer {
  file_line { 'line_replace':
    path => '/opt/dba/beta.txt',
    match => 'Welcome to Nautilus Industries!',
    line  => 'Welcome to xFusionCorp Industries!',
  }
}

node 'stapp01.stratos.xfusioncorp.com' {
  include data_replacer
}

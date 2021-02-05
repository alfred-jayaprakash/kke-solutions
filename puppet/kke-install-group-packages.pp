#
# Step 1: Install puppet-yum package as 'puppet module install puppet-yum'
# Step 2: Save this file under /etc/puppetlabs/code/environments/production/manifests 
#         as a file with the name specified in the question e.g. cluster.pp
# Step 3: Replace class name,group package values in this as per question
# Step 4: After performing puppet code validation steps as specified in my guide execute
#         the code by running `sudo puppet agent -tv` in all appserver hosts
# Step 5: Finally run 'sudo yum group list | grep Installed -A 1' to 
#         check if the package group has been installed
#
# For tips on getting better at Puppet tasks, check out the README.md
# in this folder
#
class yum_group {
    yum::group { 'Development Tools':
      ensure  => present,
    }
}

node 'stapp01.stratos.xfusioncorp.com', 'stapp02.stratos.xfusioncorp.com', 'stapp03.stratos.xfusioncorp.com' {
  include yum_group
}

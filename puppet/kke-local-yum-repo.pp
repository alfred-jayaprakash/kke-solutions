#
# Step 1: Save this file under /etc/puppetlabs/code/environments/production/manifests 
#         as a file with the name specified in the question e.g. news.pp
# Step 2: Change the yum repo name, paths and application package according to question
# Step 3: Run the puppet verifications steps mentioned in puppet/README.md
# Step 4: Finally, SSH to each hosts and run `sudo puppet agent -tv` to make
#         sure you install the package
# Step 5: Verify: Check that the required package (e.g. httpd) is installed from local 
#         repo using 'repoquery -i httpd'
#         ('Repository' field should show as 'local_yum')
#         Note: You may have to install `yum-utils` for repoquery to work - 
#          'sudo yum install -y yum-utils'
#
# For tips on getting better at Puppet tasks, check out the README.md
# in this folder
#
class local_yum_repo {
  #Setup Local repo
  yumrepo { 'localyum':
    enabled => 1,
    descr => 'Local repo for app pckgs',
    baseurl => 'file:///packages/downloaded_rpms',
    gpgcheck => 0,
  }

  #Install package from this repo
  package { 'httpd':
    ensure  => 'installed',
    require => Yumrepo['localyum'],        
  }
}

node 'stapp01.stratos.xfusioncorp.com', 'stapp02.stratos.xfusioncorp.com', 'stapp03.stratos.xfusioncorp.com' {
  include local_yum_repo
}

#
# Step 1: Save this file under /etc/puppetlabs/code/environments/production/manifests 
#         as a file with the name specified in the question e.g. news.pp
# Step 2: Run the puppet verifications steps mentioned in puppet/README.md
# Step 3: Verify: Finally, SSH to each hosts and run `sudo puppet agent -tv` 
#         Run `sudo systemctl status nginx` to check the service is up
#
# For tips on getting better at Puppet tasks, check out the README.md
# in this folder
#
class nginx_installer {
    package {'nginx':
        ensure => installed
    }

    service {'nginx':
        ensure    => running,
        enable    => true,
    }
}

node 'stapp01.stratos.xfusioncorp.com', 'stapp02.stratos.xfusioncorp.com', 'stapp03.stratos.xfusioncorp.com' {
  include nginx_installer
}

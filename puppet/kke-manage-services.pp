#
# Save this file under /etc/puppetlabs/code/environments/production/manifests as a file
# with the name specified in the question e.g. news.pp
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

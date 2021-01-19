class tomcat_installer {
    package {'tomcat':
        ensure => installed
    }

    service {'tomcat':
        ensure    => running,
        enable    => true,
    }
}

node 'stapp01', 'stapp02', 'stapp03' {
  include tomcat_installer
}

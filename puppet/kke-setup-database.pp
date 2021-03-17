#
# Step 1: Save this file under /etc/puppetlabs/code/environments/production/manifests 
#         as a file with the name specified in the question e.g. cluster.pp
# Step 2: Run the puppet verifications steps mentioned in puppet/README.md
# Step 3: Verify: Finally, SSH to stdb01 and run `sudo puppet agent -tv` 
#         Run `sudo systemctl status mariadb` to check the service is running
# Step 4: Verify: In stdb01, try connecting to the database using the new user
#         mysql -u kodekloud_rin -p kodekloud_db1 -h localhost
#
# For tips on getting better at Puppet tasks, check out the README.md
# in this folder
#
class mysql_database {
    package {'mariadb-server':
      ensure => installed
    }

    service {'mariadb':
        ensure    => running,
        enable    => true,
    }    

    mysql::db { 'kodekloud_db1':
      user     => 'kodekloud_rin',
      password => 'BruCStnMT5',
      host     => 'localhost',
      grant    => ['ALL'],
    }
}

node 'stdb01.stratos.xfusioncorp.com' {
  include mysql_database
}

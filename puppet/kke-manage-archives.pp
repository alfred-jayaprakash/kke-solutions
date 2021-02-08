#
# Step 1: Save this file under /etc/puppetlabs/code/environments/production/manifests 
#         as a file with the name specified in the question e.g. media.pp
# Step 2: Run the puppet verifications steps mentioned in ./README.md
# Step 3: Verify: Finally, SSH to each hosts and run `sudo puppet agent -tv` 
#         Run `ls /opt/media/` to check extracted contents exists
#
# For tips on getting better at Puppet tasks, check out the README.md
# in this folder
#
class archive_extractor {
    # Copy media.zip to /tmp directory to extract and then cleanup afterwards
    archive { '/tmp/media.zip':
        source        => '/usr/src/media/media.zip',
        extract       => true,
        extract_path  => '/opt/media',
        cleanup       => true,
    }   
}

node 'stapp01.stratos.xfusioncorp.com', 'stapp02.stratos.xfusioncorp.com', 'stapp03.stratos.xfusioncorp.com' {
  include archive_extractor
}

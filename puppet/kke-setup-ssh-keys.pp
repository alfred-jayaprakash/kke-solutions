#
# Step 1: Save this file under /etc/puppetlabs/code/environments/production/manifests as a file
# with the name specified in the question e.g. news.pp
# Step 2: Copy the public key value from the public key location specified in the question and paste
# in the below variable
#
$public_key =  'AAAAB3NzaC1yc2EAAAADAQABAAABAQCjzucWviIHiT0R1YP3cYmkWcNfv53svphAIW4RpnDiSdoTvooeah3Akh/VagwCJsClpdwuM3xdAvEWyHFkI6zdItrdjqM8fJ6Y8HYXF8Ros979TVYcktI8Ird+92CFqsAVRqGTyJNx++68N7JA78dWf+SEsGaDSkEjGkjfIJgOlZ1OmJJB/pszUOjeiFvEJbkc+TA0fH6htGg/QCotC1tAUnIszf664QENjNiqIfruM/CwojExmos8RKKO1GYgjBFzB9eofk7zsjn1zk9NJ7LGqvZ6/EirTf2dCOH5RMYbjccGZI/AQTXQ15kUYUHCtpUQFrQ88T0W93D9bbiXHdFn'

class ssh_node1 {
  ssh_authorized_key { 'tony@stapp01':
    ensure => present,
    user   => 'tony',
    type   => 'ssh-rsa',
    key    => $public_key,
  }
}

class ssh_node2 {
  ssh_authorized_key { 'steve@stapp02':
    ensure => present,
    user   => 'steve',
    type   => 'ssh-rsa',
    key    => $public_key,
  }
}

class ssh_node3 {
  ssh_authorized_key { 'banner@stapp03':
    ensure => present,
    user   => 'banner',
    type   => 'ssh-rsa',
    key    => $public_key,
  }
}

node stapp01.stratos.xfusioncorp.com {
  include ssh_node1
}

node stapp02.stratos.xfusioncorp.com {
  include ssh_node2
}

node stapp03.stratos.xfusioncorp.com {
  include ssh_node3
}


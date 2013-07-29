require stdlib

class { 'apt-cacher-ng::client':
  server  => '192.168.31.2:3142',
  autodetect => false,
  before => Class['apt']
}
class { 'apt':
  always_apt_update => true,
  #stage => 'setup',
  before => Stage['rvm-install']
}

class { 'metasploit': }

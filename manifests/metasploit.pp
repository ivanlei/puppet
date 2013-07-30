class { 'apt-cacher-ng::client':
  server  => '192.168.31.2:3142',
  autodetect => false,
  stage => 'setup',
  before => [Class['apt']]
}

class { 'apt':
  always_apt_update => true,
  stage => 'setup',
}

class { 'metasploit': }

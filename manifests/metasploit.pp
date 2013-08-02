require stdlib

class { 'apt-cacher-ng::client':
  server  => '192.168.31.2:3142',
  stage   => 'setup',
  before  => [Class['apt']]
}

class { 'apt':
  always_apt_update => true,
  stage             => 'setup',
}

class { 'metasploit': 
  postgres_user     => 'msf',
  postgres_password => 'msf',
}

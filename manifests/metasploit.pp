require stdlib

class { 'apt_cacher_ng::client':
  servers     => ["${aptserver_ip}:3142"],
  apt_update  => true,
  stage       => 'setup'
}

class { 'metasploit':
  postgres_user     => 'msf',
  postgres_password => 'msf',
}

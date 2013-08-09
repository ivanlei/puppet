require stdlib

class { 'apt_cacher_ng::client':
  stage => 'setup'
}

class { 'metasploit':
  postgres_user     => 'msf',
  postgres_password => 'msf',
}

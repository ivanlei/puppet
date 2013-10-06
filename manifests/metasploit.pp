require stdlib

class { 'known_hosts': } ->
class { 'apt_cacher_ng::client': } ->
class { 'metasploit':
  postgres_user     => 'msf',
  postgres_password => 'msf',
}


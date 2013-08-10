require stdlib

class { 'apt_cacher_ng::client':
  stage => 'setup'
}

require nodejs
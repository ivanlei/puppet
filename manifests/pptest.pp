require stdlib

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

class fungo-bat {
  $ruby_version = 'ruby-1.9.3-p125'

  class { 'rvm': }

  rvm_system_ruby { $ruby_version:
    ensure      => present,
    default_use => true,
    require     => Class['rvm'],
  }

  rvm_gem { 'bundler':
    ruby_version  => $ruby_version,
    ensure        => latest,
    require       => Rvm_system_ruby[$ruby_version],
  }
}

class { 'fungo-bat': }

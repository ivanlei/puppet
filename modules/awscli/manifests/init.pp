# Class: awscli
#
# This class installs awscli
#
# Actions:
#   - Install awscli and boto using pip
#   - Install s3cmd tool
#   - Install template cred files
#
# Sample Usage:
#  class { 'awscli': }
#
class awscli {
  require python-pip

  package { 's3cmd':
    ensure => present,
  }

  file { '/home/vagrant/.s3cfg':
    content => template('awscli/s3cfg'),
    mode => '700',
    owner => 'vagrant',
    group => 'vagrant',
  }

  package { ['awscli','boto']:
    ensure => present,
    provider => 'pip'
  }
  
  file { '/home/vagrant/.boto':
    content => template('awscli/boto'),
    mode => '700',
    owner => 'vagrant',
    group => 'vagrant',
  }  
}
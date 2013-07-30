# Class: python-pip
#
# This class installs python-pip
#
# Actions:
#   - Install the python-pip package
#
# Sample Usage:
#  class { 'python-pip': }
#
class python-pip {
  $packages = ['build-essential', "linux-headers-${kernelrelease}", 'python-dev']

  package { $prereqs:
  	ensure => present,
  }

  package { 'python-pip':
    ensure  => present,
    require => Package[$packages],
  }
}
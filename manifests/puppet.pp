class { 'apt_cacher_ng::server': } ->
class { 'known_hosts': } ->
class { 'puppet::master': 
  modulepath   => '/vms/modules',
  storeconfigs => false,
  autosign     => true,
}


require stdlib

class { 'known_hosts': } ->
class { 'apt_cacher_ng::client': } -> 
class { 'aws_tools': }


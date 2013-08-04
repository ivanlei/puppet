require stdlib
require python_pip

class { 'apt_cacher_ng::autoupdate_client':
  servers     => ["${aptserver_ip}:3142"],
  autodetect  => false,
  stage       => 'setup'
}

class { 'aws_tools':
  user_name => 'vagrant'
}

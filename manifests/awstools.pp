require stdlib
require python_pip

class { 'apt-cacher-ng::autoupdate_client':
  server      => "${aptserver_ip}:3142",
  autodetect  => false,
  stage       => 'setup'
}

class { 'aws_tools':
  user_name => 'vagrant'
}

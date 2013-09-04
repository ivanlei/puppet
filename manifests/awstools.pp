require stdlib

#class { 'apt_cacher_ng::client': 
#  stage => 'setup'
#}

class { 'aws_tools': }

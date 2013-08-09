vms
===
This collects the puppet, hiera, and vagrant config I use.  My environment is as follows:
* development - Mac OSX
* staging - Ubuntu in VMWare Fusion VMs
* development - Ubuntu in AWS

setup
-----
* clone this module to ~/vms
* ln -s ~/vms /vms
* export VAGRANT_HOME=/vms/.vagrant.d
* export VAGRANT_DEFAULT_PROVIDER=vmware_fusion
* alias puppet="puppet --confdir /vms/.puppet"

using heira
-----------
In a vagrant file, make sure to include the following:
```ruby
config.vm.provision :puppet do |puppet|
	puppet.hiera_config_path = '/vms/hiera.yaml'
	puppet.working_directory = '/vms/hieradata'
end
```

From the commandline on Mac OSX the alias with --confdir should take care of it.

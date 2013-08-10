vms
===
This collects the puppet, hiera, and vagrant config I use to bring up ubuntu VMs from Mac OSX.

setup
-----
Clone the repo:
```
git clone git@github.com:ivanlei/vms.git ~/vms
ln -s ~/vms /vms
```

And then in my profile I add:
```
export VAGRANT_HOME=/vms/.vagrant.d
export VAGRANT_DEFAULT_PROVIDER=vmware_fusion
alias puppet="puppet --confdir /vms/.puppet"
```

Install tools: VirtualBox, VMWare Fusion, Puppet, Hiera, Vagrant, Puppet-Librarian
TODO: gemfile to installing it all?

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

troubleshooting networking
--------------------------
Networking trouble with VMWare Fusion seems pretty common on Mac OSX.  If VMs won't start due to networking nonsense try:
```
sudo "/Applications/VMware Fusion.app/Contents/Library/vmnet-cli" -c
sudo "/Applications/VMware Fusion.app/Contents/Library/vmnet-cli" --stop
sudo "/Applications/VMware Fusion.app/Contents/Library/vmnet-cli" -c
sudo "/Applications/VMware Fusion.app/Contents/Library/vmnet-cli" --start
```



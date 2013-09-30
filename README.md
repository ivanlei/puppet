vms
===
This collects the puppet, hiera, packer, and vagrant config I use to bring up ubuntu VMs.

setup
-----
```
# Clone the repo.
git clone git@github.com:ivanlei/vms.git ~/vms
cd ~/vms
git submodule init
git submodule update

# Both host and guest will have /vms
ln -s ~/vms /vms

# Puppet config is under source control
ln -s /vms/.puppet ~/.puppet

# Vagrant config is under source control
ln -s /vms/.vagrant.d ~/.vagrant.d
```

Install tools: RVM, VirtualBox, VMWare Fusion, Puppet, Hiera, Packer, Vagrant, Puppet-Librarian
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

troubleshooting networking
--------------------------
Networking trouble with VMWare Fusion seems pretty common on Mac OSX.  If VMs won't start due to networking nonsense try:
```
sudo "/Applications/VMware Fusion.app/Contents/Library/vmnet-cli" -c
sudo "/Applications/VMware Fusion.app/Contents/Library/vmnet-cli" --stop
sudo "/Applications/VMware Fusion.app/Contents/Library/vmnet-cli" -c
sudo "/Applications/VMware Fusion.app/Contents/Library/vmnet-cli" --start
```


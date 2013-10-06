vms
===
This collects the puppet, hiera, packer, and vagrant config I use to bring up ubuntu VMs.

setup
-----

* Grab the code and get it setup
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

# The following probably belong in .bashrc
export VAGRANT_HOME=/vms/.vagrant.d
export PACKER_CACHE=/vms/.packer.d
```

Install rvm and ruby ruby 1.9.3: http://rvm.io
```
curl -L https://get.rvm.io | bash -s stable --ruby=1.9.3
```

* Install virtualbox: https://www.virtualbox.org/wiki/Downloads
* Install vagrant: http://downloads.vagrantup.com
* Install packer: http://www.packer.io/downloads.html
* Install puppet: https://github.com/puppetlabs/puppet
* Install hiera: https://github.com/puppetlabs/hiera
* Install some useful gems:
  * librarian-puppet-maestrodev
  * puppet-lint
  * rake
  * rspec
  * veewee-to-packer

troubleshooting vmware networking on mac
----------------------------------------
Networking trouble with VMWare Fusion seems pretty common on Mac OSX.  If VMs won't start due to networking nonsense try:
```
sudo "/Applications/VMware Fusion.app/Contents/Library/vmnet-cli" -c
sudo "/Applications/VMware Fusion.app/Contents/Library/vmnet-cli" --stop
sudo "/Applications/VMware Fusion.app/Contents/Library/vmnet-cli" -c
sudo "/Applications/VMware Fusion.app/Contents/Library/vmnet-cli" --start
```

troubleshooting vagrant up
--------------------------
I've run into issues a few times with using custom SSH key pairs for vagrant.  Try:
```
VAGRANT_LOG=info vagrant up
```


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

* Install rvm and ruby ruby 1.9.3: http://rvm.io

```
curl -L https://get.rvm.io | bash -s stable --ruby=1.9.3
```

* Install virtualbox: https://www.virtualbox.org/wiki/Downloads
* Install vagrant: http://downloads.vagrantup.com
* Install packer: http://www.packer.io/downloads.html
* Install puppet: https://github.com/puppetlabs/puppet
* Install hiera: https://github.com/puppetlabs/hiera
* Install some useful gems

```
gem install librarian-puppet-maestrodev puppet-lint rake rspec veewee-to-packer
```

code layout
-----------

<pre>
/vms
|-.puppet/             
| |- puppet.conf 
|
|-.vagrant.d/          
| |- Vagrantfile
|
|- boxes/        
|- git_modules/
|  |- moduleA
|  |- moduleB
|
|- hieradata/
|  |- common.yaml
|  |- hosts.yaml
|
|- manifests/
|  |- nodeA.pp
|  |- nodeB.pp
|
|- modules/
|
|- packer/
|  |- ssh
|  |- templateA
|  |- templateB
|
|- hiera.yaml
|- Puppetfile
|- README.md
|- Vagrantfile
</pre>

packer
------
Packer is used to build vagrant boxes.  The goal of using packer is to have a trustworty base box.  

`/vms/packer/veewee-ubuntu-server-12043-x64/` was created using the `veewee-to-packer` gem and then:
* Don't install chef
* Install ruby/puppet using https://github.com/hashicorp/puppet-bootstrap
* Use a custom SSH public key.  The key under source control at `/vms/packer/ssh/id_rsa_puppet`
* Don't allow password auth for SSH
* TODO: Change the default password for user `vagrant`

To build a box with packer:
```
packer build template.json
mv <box_file> /vms/boxes
vagrant box add <box_name> /vms/boxes/<box_file>
```

I usually remove the old box before adding the new one:
```
vagrant box remove <box_name>
```

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


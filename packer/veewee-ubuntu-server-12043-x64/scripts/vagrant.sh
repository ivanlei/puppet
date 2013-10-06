date > /etc/vagrant_box_build_time

# Setup sudo to allow no-password sudo for "sudo"
usermod -a -G sudo vagrant

# Installing vagrant keys
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
cd /home/vagrant/.ssh
cp /tmp/id_rsa_vagrant.pub /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

rm /tmp/id_rsa_vagrant.pub


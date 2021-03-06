if test -f .vbox_version ; then
  # The netboot installs the VirtualBox support (old) so we have to remove it
  if test -f /etc/init.d/virtualbox-ose-guest-utils ; then
    /etc/init.d/virtualbox-ose-guest-utils stop
  fi

  rmmod vboxguest
  aptitude -y purge virtualbox-ose-guest-x11 virtualbox-ose-guest-dkms virtualbox-ose-guest-utils

  # Install dkms for dynamic compiles
  apt-get install -y dkms

  # Install libdbus so virtualbox will autostart
  apt-get -y install --no-install-recommends libdbus-1-3

  # Install the VirtualBox guest additions
  VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
  VBOX_ISO=VBoxGuestAdditions_$VBOX_VERSION.iso
  mount -o loop $VBOX_ISO /mnt
  yes|sh /mnt/VBoxLinuxAdditions.run
  umount /mnt

  #Cleanup VirtualBox
  rm $VBOX_ISO
fi


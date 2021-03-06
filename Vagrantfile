# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

Vagrant.configure('2') do |global_config|

  global_config.vm.box = 'base'

  hostsyaml = YAML.load(File.open('/vms/hieradata/hosts.yaml', File::RDONLY).read)
  domain_name = hostsyaml['known_hosts::domain_name']

  def bool_to_on_off(val)
    if val
      return 'on'
    else
      return 'off'
    end
  end

  hostsyaml['known_hosts::hosts'].each do |vm_settings|
    vm_name = vm_settings['name']
    global_config.vm.define vm_name do |config|

      ###########
      # Params  #
      ###########
      ram            = vm_settings.fetch('ram',            '2048')
      cpus           = vm_settings.fetch('cpus',           '2')
      provisioner    = vm_settings.fetch('provisioner',    'puppet_server')
      enable_gui     = vm_settings.fetch('enable_gui',     false)
      enable_usb     = vm_settings.fetch('enable_usb',     false)
      forward_ssh    = vm_settings.fetch('forward_ssh',    false)
      no_puppet      = vm_settings.fetch('no_puppet',      false)
      debug          = vm_settings.fetch('debug',          false)
      enable_nat_dns = false
      hostname       = "#{vm_name}.#{domain_name}"

      config.ssh.forward_agent  = forward_ssh
      config.vm.hostname        = hostname

      config.vm.network :private_network, ip: vm_settings['ip']

      ###############
      # VirtualBox  #
      ###############
      config.vm.provider :virtualbox do |vb|
        vb.gui = enable_gui

        vb.customize [
          'modifyvm',     :id,
          '--memory',     ram,
          '--cpus',       cpus,
          '--acpi',       'on',
          '--hwvirtex',   'on',
          '--largepages', 'on',
          '--audio',      'none',
          '--usb',        bool_to_on_off(enable_usb)]

        if enable_gui
          vb.customize [
            'modifyvm',        :id,
            '--vram',          '64',
            '--accelerate3d',  'on']
        end
      end

      ##################
      # VMWare Fusion  #
      ##################
      config.vm.provider :vmware_fusion do |vf|
        vf.gui = enable_gui

        # http://www.sanbarrow.com/vmx.html
        vf.vmx['memsize']       = ram
        vf.vmx['numvcpus']      = cpus
        vf.vmx['usb.present']   = enable_usb
        vf.vmx['sound.present'] = false
        vf.vmx['displayName']   = vm_name
      end

      ###########
      # Puppet  #
      ###########
      if debug
        puppet_options = '--verbose --debug'
      else
        puppet_options = ''
      end

      if 'puppet' == provisioner
        config.vm.provision :puppet do |puppet|
          puppet.module_path       = ['/vms/modules']
          puppet.manifests_path    = '/vms/manifests'
          puppet.manifest_file     = "#{vm_name}.pp"
          puppet.hiera_config_path = '/vms/hiera.yaml'
          puppet.working_directory = '/vms/hieradata'
          puppet.options           = puppet_options + ' --parser=future'
        end
      end

      if 'puppet_server' == provisioner
        config.vm.provision :puppet do |puppet|
          puppet.puppet_server = "puppet.#{domain_name}"
          puppet.puppet_node   = hostname
          puppet.options       = puppet_options + ' --parser=future'
        end
      end
    end
  end
end

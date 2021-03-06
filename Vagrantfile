# -*- mode: ruby -*-
# vi: set ft=ruby :

# Author: S. Guclu
# description: created VM and provisions basic tools

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "puppetlabs/centos-7.0-64-puppet"
  config.vm.host_name = "CENTOS64AUTOSLAVE"
  
  # The url from where the 'config.vm.box' box will be fetched if it
  # doesnl from where the 'co"'t already exist on the user's system.
  config.vm.box_url = "https://atlas.hashicorp.com/puppetlabs/boxes/centos-7.0-64-puppet" 

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  # config.vm.network :hostonly, "192.168.33.10"

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
  config.vm.network :bridged, :bridge => "tap0", :mac => "080027B11DDD"
  config.vm.forward_port 22, 2299, :adapter => 1
  #config.vm.forward_port 8080, 8150, :adapter => 1
  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.forward_port 80, 8080

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  # Enable provisioning with Puppet stand alone. Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file base.pp in the manifests_path directory.
  #
  # An example Puppet manifest to provision the message of the day:
  #
  # # group { "puppet":
  # # ensure => "present",
  # # }
  # #
  # # File { owner => 0, group => 0, mode => 0644 }
  # #
  # # file { '/etc/motd':
  # # content => "Welcome to your Vagrant-built virtual machine!
  # # Managed by Puppet.\n"
  # # }
  #
# config.vm.provision :shell do |shell|
# shell.inline = "mkdir -p /etc/puppet/modules;
# puppet module install maestrodev-jetty"
# end


  # taken from https://github.com/purple52/librarian-puppet-vagrant
  # see this discuss about puppet modules install on vagrant context : https://groups.google.com/forum/#!topic/vagrant-up/zLCnqzCYckA
  # This shell provisioner installs librarian-puppet and runs it to install
  # puppet modules. This has to be done before the puppet provisioning so that
  # the modules are available when puppet tries to parse its manifests.
  config.vm.provision :shell do |shell|
    shell.path = "librarian-puppet.sh"
  # uncomment the next line if you want to install the librarian-ruby gem instead the package
  #  shell.args = "-g"
  end

# cacerts file copy
  config.vm.provision "file", source: "cacerts", destination: "/tmp/cacerts"

# calling puppet provisionner
  config.vm.provision :puppet do |puppet|
  #   puppet.options = "--debug"
     puppet.manifests_path = "."
     puppet.manifest_file = "puppet.pp"
  end

  #config.vm.provision "docker" do |docker|
    # docker.build_image "/vagrant/app"
  #end

  # Enable provisioning with chef solo, specifying a cookbooks path (relative
  # to this Vagrantfile), and adding some recipes and/or roles.
  #
  # config.vm.provision :chef_solo do |chef|
  # chef.cookbooks_path = "cookbooks"
  # chef.add_recipe "mysql"
  # chef.add_role "web"
  #
  # # You may also specify custom JSON attributes:
  # chef.json = { :mysql_password => "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision :chef_client do |chef|
  # chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  # chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # IF you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  # chef.validation_client_name = "ORGNAME-validator"
end

Vagrant.configure("2") do |config|
  
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    vb.customize [ "modifyvm", :id, "--cpus", 2 ]
    vb.customize [ "modifyvm", :id, "--memory", 2048 ]
    vb.customize [ "modifyvm", :id, "--name", "CENTOS64AUTOSLAVE" ]
  end
end

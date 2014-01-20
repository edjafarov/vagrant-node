# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Use [berkshelf](http://berkshelf.com/)
  config.berkshelf.enabled = true
  
  # VM name
  config.vm.hostname = "50logic"
  config.ssh.forward_agent = true
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise32"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.synced_folder "src/", "/home/vagrant/app", create: true
  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  
  # redis server port
  config.vm.network :forwarded_port, guest: 6379, host: 6379

  # local web server port
  config.vm.network :forwarded_port, guest: 8080, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  
  # Use VBoxManage to customize the VM. Change memory and limit VM's CPU.
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
    vb.customize ["modifyvm", :id, "--hwvirtex", "off"]
  end
  

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision :chef_solo do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end

  # Update the list of available packages, use sudo apt-get upgrade -y to actually do the upgrades
  config.vm.provision :shell, :inline => "sudo apt-get update -y"

  # Install packages
  config.vm.provision :chef_solo do |chef|
    chef.json = {
      "nodejs" => {
        "version" => "0.10.24"
      }
    }

    chef.add_recipe "git"
    chef.add_recipe "nodejs"
    chef.add_recipe "vim"

  end

  # install global node modules
  config.vm.provision :shell, :inline => "npm install -g brunch nodemon http-server"
  config.vm.provision :shell, :inline => "git clone https://github.com/edjafarov/dotfiles.git /home/vagrant/dotfiles", privileged:false
  config.vm.provision :shell, :inline => "cd /home/vagrant/dotfiles && ./vagrantstrap.sh", privileged:false

end

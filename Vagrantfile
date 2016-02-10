# -*- mode: ruby -*-
# vi: set ft=ruby :


$script = <<SCRIPT
sudo apt-get update
sudo apt-get install -y make gcc g++ openjdk-7-jre-headless nodejs nodejs-legacy
wget https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
bash ./Miniconda-latest-Linux-x86_64.sh -b -p $HOME/miniconda
export PATH=/home/vagrant/miniconda/bin:$PATH
cd /vagrant/source
bash app_setup.sh
# reconfigure supervisor to bind django to 0.0.0.0
sed -i "s#command=python manage.py runserver 127.0.0.1:8000#command=python manage.py runserver 0.0.0.0:8000#g" supervisord.conf
echo "source /home/vagrant/miniconda/envs/memex/bin/activate memex" >> ~/.bashrc
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "                        MEMEX EXPLORER INSTALLED                           "
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo ""
echo "Log into your VM: vagrant ssh"
echo "Launch Memex Explorer: cd /vagrant/source; supervisord"
echo "Open a browser at http://localhost:8000"
SCRIPT

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # We bring the memex-explorer main server up on 8000
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.network "forwarded_port", guest: 8084, host: 8084
  config.vm.network "forwarded_port", guest: 8888, host: 28888
  # And (if needed) a local elasticsearch container up on 9200
  config.vm.network "forwarded_port", guest: 9200, host: 9200
  # And (if needed) a local kibana container up on 9999
  config.vm.network "forwarded_port", guest: 9999, host: 9999
  # And (if needed) a local tika container up on 9998
  config.vm.network "forwarded_port", guest: 9998, host: 9998

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  # config.vm.synced_folder "deploy/salt/roots/", "/srv"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
    vb.memory = "6144"
    vb.cpus = 4
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.

  config.vm.provision "shell", privileged: false, inline: $script
end

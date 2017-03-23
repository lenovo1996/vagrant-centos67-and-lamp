VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos67"
  config.vm.hostname = "centos67-and-lamp.dev"
  config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.boot_timeout = 600
  config.ssh.insert_key = false
  config.vm.synced_folder "src", "/var/www/html", create:true, owner:"vagrant", group:"vagrant", mount_options: ["dmode=777","fmode=766"]
  config.vm.box_url = "https://github.com/CommanderK5/packer-centos-template/releases/download/0.6.7/vagrant-centos-6.7.box"
  $script=<<SCRIPT
sudo yum -y install git epel-release ansible; ansible-playbook /vagrant/install.yml; php -f /var/www/html/phpinfo.php
SCRIPT
  config.vm.provision :shell, :inline => $script
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096"]
    file_to_disk = "tmp/disk.vdi"
    if not File.exist?(file_to_disk) then
      vb.customize ["createhd",
                    "--filename", file_to_disk,
                    "--size", 100 * 2048]
    end
    vb.customize ['storageattach', :id,
                  '--storagectl', 'SATA Controller',
                  '--port', 1,
                  '--device', 0,
                  '--type', 'hdd',
                  '--medium', file_to_disk]
  end
  config.vm.provision "shell", path: "bootstrap.sh"
end

Vagrant::Config.run do |config|
  config.ssh.private_key_path = "~/.ssh/id_rsa.vagrant"
  config.vm.box = "dev_ops_center_box"
  config.vm.host_name = "dev_ops_central"
  config.vm.network :hostonly, "192.168.1.11"
  config.vm.provision :puppet do |puppet|
    puppet.manifest_file = "site.pp"
    puppet.module_path = File.expand_path("../modules", __FILE__)
    puppet.options = "--verbose" 
  end
end

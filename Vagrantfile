Vagrant::Config.run do |config|
  config.ssh.private_key_path = File.expand_path("../dev_ops_central/id_rsa.vagrant")
  config.vm.box = "dev_ops_central_box"
  config.vm.host_name = "dev_ops_central"
  config.vm.provision :puppet do |puppet|
    puppet.manifest_file = "site.pp"
    puppet.module_path = File.expand_path("../modules", __FILE__)
    puppet.options = "--verbose" 
  end
  config.vm.forward_port 55672, 55672 # needed for rabbitmq management frontend
end

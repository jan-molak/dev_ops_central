Vagrant::Config.run do |config|
  config.ssh.private_key_path = File.expand_path("../dev_ops_central/id_rsa.vagrant")
  config.vm.box = 'dev_ops_central'
  config.vm.provision :shell do |shell|
    shell.inline = "cp /vagrant/modules/hiera/files/etc/puppet/hieradb/default.json /etc/puppet/hieradb"
  end
  config.vm.provision :puppet do |puppet|
    puppet.manifest_file = "site.pp"
    puppet.module_path = File.expand_path("../modules", __FILE__)
    puppet.options = "--verbose" 
  end

  config.vm.define :monitoring_server do |server|
    server.vm.host_name = "monitoring_server"
    server.vm.network :hostonly, "192.168.10.10"
    server.vm.forward_port 55672, 55672 # needed for rabbitmq management frontend (guest/guest)
    server.vm.forward_port 8080, 8080 # needed for sensu dashboard (admin/secret)
    server.vm.forward_port 80, 9080 # needed for graphite webapp
  end

  config.vm.define :monitoring_client do |client|
    client.vm.host_name = "monitoring_client"
    client.vm.network :hostonly, "192.168.10.20"
  end

end

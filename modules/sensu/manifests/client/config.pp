class sensu::client::config {
  
  file{'/etc/sensu/conf.d/client.json':
    ensure => present,
    source => '/vagrant/modules/sensu/files/etc/sensu/conf.d/client.json',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  file{'/etc/sensu/plugins':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => true
  }

}

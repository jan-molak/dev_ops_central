class sensu::config {



  file{'/etc/sensu/handlers':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => true
  }
 
  file{'/etc/sensu/handlers/metrics':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    recurse => true
  }

  file{'/etc/sensu/handlers/metrics/graphite-tcp.rb':
    ensure  => present,
    source  => '/vagrant/modules/sensu/files/etc/sensu/handlers/metrics/graphite-tcp.rb',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/etc/sensu/handlers/metrics'],
  }




  file{'/etc/sensu/conf.d/client.json':
    ensure  => present,
    source  => '/vagrant/modules/sensu/files/etc/sensu/conf.d/client.json',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/etc/sensu/conf.d'],
  }
}


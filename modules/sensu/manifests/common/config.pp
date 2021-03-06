class sensu::common::config {
  
  file{'/etc/sensu/ssl':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file{'/etc/sensu/ssl/client_key.pem':
    ensure  => present,
    source  => '/vagrant/modules/sensu/files/etc/sensu/ssl/client_key.pem',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/etc/sensu/ssl'],
  }

  file{'/etc/sensu/ssl/client_cert.pem':
    ensure  => present,
    source  => '/vagrant/modules/sensu/files/etc/sensu/ssl/client_cert.pem',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/etc/sensu/ssl'],
  }

  file{'/etc/sensu/config.json':
    ensure => present,
    source => '/vagrant/modules/sensu/files/etc/sensu/config.json',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  File['/etc/sensu/ssl'] -> File['/etc/sensu/ssl/client_key.pem']
  File['/etc/sensu/ssl'] -> File['/etc/sensu/ssl/client_cert.pem']
}

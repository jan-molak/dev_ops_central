class sensu {
  info "Provisioning Sensu"

  yumrepo{'sensu':
    name => 'sensu-main',
    baseurl => 'http://repos.sensuapp.org/yum/el/6/i386/',
    enabled => '1',
    gpgcheck => '0',
  }  

  package{"sensu":
    ensure => "present",
    require => Yumrepo['sensu'],
  }

  service{"sensu-server":
    ensure => "running",
    require => File['/etc/sensu/config.json'],
  }

  service{"sensu-api":
    ensure => "running",
    require => Service['sensu-server'],
  }

  service{"sensu-client":
    ensure => "running",
    require => Service['sensu-server'],
  }

  service{"sensu-dashboard":
    ensure => "running",
    require => Service['sensu-server'],
  }

  file{'/etc/sensu/ssl':
    ensure => 'directory',
    owner => 'root',
    group => 'root',
    mode => '644',
    require => Package['sensu'],
  }

  file{'/etc/sensu/conf.d':
    ensure => 'directory',
    owner => 'root',
    group => 'root',
    mode => '644',
    require => Package['sensu'],
  }

  file{'/etc/sensu/ssl/client_key.pem':
    source => '/vagrant/modules/sensu/files/etc/sensu/ssl/client_key.pem',
    owner => 'root',
    group => 'root',
    mode => '644',
    require => File['/etc/sensu/ssl'],   
  }

  file{'/etc/sensu/ssl/client_cert.pem':
    source => '/vagrant/modules/sensu/files/etc/sensu/ssl/client_cert.pem',
    owner => 'root',
    group => 'root',
    mode => '644',
    require => File['/etc/sensu/ssl'],   
  }

  file{'/etc/sensu/config.json':
    source => '/vagrant/modules/sensu/files/etc/sensu/config.json',
    owner => 'root',
    group => 'root',
    mode => '644',
    require => Package['sensu'],
  }

  file{'/etc/sensu/conf.d/client.json':
    source => '/vagrant/modules/sensu/files/etc/sensu/conf.d/client.json',
    owner => 'root',
    group => 'root',
    mode => '644',
    require => File['/etc/sensu/conf.d'],
  }

}

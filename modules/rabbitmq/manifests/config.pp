class rabbitmq::config
{
  file { '/etc/rabbitmq/rabbitmq.config':
    source => '/vagrant/modules/rabbitmq/files/etc/rabbitmq/rabbitmq.config',
    owner => 'root',
    group => 'root',
    mode => '644'
  }

	file { '/etc/rabbitmq/ssl/':
    ensure => 'directory',    
    owner => 'root',
    group => 'root',
    mode => '644'
  }

  file { '/etc/rabbitmq/ssl/server_key.pem':
    source => '/vagrant/modules/rabbitmq/files/etc/rabbitmq/ssl/server_key.pem',
    owner => 'root',
    group => 'root',
    mode => '644'
  }

  file { '/etc/rabbitmq/ssl/server_cert.pem':
    source => '/vagrant/modules/rabbitmq/files/etc/rabbitmq/ssl/server_cert.pem',
    owner => 'root',
    group => 'root',
    mode => '644'
  }

  file { '/etc/rabbitmq/ssl/cacert.pem':
    source => '/vagrant/modules/rabbitmq/files/etc/rabbitmq/ssl/cacert.pem',
    owner => 'root',
    group => 'root',
    mode => '644'
  }
 
  File['/etc/rabbitmq/ssl/'] -> File['/etc/rabbitmq/ssl/server_key.pem']
  File['/etc/rabbitmq/ssl/'] -> File['/etc/rabbitmq/ssl/server_cert.pem']
  File['/etc/rabbitmq/ssl/'] -> File['/etc/rabbitmq/ssl/cacert.pem']
}
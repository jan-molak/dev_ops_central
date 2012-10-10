class rabbitmq::config
{
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644'
  }

  file { '/etc/rabbitmq/rabbitmq.config':
    source => '/vagrant/modules/rabbitmq/files/etc/rabbitmq/rabbitmq.config'
  }

	file { '/etc/rabbitmq/ssl/':
    ensure => 'directory'
  }

  file { '/etc/rabbitmq/ssl/server_key.pem':
    source => '/vagrant/modules/rabbitmq/files/etc/rabbitmq/ssl/server_key.pem'
  }

  file { '/etc/rabbitmq/ssl/server_cert.pem':
    source => '/vagrant/modules/rabbitmq/files/etc/rabbitmq/ssl/server_cert.pem'
  }

  file { '/etc/rabbitmq/ssl/cacert.pem':
    source => '/vagrant/modules/rabbitmq/files/etc/rabbitmq/ssl/cacert.pem'
  }
 
  File['/etc/rabbitmq/ssl/'] -> File['/etc/rabbitmq/ssl/server_key.pem']
  File['/etc/rabbitmq/ssl/'] -> File['/etc/rabbitmq/ssl/server_cert.pem']
  File['/etc/rabbitmq/ssl/'] -> File['/etc/rabbitmq/ssl/cacert.pem']
}
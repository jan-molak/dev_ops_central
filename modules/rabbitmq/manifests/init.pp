class rabbitmq {
  info "Provisioning RabbitMQ"

  $version = "2.7.1"
  $url     = "http://www.rabbitmq.com/releases/rabbitmq-server/v${version}/rabbitmq-server-${version}-1.noarch.rpm"

  yumrepo{"epel-6.6":
    mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6.6&arch=$basearch',
    gpgcheck   => 0
  }

  package{"erlang":
    ensure => "present",
    require => Yumrepo["epel-6.6"]
  }

  package{"rabbitmq-server":
    provider => "rpm",
    source   => $url,
    require  => Package["erlang"]
  }

  exec{"rabbitmq-plugins":
    path    => "/usr/bin:/usr/sbin:/bin",
    command => "rabbitmq-plugins enable rabbitmq_management",
    require => Package["rabbitmq-server"]
  }

  service{"rabbitmq-server":
    ensure  => "running",
    require => [Exec["rabbitmq-plugins"], File["/etc/rabbitmq/rabbitmq.config"]]
  }

  file { '/etc/rabbitmq/ssl/':
    ensure => 'directory',    
    owner => 'root',
    group => 'root',
    mode => '644',
    require => Package['rabbitmq-server'],
  }

  file { '/etc/rabbitmq/ssl/server_key.pem':
    source => '/vagrant/modules/rabbitmq/files/etc/rabbitmq/ssl/server_key.pem',
    owner => 'root',
    group => 'root',
    mode => '644',
    require => File['/etc/rabbitmq/ssl'],
  }

  file { '/etc/rabbitmq/ssl/server_cert.pem':
    source => '/vagrant/modules/rabbitmq/files/etc/rabbitmq/ssl/server_cert.pem',
    owner => 'root',
    group => 'root',
    mode => '644',
    require => File['/etc/rabbitmq/ssl'],
  }

  file { '/etc/rabbitmq/ssl/cacert.pem':
    source => '/vagrant/modules/rabbitmq/files/etc/rabbitmq/ssl/cacert.pem',
    owner => 'root',
    group => 'root',
    mode => '644',
    require => File['/etc/rabbitmq/ssl'],
  }
 
  file { '/etc/rabbitmq/rabbitmq.config':
    source => '/vagrant/modules/rabbitmq/files/etc/rabbitmq/rabbitmq.config',
    owner => 'root',
    group => 'root',
    mode => '644',
    require => Package['rabbitmq-server'],
  }

  exec { 'add sensu vhost':
    command => 'rabbitmqctl add_vhost /sensu',
    path    => "/usr/bin:/usr/sbin:/bin",
    user => 'root',
    group => 'root',
    #onlyif => '', # TODO this should only run when vhost has not been created
    require => Service['rabbitmq-server'],
  }

  exec { 'add sensu user':
    command => 'rabbitmqctl add_user sensu sensu',
    path    => "/usr/bin:/usr/sbin:/bin",
    user => 'root',
    group => 'root',
    #onlyif => '', # TODO this should only run when user has not been created
    require => Service['rabbitmq-server'],
  }

  exec { 'set sensu permissions':
    command => 'rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"',
    path    => "/usr/bin:/usr/sbin:/bin",
    user => 'root',
    group => 'root',
    require => Service['rabbitmq-server'],
  }

  service{"iptables":
    ensure  => "stopped"
  }
}

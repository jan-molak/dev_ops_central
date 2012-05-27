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
    require => [Package["rabbitmq-server"], Exec["rabbitmq-plugins"], File['/etc/rabbitmq/ssl']]
  }

  file { '/etc/rabbitmq/ssl/':
    source => '/etc/puppet/modules/rabbitmq/files/etc/rabbitmq/ssl/',
    owner => 'root',
    group => 'root',
    mode => '644',
  }

  file { '/etc/rabbitmq/ssl/server_key.pem':
    source => '/etc/puppet/modules/rabbitmq/files/etc/rabbitmq/ssl/server_key.pem',
    owner => 'root',
    group => 'root',
    mode => '644',
    notify => Service['rabbitmq-server'],
    require => Package['rabbitmq-server'],
  }

  file { '/etc/rabbitmq/ssl/server_cert.pem':
    source => '/etc/puppet/modules/rabbitmq/files/etc/rabbitmq/ssl/server_cert.pem',
    owner => 'root',
    group => 'root',
    mode => '644',
    notify => Service['rabbitmq-server'],
    require => Package['rabbitmq-server'],
  }

  file { '/etc/rabbitmq/ssl/cacert.pem':
    source => '/etc/puppet/modules/rabbitmq/files/etc/rabbitmq/ssl/cacert.pem',
    owner => 'root',
    group => 'root',
    mode => '644',
    notify => Service['rabbitmq-server'],
    require => Package['rabbitmq-server'],
  }
 
  file { '/etc/rabbitmq/rabbitmq.conf':
    source => '/etc/puppet/modules/rabbitmq/files/etc/rabbitmq/rabbitmq.conf',
    owner => 'root',
    group => 'root',
    mode => '644',
    notify => Service['rabbitmq-server'],
    require => Package['rabbitmq-server'],
  }

  service{"iptables":
    ensure  => "stopped"
  }
}
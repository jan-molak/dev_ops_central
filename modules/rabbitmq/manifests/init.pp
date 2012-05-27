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
    require => [Package["rabbitmq-server"], Exec["rabbitmq-plugins"]]
  }

  service{"iptables":
    ensure  => "stopped"
  }
}

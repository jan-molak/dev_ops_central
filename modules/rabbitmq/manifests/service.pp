class rabbitmq::service
{
  Exec {
    user => 'root',
    group => 'root'
  }

	service {'rabbitmq-server':
    ensure  => "running"
  }

  exec {'rabbitmq-plugins':
    path    => "/usr/bin:/usr/sbin:/bin",
    command => "rabbitmq-plugins enable rabbitmq_management",
    require => Package["rabbitmq-server"],
    environment => "HOME=/root"
  }

  exec {'add-sensu-vhost':
    command => 'rabbitmqctl add_vhost /sensu',
    unless => 'rabbitmqctl list_vhosts | grep sensu',
    path    => "/usr/bin:/usr/sbin:/bin"
  }

  exec {'add-sensu-user':
    command => 'rabbitmqctl add_user sensu sensu',
    unless =>   "/usr/sbin/rabbitmqctl list_users | grep sensu",
    path    => "/usr/bin:/usr/sbin:/bin"
  }

  exec {'set-sensu-permissions':
    command => 'rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"',
    unless =>   "/usr/sbin/rabbitmqctl list_user_permissions sensu | grep '\\.\\*\\s\\.\\*\\s\\.\\*'",
    path    => "/usr/bin:/usr/sbin:/bin"
  }

  Service['rabbitmq-server'] -> Exec['add-sensu-vhost'] -> Exec['add-sensu-user'] -> Exec['set-sensu-permissions']
}
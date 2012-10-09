class sensu::client::config(
  $rabbitmq_server=hiera('rabbitmq_server'),
  $sensu_client=hiera('sensu_client'))
{
  
  file{'/etc/sensu/conf.d/rabbitmq.json':
      ensure => present,
      content => template('/vagrant/modules/sensu/templates/etc/sensu/conf.d/rabbitmq.json.erb'),
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
  }

  file{'/etc/sensu/conf.d/client.json':
      ensure => present,
      content => template('/vagrant/modules/sensu/templates/etc/sensu/conf.d/client.json.erb'),
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
  }

  file{'/etc/sensu/conf.d/checks.json':
      ensure => present,
      source => '/vagrant/modules/sensu/files/etc/sensu/conf.d/checks.json',
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

  file{'/etc/sensu/plugins/check-procs.rb':
      ensure => present,
      source => '/vagrant/modules/sensu/files/etc/sensu/plugins/check-procs.rb',
      owner  => 'sensu',
      group  => 'sensu',
      mode   => '0744',
  }

  file{'/etc/sensu/plugins/cpu-metrics.rb':
      ensure => present,
      source => '/vagrant/modules/sensu/files/etc/sensu/plugins/cpu-metrics.rb',
      owner  => 'sensu',
      group  => 'sensu',
      mode   => '0744',
  }
}

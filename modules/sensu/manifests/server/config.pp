class sensu::server::config {
  
  file{'/etc/sensu/handlers':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => true
  }

}

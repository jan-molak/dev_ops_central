class rabbitmq {
  info "Provisioning RabbitMQ"

  include rabbitmq::package, rabbitmq::config, rabbitmq::service

  Class['rabbitmq::package'] -> Class['rabbitmq::config'] -> Class['rabbitmq::service']
  Class['rabbitmq::config'] ~> Class['rabbitmq::service']
}

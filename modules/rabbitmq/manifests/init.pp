class rabbitmq {
  info "Provisioning RabbitMQ"

  include rabbitmq::package
  include rabbitmq::config
  include rabbitmq::service

  Class['rabbitmq::package'] -> Class['rabbitmq::config'] -> Class['rabbitmq::service']
}

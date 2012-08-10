class role_monitoring_server {
  $my_role = monitoring_server
  include apache
  include rabbitmq
  include redis
  include sensu::server
}

class role_monitoring_client {
  $my_role = monitoring_client
  include cron
  include sensu::client
}

node dev_ops_central {
  include role_monitoring_server
  include role_monitoring_client
}

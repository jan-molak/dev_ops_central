node dev_ops_central {
  include cron
  include apache
  include rabbitmq
  include redis
  include sensu
}

class sensu::common {

  include sensu::common::package, sensu::common::config

  Class['sensu::package'] -> Class['sensu::common::config']

}

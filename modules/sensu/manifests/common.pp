class sensu::common {

  include sensu::common::package, sensu::common::config

  Class['sensu::common::package'] -> Class['sensu::common::config']

}

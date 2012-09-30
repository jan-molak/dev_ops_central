class sensu::common {

	info "Provisioning Sensu Common"

  include sensu::common::package
  include sensu::common::config

}

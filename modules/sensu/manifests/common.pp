class sensu::common {
	info "Provisioning Sensu Common"

  include sensu::common::package, sensu::common::config
}

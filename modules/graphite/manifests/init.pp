class graphite
{
	info "Provisioning Graphite"

	include graphite::package, graphite::config, graphite::service

	Class['graphite::package'] -> Class['graphite::config'] -> Class['graphite::service']
	Class['graphite::config'] ~> Class['graphite::service']
}
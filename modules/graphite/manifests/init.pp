class graphite
{
	info "Provisioning Graphite"

	include graphite::package
	include graphite::config
	include graphite::service

	Class['graphite::package'] -> Class['graphite::config'] -> Class['graphite::service']
 }
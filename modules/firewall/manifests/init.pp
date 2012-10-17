class firewall {

	info "Provisioning firewall"

	service{"iptables":
    ensure  => "stopped"
  }
}
#!/usr/bin/env ruby
#
# HTTP Stat
# ===
#
# Takes either a URL or a combination of host/path/port/ssl, and checks for
# a 200 response (that matches a pattern, if given). Can use client certs.
#
# Copyright 2011 Sonian, Inc.
#
# Released under the same terms as Sensu (the MIT license); see LICENSE
# for details.

require 'rubygems' if RUBY_VERSION < '1.9.0'
require 'sensu-plugin/metric/cli'
require 'net/http'
require 'net/https'
require 'socket'
require 'pry'

class HttpStat < Sensu::Plugin::Metric::CLI::Graphite

  option :url, :short => '-u URL'
  option :host, :short => '-h HOST'
  option :path, :short => '-p PATH'
  option :port, :short => '-P PORT', :proc => proc {|a| a.to_i }
  option :ssl, :short => '-ssl', :boolean => true, :default => false
  option :insecure, :short => '-k', :boolean => true, :default => false
  option :cert, :short => '-c FILE'
  option :cacert, :short => '-C FILE'
  option :timeout, :short => '-t SECS', :proc => proc {|a| a.to_i }, :default => 15
  option :scheme,
    :description => "Metric naming scheme, text to prepend to metric",
    :short => "-s SCHEME",
    :long => "--scheme SCHEME",
    :default => "#{Socket.gethostname}"


  def run
    if config[:url]
      uri = URI.parse(config[:url])
      config[:host] = uri.host
      config[:path] = uri.path
      config[:port] = uri.port
      config[:ssl] = uri.scheme == 'https'
    else
      unless config[:host] and config[:path]
        unknown 'No URL specified'
      end
      config[:port] ||= config[:ssl] ? 443 : 80
    end

    begin

      timeout(config[:timeout]) do
        
        get_resource
        
      end
    rescue Timeout::Error
      critical "Connection timed out"
    rescue => e
      critical "Connection error: #{e.message}"
    end
  end

  def get_resource
    http = Net::HTTP.new(config[:host], config[:port])

    if config[:ssl]
      http.use_ssl = true
      if config[:cert]
        cert_data = File.read(config[:cert])
        http.cert = OpenSSL::X509::Certificate.new(cert_data)
        http.key = OpenSSL::PKey::RSA.new(cert_data, nil)
      end
      if config[:cacert]
        http.ca_file = config[:cacert]
      end
      if config[:insecure]
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
    end
	
	begin
		
		timestamp = Time.now.to_i
	
    	req = Net::HTTP::Get.new(config[:path])
    
    	previous_time = Time.now
    
   		res = http.request(req)
    
		response_time = (Time.now - previous_time) * 1000 
		
	rescue => e
		puts "Following error while connection occured:"
		puts e
	end
	
    case res.code
    when /^2/
      output [config[:scheme], 'response_time'].join("."), response_time, timestamp
    when /^4/, /^5/
      ok
	else
      ok
    end
  end

end

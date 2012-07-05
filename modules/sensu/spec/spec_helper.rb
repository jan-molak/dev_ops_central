# Based on https://github.com/puppetlabs/puppetlabs-ntp/blob/master/spec/spec_helper.rb
# Thanks to Ken Barber for advice about http://projects.puppetlabs.com/issues/11191  
require 'puppet'
require 'rspec-puppet'
require 'tmpdir'
#require "ftools"

RSpec.configure do |c|
  c.before :suite do
    # Create a temporary puppet confdir area and temporary site.pp so
    # when rspec-puppet runs we don't get a puppet error.
    @puppetdir = File.join(Dir.tmpdir, "puppet_rspec")
    Dir.mkdir(@puppetdir) unless File.directory?(@puppetdir)

    # Create a dummy file to ensure the cleanup happens in the right place
    FileUtils.touch(File.join(@puppetdir, "rspec.run"))
    
    ## Copy hiera.yaml if it's found
    hiera_config = File.join(File.dirname(__FILE__), "../../../hiera.yaml")
    File.copy(hiera_config, @puppetdir) if File.exists?(hiera_config)

    manifestdir = File.join(@puppetdir, "manifests")
    Dir.mkdir(manifestdir) unless File.directory?(manifestdir)
    FileUtils.touch(File.join(manifestdir, "site.pp"))
    Puppet[:confdir] = @puppetdir
  end

  c.after :suite do
    if File.exists?(@puppetdir) and File.exists?(File.join(@puppetdir, "rspec.run"))
      FileUtils.remove_entry_secure(@puppetdir)
    end
  end

  c.module_path = File.join(File.dirname(__FILE__), '../../')
end


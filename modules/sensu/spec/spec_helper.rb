#based on https://github.com/puppetlabs/puppetlabs-ntp/blob/master/spec/spec_helper.rb
# Thanks to Ken Barber for advice about http://projects.puppetlabs.com/issues/11191  
require 'puppet'
require 'rspec-puppet'
require 'tmpdir'
require 'fileutils'

RSpec.configure do |c|
  c.add_setting :puppetdir

  c.before :suite do
    # Create a temporary puppet confdir area and temporary site.pp so
    # when rspec-puppet runs we don't get a puppet error.
    c.puppetdir = File.join(Dir.tmpdir, "puppet_rspec")
    Dir.mkdir(c.puppetdir) unless File.directory?(c.puppetdir)

    ## Copy hiera config and data
    hiera_config = File.join(File.dirname(__FILE__), "../../../hiera.yaml")
    hiera_db     = File.join(File.dirname(__FILE__), "../../../hieradb")
    FileUtils.copy(hiera_config, c.puppetdir) if File.exists?(hiera_config)
    FileUtils.cp_r hiera_db, c.puppetdir if File.exists?(hiera_db)

    ## Patching hiera.yaml
    r = File.open("#{c.puppetdir}/hiera.yaml")
    content = Array.new
    r.each_line do |line|
      if line =~ /datadir/
        line.sub!(/:datadir.+/, ":datadir: #{c.puppetdir}/hieradb")
      end
      content << line
    end

    r.close()

    File.open("#{c.puppetdir}/hiera.yaml", 'w+') { |f| f.write(content) }

    manifestdir = File.join(c.puppetdir, "manifests")
    Dir.mkdir(manifestdir) unless File.directory?(manifestdir)
    FileUtils.touch(File.join(manifestdir, "site.pp"))
    
    ## Set confdir for puppet
    Puppet[:confdir] = c.puppetdir
  end

  c.after :suite do
    if File.exists?(c.puppetdir)
      FileUtils.remove_entry_secure(c.puppetdir)
    end
  end

  c.module_path = File.join(File.dirname(__FILE__), '../../')
end

require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'sensu', :type => :class do

  it ("contain class sensu::package") { should contain_class('sensu::package') }
  it ("contain class sensu::config") { should contain_class('sensu::config').with_notify('Class[Sensu::Service]') }
  it ("contain class sensu::service") { should contain_class('sensu::service') }
end


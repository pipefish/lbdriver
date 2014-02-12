require 'celluloid/io'
require 'yaml'

module LBDriver

  @connection = nil
  @configuration = nil
  @commandAPI = nil
  @adminAPI = nil
  @graphAPI = nil

  @logger = nil

  # Returns the global [Configuration](RSpec/Core/Configuration) object. While you
  # _can_ use this method to access the configuration, the more common
  # convention is to use [RSpec.configure](RSpec#configure-class_method).
  #
  # @example
  #     RSpec.configuration.drb_port = 1234
  # @see RSpec.configure
  # @see Core::Configuration
  def self.configuration(options={})
    #puts "In LBDriver#configuration with @configuration set to #{@configuration}: " + @configuration.inspect + "\n"
    @configuration ||= LBDriver::Configuration.new(options)
    @configuration
  end

  # @private
  # Used internally to set the global object
  #def self.configuration=(new_configuration)
  #  @configuration = new_configuration
  #end

  # Yields the global configuration to a block.
  # @yield [Configuration] global configuration
  #
  # @example
  #     RSpec.configure do |config|
  #       config.add_formatter 'documentation'
  #     end
  # @see Core::Configuration
  def self.configure
    yield configuration if block_given?
  end

  # Not for use by mortals. Simply a pooled but raw connection to the database. 
  # Caller must provide valid, serialized protobuf messages
  def self.getConnection(host,port)
    @connection ||= ConnectionPool.new { Connection.open(host, port) }
  end

  def self.getCommandAPI(options={})
    @commandAPI ||= LBDriver::CommandAPI.new(options)
  end

  def self.getAdminAPI(options={})
    @adminAPI ||= LBDriver::AdminAPI.new(options)
  end

  def self.getGraphAPI(options={})
    @graphAPI ||= LBDRiver::GraphAPI.new(options)
  end

  # Not for use by mortals. Simply a pooled but raw connection to the database. 
  # Caller must provide valid, serialized protobuf messages
  def self.connection(host,port)
    @connection ||= ConnectionPool.new { Connection.open(host, port) }
    yield @connection if block_given?
  end

  def self.command
    @commandAPI ||= LBDriver::CommandAPI.new()
    yield @commandAPI if block_given?
  end

  def self.admin
    @adminAPI ||= LBDriver::AdminAPI.new()
    yield @adminAPI if block_given?
  end

  def self.graph
    @graphAPI ||= LBDRiver::GraphAPI.new()
    yield @graphAPI if block_given?
  end

  # Normally you would let GC handle this but dropping TCP connections on a database isn't nice.
  # So, on close, we shutdown each connection cleanly and, just to be tidy, we get rid of the API objects.
  # If you don't like it, don't call it. ;-)
  def self.close
    @commandAPI.close if @commandAPI
    @adminAPI.close if @adminAPI
    @connectionAPI.close if @connectionAPI
    @graphAPI.close if @graphAPI

    @commandAPI = nil
    @adminAPI = nil
    @connectionAPI = nil
    @graphAPI = nil
    @configuration = nil
  end

end

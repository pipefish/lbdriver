# Blatantly stolen from RSpec

# used to verify the caller has given us a real network address
require "resolv"

module LBDriver
  class Configuration

    class BadLogicBloxConfigurationError < StandardError
    end

    # @private
    def self.define_reader(name)
      define_method(name) do
        variable = instance_variable_defined?("@#{name}") ? instance_variable_get("@#{name}") : nil
        variable
      end
    end

    # @private
    def self.define_aliases(name, alias_name)
      alias_method alias_name, name
      alias_method "#{alias_name}=", "#{name}="
      define_predicate_for alias_name
    end

    # @private
    def self.define_predicate_for(*names)
      names.each {|name| alias_method "#{name}?", name}
    end


    # @private
    #
    # As `add_setting` but only add the reader
    def self.add_read_only_setting(name, opts={})
      raise "Use the instance add_setting method if you want to set a default" if opts.has_key?(:default)
      define_reader name
      define_predicate_for name
    end

    # @private
    #
    # Invoked by the `add_setting` instance method. Use that method on a
    # `Configuration` instance rather than this class method.
    def self.add_setting(name, opts={})
      raise "Use the instance add_setting method if you want to set a default" if opts.has_key?(:default)
      attr_writer name
      add_read_only_setting name

      Array(opts[:alias_with]).each do |alias_name|
        define_aliases(name, alias_name)
      end
    end


    def adminport=(value)
      p = Integer(value)
      if (p<0 || p>65535) 
        raise BadLogicBloxConfigurationError.new("Admin port must be an integer between 0 and 65535")
      end
      @adminport = p
      rescue
        raise BadLogicBloxConfigurationError.new("Admin port must be an integer between 0 and 65535")
    end

    def commandport=(value)
      p = Integer(value)
      if (p<0 || p>65535)
        raise BadLogicBloxConfigurationError.new("Command port must be an integer between 0 and 65535") 
      end
      @commandport = p
      rescue
        raise BadLogicBloxConfigurationError.new("Command port must be an integer between 0 and 65535")
    end

    def isvalidporthost(value)
      return !!(value   =~ Resolv::IPv4::Regex) ||
             !!(value   =~ Resolv::IPv6::Regex) ||
             !!(Resolv::DNS::Host.new(value))
      rescue
        return false
    end

    def commandhost=(value)
      if isvalidporthost(value) 
        @commandhost = value
      else
        raise BadLogicBloxConfigurationError, "Command host did not contain a valid hostname or IP address: " + value
      end
    end

    def adminhost=(value)
      if isvalidporthost(value)
        @adminhost = value
      else
        raise BadLogicBloxConfigurationError, "Command host did not contain a valid hostname or IP address: " + value
      end
    end




    def add_setting(name, opts={})
        default = opts.delete(:default)
        (class << self; self; end).class_eval do
          add_setting(name, opts)
        end
        __send__("#{name}=", default) if default
    end

    # initialize can take a YAML file and/or a hash of options
    # if both are given then the YAML file is read and the options override it
    # The defaults are overriden by either case
    def initialize(initopts={})
      add_setting(:logger)
      add_setting(:adminhost, :default=>"localhost")
      add_setting(:adminport, :default=>55181)
      add_setting(:commandhost, :default=>"localhost")
      add_setting(:commandport, :default=>55179)

      #puts "In Configuration#initialize with initopts = " + initopts.inspect + "\n"

      if initopts[:defaultconfiguration]
        #puts "In Configuration#initialize with a found :defaultconfiguration: " + initopts[:defaultconfiguration].inspect() + "\n"

        @adminhost = initopts[:defaultconfiguration].adminhost
        @logger = initopts[:defaultconfiguration].logger
        @adminport = initopts[:defaultconfiguration].adminport
        @commandhost = initopts[:defaultconfiguration].commandhost
        @commandport = initopts[:defaultconfiguration].commandport
      end

      if initopts[:yamlfile]
        configure_with_yaml(initopts[:yamlfile])
      end

      if initopts[:options]
        configure(initopts[:options])
      else
        configure
      end
      #puts "Exiting Configuration#initialize with configuration set to: " + self.inspect + "\n"
    end

    # Configure through yaml file
    def configure_with_yaml(path_to_yaml_file)
      yaml = YAML::load(IO.read(path_to_yaml_file))
      configure(yaml)
    end

    def configure(initopts={})
      #puts "In Configuration#configure with initopts = " + initopts.inspect + "\n"
      @logger =     initopts["logger"]     if initopts.has_key?("logger")
      @adminhost =    initopts["adminhost"]         if initopts.has_key?("adminhost")
      @adminport =    initopts["adminport"].to_i    if initopts.has_key?("adminport")
      @commandhost =  initopts["commandhost"]       if initopts.has_key?("commandhost")
      @commandport =  initopts["commandport"].to_i  if initopts.has_key?("commandport")
    end
    
  end # Configuration
end # LBDriver
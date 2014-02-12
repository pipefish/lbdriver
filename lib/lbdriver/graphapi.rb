# This isn't nearly as DRY as it should be. Will refactor once I know it works

require "protobuf"
require "lbdriver"
require "lbdriver/connection"
require "connection_pool"
require "blox/connect/ConnectBlox.pb"

module LBDriver
    class GraphAPI

        localoptions = nil

        def initialize(myoptions={}, &block)
            puts "in adminapi#initialize myoptions is #{myoptions}\n"
            localoptions = LBDriver::Configuration.new(nil,myoptions,LBDriver.configuration)
            puts "in adminapi.rb#initialize options is #{localoptions}\n"
            if !@adminpool
                    @commandpool = ConnectionPool.new { Connection.open(localoptions.adminhost, localoptions.adminport) }
            end
            yield_or_eval(&block) if block_given?
        end

        def yield_or_eval(&block)
            return unless block
            block.arity > 0 ? yield(self) : self.instance_eval(&block)
        end

        def close
            @commandpool.shutdown { |conn| conn.close }
        end


        
    end 
end
# This isn't nearly as DRY as it should be. Will refactor once I know it works

require "protobuf"
require "lbdriver"
require "lbdriver/connection"
require "connection_pool"
require "blox/connect/ConnectBlox.pb"

module LBDriver
    class AdminAPI

        localoptions = nil
        @adminpool = nil

        def initialize(myoptions={}, &block)
            #puts "in adminapi#initialize myoptions is #{myoptions}\n"
            #puts "in admin#initialize defaultconfiguration is " + LBDriver.configuration.inspect + "\n\n"
            localoptions = LBDriver::Configuration.new({ 
                                                            :myoptions => myoptions, 
                                                            :defaultconfiguration => LBDriver.configuration
                                                        })
            #puts "in adminapi.rb#initialize options is " + localoptions.inspect + "\n"
            #STDOUT.flush
            #STDERR.flush
            if !@adminpool
                    @adminpool = ConnectionPool.new { Connection.open(localoptions.adminhost, localoptions.adminport) }
            end
            yield_or_eval(&block) if block_given?
        end

        def yield_or_eval(&block)
            return unless block
            block.arity > 0 ? yield(self) : self.instance_eval(&block)
        end

        def close
            @adminpool.shutdown { |conn| conn.close }
        end


        def listWorkspaces
            # This block should return the array as its result. Since its the last thing in this function then this function should also return the array
            # Since the connection is inside the do block the connection will be checked out and back in.
            @adminpool.with do |conn|  
                message = ::Blox::Connect::AdminRequest.new(:list_workspaces => true)
                conn.send_request(0,message.to_s)
                rawResponse = conn.get_response
                response = ::Blox::Connect::AdminResponse.new.parse_from_string(rawResponse)
                #puts "in AdminAPI#listWorkspaces: response is " + response.inspect + "\n"
                if response.list_workspaces.nil? 
                    return {}
                else
                    return response.list_workspaces.name
                end
            end
        end

        def getStatus(workspaces)
            # This block should return the array as its result. Since its the last thing in this function then this function should also return the array
            # Since the connection is inside the do block the connection will be checked out and back in.
            @adminpool.with do |conn|  
                message = ::Blox::Connect::AdminRequest.new(:workspaces => workspaces, :show_active_requests => true, :show_queued_requests => true)
                conn.send_request(0,message.to_s)
                rawResponse = conn.get_response
                response = ::Blox::Connect::AdminResponse.new.parse_from_string(rawResponse)
                response.status.workspaces
            end
        end
    end 
end
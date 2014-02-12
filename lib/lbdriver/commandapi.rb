# This isn't nearly as DRY as it should be. Will refactor once I know it works

require "protobuf"
require "lbdriver"
require "lbdriver/connection"
require "connection_pool"
require "blox/connect/ConnectBlox.pb"

module LBDriver
    class CommandAPI

        localoptions = nil

        def initialize(myoptions={}, &block)
            localoptions = LBDriver::Configuration.new({ 
                                                            :myoptions => myoptions, 
                                                            :defaultconfiguration => LBDriver.configuration
                                                        })
            if !@commandpool
                    @commandpool = ConnectionPool.new { Connection.open(localoptions.commandhost, localoptions.commandport) }
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

        def columnToValues(col) 
            if col.string_column
                return {
                    type: 'string',
                    values: col.string_column.values
                }
            elsif col.int64_column
                return {
                    type: 'int',
                    values: col.int64_column.values
                }
            elsif col.float64_column
                return {
                    type: 'float',
                    values: col.float64_column.values
                }
            elsif col.decimal_column
                return {
                    type: 'decimal',
                    values: col.decimal_column.values
                }
            elsif col.bool_column
                return {
                    type: 'bool',
                    values: col.bool_column.values
                }
            elsif col.datetime_column
                return {
                    type: 'datetime',
                    values: col.datetime_column.values
                }
            elsif col.entity_column
                return {
                    type: 'entity',
                    values: columnToValues(col.entity_column.refmode_values)
                }
            else
                return col
            end
        end

        def jsonValue(type, val) 
            case type
            when 'int'
                return val.to_s
            when 'decimal'
                return val.to_s
            else
                return val
            end
        end

        def flipColumns(cols) 
            colValues = cols.map{ |col| columnToValues(col) }
            results = []
            myval = {}
            for i in 0..(colValues[0].values.length - 1)
                row = []
                for j in 0..(colValues.length - 1)
                    mytype = colValues[j][:type]
                    myvalues = colValues[j][:values]
                    myval[:type] = mytype
                    myval[:value] = jsonValue(mytype, myvalues[i])
                    row << { :type => mytype, :value => jsonValue(mytype,myvalues[i]) }
                end
                results << row
            end
            return results
        end

        def transaction(workspace, readonly, commands) 
            return ::Blox::Connect::Transaction.new(:workspace => workspace,
                                                    :readonly => readonly,
                                                    :exclusive => false,
                                                    :command => commands,
                                                    :command_after_fixpoint => [])
        end

        def addBlock(workspace, params)

            
            # This block should return the array as its result. Since its the last thing in this function then this function should also return the array
            # Since the connection is inside the do block the connection will be checked out and back in.
            @commandpool.with do |conn|  
                newtransaction = transaction(workspace, 
                                             false,
                                             [::Blox::Connect::Command.new(:add_block => ::Blox::Connect::AddBlock.new(:block_name => params[:name], 
                                                                                             :active => !params[:inactive],
                                                                                             :logic => params[:logic]))
                                             ])

                message = ::Blox::Connect::Request.new(:transaction => newtransaction)
                conn.send_request(0,message.to_s)
                rawResponse = conn.get_response
                response = ::Blox::Connect::Response.new.parse_from_string(rawResponse)
                #response.transaction.command[0].add_block.block_name
                return response.transaction.command[0].add_block.block_name
            end
        end

        def exec(workspace, params)
            if !@commandpool
                        @commandpool = ConnectionPool.new { Connection.open(@config.commandhost, @config.commandport) }
            end
            params[:returnLocal] ||= []
            # This block should return the array as its result. Since its the last thing in this function then this function should also return the array
            # Since the connection is inside the do block the connection will be checked out and back in.
            @commandpool.with do |conn|  
                newtransaction = transaction(workspace, 
                                             false,
                                             [::Blox::Connect::Command.new(:exec => ::Blox::Connect::ExecBlock.new(:block_name => params[:name], 
                                                                                             :logic => params[:logic],
                                                                                             :return_local => params[:returnLocal] ))
                                             ])

                message = ::Blox::Connect::Request.new(:transaction => newtransaction)
                conn.send_request(0,message.to_s)
                rawResponse = conn.get_response
                response = ::Blox::Connect::Response.new.parse_from_string(rawResponse)
                response
            end
        end

        
        # Convenience wrapper around exec
         
        def query(workspace, params) 
            if !@commandpool
                        @commandpool = ConnectionPool.new { Connection.open(@config.commandhost, @config.commandport) }
            end
            # This block should return the array as its result. Since its the last thing in this function then this function should also return the array
            # Since the connection is inside the do block the connection will be checked out and back in.
            result = nil
            @commandpool.with do |conn|  
                newtransaction = transaction(workspace, 
                                             true,
                                             [::Blox::Connect::Command.new(:exec => ::Blox::Connect::ExecBlock.new(
                                                                                             :logic => params[:logic],
                                                                                             :return_local => ["_"] ))
                                             ])

                message = ::Blox::Connect::Request.new(:transaction => newtransaction)
                conn.send_request(0,message.to_s)
                rawResponse = conn.get_response
                response = ::Blox::Connect::Response.new.parse_from_string(rawResponse)
                result = flipColumns(response.transaction.command[0].exec.return_local[0].column)
            end
            result
        end
        
        def queryPredicate(workspace, name)
            if !@commandpool
                        @commandpool = ConnectionPool.new { Connection.open(@config.commandhost, @config.commandport) }
            end
            # This block should return the array as its result. Since its the last thing in this function then this function should also return the array
            # Since the connection is inside the do block the connection will be checked out and back in.
            result = nil
            @commandpool.with do |conn|  
                querypredicate = ::Blox::Connect::QueryPredicate.new(:predicate => 
                                                                        ::Blox::Connect::PredicateName.new(:global_name =>
                                                                            ::Blox::Connect::GlobalPredicateName.new(:qualified_name => name)))
                newtransaction = transaction(workspace, 
                                             true,
                                             [::Blox::Connect::Command.new(:query_predicate => querypredicate)])

                message = ::Blox::Connect::Request.new(:transaction => newtransaction)
                conn.send_request(0,message.to_s)
                rawResponse = conn.get_response
                response = ::Blox::Connect::Response.new.parse_from_string(rawResponse)
                result = flipColumns(response.transaction.command[0].query_predicate.relation.column)
            end
            result
            
        end


        def listPredicates(workspace)
            if !@commandpool
                        @commandpool = ConnectionPool.new { Connection.open(@config.commandhost, @config.commandport) }
            end
            # This block should return the array as its result. Since its the last thing in this function then this function should also return the array
            # Since the connection is inside the do block the connection will be checked out and back in.
            result = nil
            @commandpool.with do |conn| 
                newtransaction = transaction(workspace, 
                                             true,
                                             [::Blox::Connect::Command.new(:pred_info_bulk => ::Blox::Connect::GetPredicateInfoBulk.new())])

                message = ::Blox::Connect::Request.new(:transaction => newtransaction)
                conn.send_request(0,message.to_s)
                rawResponse = conn.get_response
                response = ::Blox::Connect::Response.new.parse_from_string(rawResponse)
                result = response.transaction.command[0].pred_info_bulk.info
            end
        end
        
        def predInfo(workspace, name)
            if !@commandpool
                        @commandpool = ConnectionPool.new { Connection.open(@config.commandhost, @config.commandport) }
            end
            # This block should return the array as its result. Since its the last thing in this function then this function should also return the array
            # Since the connection is inside the do block the connection will be checked out and back in.
            result = nil
            @commandpool.with do |conn|  
                querypredicate = ::Blox::Connect::GetPredicateInfo.new(:predicate => 
                                                                        ::Blox::Connect::PredicateName.new(:global_name =>
                                                                            ::Blox::Connect::GlobalPredicateName.new(:qualified_name => name)))
                newtransaction = transaction(workspace, 
                                             true,
                                             [::Blox::Connect::Command.new(:pred_info => querypredicate)])

                message = ::Blox::Connect::Request.new(:transaction => newtransaction)
                conn.send_request(0,message.to_s)
                rawResponse = conn.get_response
                response = ::Blox::Connect::Response.new.parse_from_string(rawResponse)
                result = response.transaction.command[0].pred_info.info
            end
            result
        end

        def createWorkspace(workspace=nil)
            if !@commandpool
                @commandpool = ConnectionPool.new { Connection.open(@config.commandhost, @config.commandport) }
            end
            # This block should return the array as its result. Since its the last thing in this function then this function should also return the array
            # Since the connection is inside the do block the connection will be checked out and back in.
            @commandpool.with do |conn|  
                createworkspace = ::Blox::Connect::CreateWorkSpace.new( :name => workspace, 
                                                                        :measure_engine => false,
                                                                        :snapshot_isolation => false,
                                                                        :overwrite => false)

                message = ::Blox::Connect::Request.new(:create => createworkspace)
                conn.send_request(0,message.to_s)
                rawResponse = conn.get_response
                response = ::Blox::Connect::Response.new.parse_from_string(rawResponse)
                response.create
            end
        end
            
        def resetWorkspace(workspace)
            if !@commandpool
                @commandpool = ConnectionPool.new { Connection.open(@config.commandhost, @config.commandport) }
            end
            # This block should return the array as its result. Since its the last thing in this function then this function should also return the array
            # Since the connection is inside the do block the connection will be checked out and back in.
            @commandpool.with do |conn|  
                createworkspace = ::Blox::Connect::CreateWorkSpace.new( :name => workspace, 
                                                                        :measure_engine => false,
                                                                        :snapshot_isolation => false,
                                                                        :overwrite => true)

                message = ::Blox::Connect::Request.new(:create => createworkspace)
                conn.send_request(0,message.to_s)
                rawResponse = conn.get_response
                response = ::Blox::Connect::Response.new.parse_from_string(rawResponse)
                response.create.name
            end
        end

        def removeWorkspace(workspace)
            if !@commandpool
                @commandpool = ConnectionPool.new { Connection.open(@config.commandhost, @config.commandport) }
            end
            # This block should return the array as its result. Since its the last thing in this function then this function should also return the array
            # Since the connection is inside the do block the connection will be checked out and back in.
            @commandpool.with do |conn|  
                deleteworkspace = ::Blox::Connect::DeleteWorkSpace.new( :name => workspace )

                message = ::Blox::Connect::Request.new(:delete => deleteworkspace)
                conn.send_request(0,message.to_s)
                rawResponse = conn.get_response
                response = ::Blox::Connect::Response.new.parse_from_string(rawResponse)
                response.delete == nil ? 1 : 0
            end
        end

        def exportWorkspace(workspace, dir) 
            if !@commandpool
                @commandpool = ConnectionPool.new { Connection.open(@config.commandhost, @config.commandport) }
            end
            # This block should return the array as its result. Since its the last thing in this function then this function should also return the array
            # Since the connection is inside the do block the connection will be checked out and back in.
            @commandpool.with do |conn|  
                exportworkspace = ::Blox::Connect::ExportWorkSpace.new( :name => workspace, :dest_filepath => dir )

                message = ::Blox::Connect::Request.new(:exportws => exportworkspace)
                conn.send_request(0,message.to_s)
                rawResponse = conn.get_response
                response = ::Blox::Connect::Response.new.parse_from_string(rawResponse)
                response.exportws == nil ? 1 : 0
            end
        end

        def importWorkspace(workspace, dir) 
            if !@commandpool
                @commandpool = ConnectionPool.new { Connection.open(@config.commandhost, @config.commandport) }
            end
            # This block should return the array as its result. Since its the last thing in this function then this function should also return the array
            # Since the connection is inside the do block the connection will be checked out and back in.
            @commandpool.with do |conn|  
                importworkspace = ::Blox::Connect::ImportWorkSpace.new( :name => workspace, :src_filepath => dir )

                message = ::Blox::Connect::Request.new(:importws => importworkspace)
                conn.send_request(0,message.to_s)
                rawResponse = conn.get_response
                response = ::Blox::Connect::Response.new.parse_from_string(rawResponse)
                response.importws == nil ? 1 : 0
            end
        end
    end 
end
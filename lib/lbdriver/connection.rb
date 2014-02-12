require 'protobuf/message'
require 'bindata'

# We are relying on the fact that TCPSocket, being a subclass of IO, will be closed when it is Garbage Collected

module LBDriver
  class Connection
      include Celluloid::IO


      class WireMessage < ::BinData::Record
      	endian :big

      	uint32 :msgReqId
      	uint32 :msgLen
      	string :message, :read_length => lambda { msgLen < 4089 ? msgLen : 4088 }
      end
      
      attr_reader :socket

      def open(host, port = 80)
        @socket = TCPSocket.new(host, port)
      end

      def close
        socket.close
      end

      def send_request(reqId,request)
      	message = WireMessage.new(:msgReqId => reqId, :msgLen => request.length, :message => request) 
        # puts "In Connection#send_request with request as " + message.inspect + "\n"
      	# socket.write(message.to_binary_s)
        message.write(socket)
      end

      def get_response
        firstBuffer = @socket.readpartial(4096)
        
        firstChunk = WireMessage.read(firstBuffer)
        message = firstChunk.message
        reqId = firstChunk.msgReqId
        msglen = firstChunk.msgLen

        until (message.size == msglen)
          message << @socket.readpartial(4096)
        end
        #puts "In Connection#get_response with the response as " + message.bytes.to_a.join("-") + "\n"
        message
      end

      def self.open(host, port = 80)
        connection = self.new
        connection.open(host, port)
        connection
      end
  end
end

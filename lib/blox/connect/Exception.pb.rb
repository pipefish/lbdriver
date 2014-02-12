##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf/message'

module Blox
  module Connect

    ##
    # Message Classes
    #
    class ExceptionContainer < ::Protobuf::Message; end
    class WorkspaceException < ::Protobuf::Message
      class Code < ::Protobuf::Enum
        define :DOES_NOT_EXIST, 1
        define :ALREADY_EXISTS, 2
      end

    end



    ##
    # Message Fields
    #
    class ExceptionContainer
      required ::Protobuf::Field::StringField, :message, 1
      optional ::Blox::Connect::WorkspaceException, :workspace, 2
    end

    class WorkspaceException
      required ::Protobuf::Field::StringField, :name, 1
      required ::Blox::Connect::WorkspaceException::Code, :code, 2
    end

  end

end


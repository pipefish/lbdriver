##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf/message'


##
# Imports
#
require 'blox/connect/BloxCommand.pb'
require 'blox/connect/Exception.pb'

module Blox
  module Connect

    ##
    # Enum Classes
    #
    class Priority < ::Protobuf::Enum
      define :NORMAL, 1
      define :LOW, 2
    end

    class RequestStatusEnum < ::Protobuf::Enum
      define :QUEUED, 1
      define :ACTIVE, 2
    end


    ##
    # Message Classes
    #
    class Request < ::Protobuf::Message; end
    class Response < ::Protobuf::Message; end
    class Transaction < ::Protobuf::Message; end
    class TransactionResponse < ::Protobuf::Message; end
    class CreateWorkSpace < ::Protobuf::Message; end
    class CreateWorkSpaceResponse < ::Protobuf::Message; end
    class CopyWorkSpace < ::Protobuf::Message; end
    class CopyWorkSpaceResponse < ::Protobuf::Message; end
    class DeleteWorkSpace < ::Protobuf::Message; end
    class DeleteWorkSpaceResponse < ::Protobuf::Message; end
    class ImportWorkSpace < ::Protobuf::Message; end
    class ImportWorkSpaceResponse < ::Protobuf::Message; end
    class ExportWorkSpace < ::Protobuf::Message; end
    class ExportWorkSpaceResponse < ::Protobuf::Message; end
    class GetWorkSpacePath < ::Protobuf::Message; end
    class GetWorkSpacePathResponse < ::Protobuf::Message; end
    class GetWorkSpaceVersion < ::Protobuf::Message; end
    class GetWorkSpaceVersionResponse < ::Protobuf::Message; end
    class CancelRequests < ::Protobuf::Message; end
    class CancelRequestsResponse < ::Protobuf::Message; end
    class AdminRequest < ::Protobuf::Message; end
    class AdminResponse < ::Protobuf::Message; end
    class ShutdownServer < ::Protobuf::Message; end
    class ShutdownServerResponse < ::Protobuf::Message; end
    class ProcessPoolStatus < ::Protobuf::Message; end
    class ProcessPoolStatusResponse < ::Protobuf::Message; end
    class ProcessStatus < ::Protobuf::Message; end
    class AbortTransaction < ::Protobuf::Message; end
    class AbortTransactionResponse < ::Protobuf::Message; end
    class KillProcess < ::Protobuf::Message; end
    class KillProcessResponse < ::Protobuf::Message; end
    class ListWorkSpaces < ::Protobuf::Message; end
    class ListWorkSpacesResponse < ::Protobuf::Message; end
    class StatusRequest < ::Protobuf::Message; end
    class StatusResponse < ::Protobuf::Message; end
    class WorkspaceStatus < ::Protobuf::Message; end
    class RequestStatus < ::Protobuf::Message; end
    class ReplicationRequest < ::Protobuf::Message; end
    class ReplicationResponse < ::Protobuf::Message; end
    class AddReplicator < ::Protobuf::Message; end


    ##
    # Message Fields
    #
    class Request
      optional ::Protobuf::Field::StringField, :client_id, 1
      optional ::Protobuf::Field::StringField, :guid, 14
      optional ::Protobuf::Field::StringField, :log_level, 2
      optional ::Protobuf::Field::BoolField, :return_log, 3, :default => false
      optional ::Blox::Connect::Priority, :priority, 4
      optional ::Blox::Connect::Transaction, :transaction, 5
      optional ::Blox::Connect::CreateWorkSpace, :create, 6
      optional ::Blox::Connect::CopyWorkSpace, :copy, 7
      optional ::Blox::Connect::DeleteWorkSpace, :delete, 8
      optional ::Blox::Connect::ImportWorkSpace, :importws, 9
      optional ::Blox::Connect::ExportWorkSpace, :exportws, 10
      optional ::Blox::Connect::GetWorkSpacePath, :get_ws_path, 11
      optional ::Protobuf::Field::StringField, :current_working_directory, 12
      optional ::Blox::Connect::GetWorkSpaceVersion, :get_ws_version, 13
      optional ::Blox::Connect::ReplicationRequest, :replicate, 16
      optional ::Blox::Connect::CancelRequests, :cancel_requests, 15
      optional ::Protobuf::Field::StringField, :authenticator, 17
    end

    class Response
      optional ::Protobuf::Field::StringField, :client_id, 1
      optional ::Blox::Connect::ExceptionContainer, :exception, 2
      optional ::Blox::Connect::TransactionResponse, :transaction, 3
      optional ::Blox::Connect::CreateWorkSpaceResponse, :create, 4
      optional ::Blox::Connect::CopyWorkSpaceResponse, :copy, 5
      optional ::Blox::Connect::DeleteWorkSpaceResponse, :delete, 6
      optional ::Blox::Connect::ImportWorkSpaceResponse, :importws, 7
      optional ::Blox::Connect::ExportWorkSpaceResponse, :exportws, 8
      optional ::Blox::Connect::GetWorkSpacePathResponse, :get_ws_path, 9
      optional ::Blox::Connect::GetWorkSpaceVersionResponse, :get_ws_version, 11
      optional ::Blox::Connect::CancelRequestsResponse, :cancel_requests, 12
      optional ::Blox::Connect::ReplicationResponse, :replicate, 13
      optional ::Protobuf::Field::BytesField, :compressed_log, 10
    end

    class Transaction
      required ::Protobuf::Field::StringField, :workspace, 1
      repeated ::Blox::Connect::Command, :command, 2
      repeated ::Blox::Connect::Command, :command_after_fixpoint, 3
      optional ::Protobuf::Field::Int32Field, :timeout, 4, :default => -1
      optional ::Protobuf::Field::BoolField, :exclusive, 5, :default => false
      optional ::Protobuf::Field::BoolField, :readonly, 6, :default => false
      optional ::Protobuf::Field::StringField, :commit_mode, 7, :default => "softcommit"
    end

    class TransactionResponse
      repeated ::Blox::Connect::CommandResponse, :command, 1
      repeated ::Blox::Connect::CommandResponse, :command_after_fixpoint, 2
    end

    class CreateWorkSpace
      optional ::Protobuf::Field::StringField, :name, 1
      repeated ::Blox::Connect::Command, :command, 2
      repeated ::Blox::Connect::Command, :command_after_fixpoint, 3
      optional ::Protobuf::Field::BoolField, :measure_engine, 4, :default => false
      optional ::Protobuf::Field::BoolField, :snapshot_isolation, 5, :default => false
      optional ::Protobuf::Field::StringField, :libraries, 6
      optional ::Protobuf::Field::BoolField, :overwrite, 7
      optional ::Protobuf::Field::BoolField, :unique, 8
    end

    class CreateWorkSpaceResponse
      required ::Protobuf::Field::StringField, :name, 1
      repeated ::Blox::Connect::CommandResponse, :command, 2
      repeated ::Blox::Connect::CommandResponse, :command_after_fixpoint, 3
    end

    class CopyWorkSpace
      required ::Protobuf::Field::StringField, :path, 1
      optional ::Protobuf::Field::StringField, :new_path, 2
    end

    class CopyWorkSpaceResponse
      optional ::Protobuf::Field::StringField, :path, 1
    end

    class DeleteWorkSpace
      required ::Protobuf::Field::StringField, :name, 1
    end

    class ImportWorkSpace
      required ::Protobuf::Field::StringField, :src_filepath, 1
      optional ::Protobuf::Field::StringField, :name, 2
      optional ::Protobuf::Field::BoolField, :overwrite, 3
      optional ::Protobuf::Field::BoolField, :unique, 4
      optional ::Protobuf::Field::BoolField, :link, 7
      optional ::Protobuf::Field::BoolField, :move, 8
      repeated ::Blox::Connect::Command, :command, 5
      repeated ::Blox::Connect::Command, :command_after_fixpoint, 6
    end

    class ImportWorkSpaceResponse
      required ::Protobuf::Field::StringField, :name, 1
      required ::Protobuf::Field::StringField, :filepath, 2
      repeated ::Blox::Connect::CommandResponse, :command, 3
      repeated ::Blox::Connect::CommandResponse, :command_after_fixpoint, 4
    end

    class ExportWorkSpace
      required ::Protobuf::Field::StringField, :name, 1
      required ::Protobuf::Field::StringField, :dest_filepath, 2
      optional ::Protobuf::Field::BoolField, :link, 3
      optional ::Protobuf::Field::BoolField, :move, 4
      optional ::Protobuf::Field::BoolField, :overwrite, 5
    end

    class GetWorkSpacePath
      required ::Protobuf::Field::StringField, :name, 1
      optional ::Protobuf::Field::BoolField, :inverse, 2, :default => false
    end

    class GetWorkSpacePathResponse
      required ::Protobuf::Field::StringField, :filepath, 1
    end

    class GetWorkSpaceVersion
      required ::Protobuf::Field::StringField, :name, 1
    end

    class GetWorkSpaceVersionResponse
      required ::Protobuf::Field::StringField, :version, 2
      optional ::Protobuf::Field::StringField, :minor_version, 3
      required ::Protobuf::Field::StringField, :build_number, 1
    end

    class CancelRequests
      repeated ::Protobuf::Field::StringField, :req_guid, 1
    end

    class CancelRequestsResponse
      repeated ::Protobuf::Field::StringField, :cancelled_guids, 1
      repeated ::Protobuf::Field::StringField, :aborted_guids, 2
      repeated ::Protobuf::Field::StringField, :completed_guids, 3
      repeated ::Protobuf::Field::StringField, :unknown_guids, 4
    end

    class AdminRequest
      optional ::Protobuf::Field::StringField, :client_id, 1
      optional ::Blox::Connect::ShutdownServer, :shutdown_server, 2
      optional ::Blox::Connect::ProcessPoolStatus, :process_pool_status, 3
      optional ::Blox::Connect::AbortTransaction, :abort_transaction, 4
      optional ::Blox::Connect::KillProcess, :kill_process, 5
      optional ::Protobuf::Field::BoolField, :list_workspaces, 6
      optional ::Blox::Connect::StatusRequest, :status, 7
      optional ::Protobuf::Field::StringField, :command, 8
    end

    class AdminResponse
      optional ::Protobuf::Field::StringField, :client_id, 1
      optional ::Blox::Connect::ExceptionContainer, :exception, 2
      optional ::Blox::Connect::ShutdownServerResponse, :shutdown_server, 3
      optional ::Blox::Connect::ProcessPoolStatusResponse, :process_pool_status, 4
      optional ::Blox::Connect::AbortTransactionResponse, :abort_transaction, 5
      optional ::Blox::Connect::KillProcessResponse, :kill_process, 6
      optional ::Blox::Connect::ListWorkSpacesResponse, :list_workspaces, 7
      optional ::Blox::Connect::StatusResponse, :status, 8
      optional ::Protobuf::Field::StringField, :message, 9
    end

    class ShutdownServer
      optional ::Protobuf::Field::BoolField, :waitForProcesses, 1
    end

    class ShutdownServerResponse
      optional ::Protobuf::Field::StringField, :message, 1
    end

    class ProcessPoolStatus
      optional ::Protobuf::Field::BoolField, :show_available_processes, 1, :default => false
    end

    class ProcessPoolStatusResponse
      required ::Protobuf::Field::Uint32Field, :max_number_process_in_server, 1
      repeated ::Blox::Connect::ProcessStatus, :process_status, 2
    end

    class ProcessStatus
      required ::Protobuf::Field::Uint32Field, :pid, 1
      required ::Protobuf::Field::BoolField, :is_active, 2
      required ::Protobuf::Field::StringField, :ws_path, 3
      required ::Blox::Connect::Request, :request, 4
    end

    class AbortTransaction
      required ::Protobuf::Field::Uint32Field, :pid, 1
    end

    class AbortTransactionResponse
      optional ::Protobuf::Field::StringField, :message, 1
    end

    class KillProcess
      required ::Protobuf::Field::Int32Field, :pid, 1
      optional ::Protobuf::Field::Uint32Field, :signal, 2, :default => 15
    end

    class KillProcessResponse
      required ::Protobuf::Field::StringField, :message, 1
    end

    class ListWorkSpacesResponse
      repeated ::Protobuf::Field::StringField, :name, 1
    end

    class StatusRequest
      repeated ::Protobuf::Field::StringField, :workspaces, 1
      optional ::Protobuf::Field::BoolField, :show_active_requests, 2, :default => false
      optional ::Protobuf::Field::BoolField, :show_queued_requests, 3, :default => false
      optional ::Protobuf::Field::BoolField, :add_debug_info, 99, :default => false
    end

    class StatusResponse
      repeated ::Blox::Connect::WorkspaceStatus, :workspaces, 1
      repeated ::Protobuf::Field::StringField, :debug_info, 99
    end

    class WorkspaceStatus
      required ::Protobuf::Field::StringField, :name, 1
      optional ::Protobuf::Field::Int32Field, :num_requests, 2
      repeated ::Blox::Connect::RequestStatus, :requests, 3
      repeated ::Protobuf::Field::StringField, :debug_info, 99
    end

    class RequestStatus
      optional ::Blox::Connect::Request, :request, 1
      optional ::Blox::Connect::RequestStatusEnum, :state, 2
      repeated ::Protobuf::Field::StringField, :debug_info, 99
    end

    class ReplicationRequest
      optional ::Blox::Connect::AddReplicator, :add_replicator, 1
    end

    class AddReplicator
      required ::Protobuf::Field::StringField, :workspace_name, 1
    end

  end

end


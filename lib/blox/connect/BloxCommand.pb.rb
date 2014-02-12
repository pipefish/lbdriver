##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf/message'


##
# Imports
#
require 'blox/common/Common.pb'
require 'blox/connect/Exception.pb'

module Blox
  module Connect

    ##
    # Enum Classes
    #
    class FaultKind < ::Protobuf::Enum
      define :ABNORMAL_PROGRAM_TERMINATION, 1
      define :SLEEP, 2
      define :HANG, 3
    end

    class Language < ::Protobuf::Enum
      define :LB, 1
      define :LB0, 2
      define :MEASURE, 3
    end

    class DeltaModifier < ::Protobuf::Enum
      define :ASSERTIONS, 1
      define :RETRACTIONS, 2
      define :UPSERT, 3
      define :FULL, 4
    end

    class EntityMode < ::Protobuf::Enum
      define :MISSING_SKIP, 1
      define :MISSING_CREATE, 2
      define :MISSING_ERROR, 3
    end


    ##
    # Message Classes
    #
    class Command < ::Protobuf::Message; end
    class CommandResponse < ::Protobuf::Message; end
    class AddBlock < ::Protobuf::Message; end
    class AddBlockResponse < ::Protobuf::Message; end
    class RemoveBlock < ::Protobuf::Message; end
    class RemoveBlockResponse < ::Protobuf::Message; end
    class CompileBlock < ::Protobuf::Message; end
    class CompileBlockResponse < ::Protobuf::Message; end
    class InstallLibrary < ::Protobuf::Message; end
    class InstallLibraryResponse < ::Protobuf::Message; end
    class InstallProject < ::Protobuf::Message; end
    class InstallProjectResponse < ::Protobuf::Message; end
    class ExecInactiveBlock < ::Protobuf::Message; end
    class ExecInactiveBlockResponse < ::Protobuf::Message; end
    class ReturnLocalProtoBuf < ::Protobuf::Message; end
    class ReturnLocalProtoBufResponse < ::Protobuf::Message; end
    class ExecBlock < ::Protobuf::Message; end
    class ExecBlockResponse < ::Protobuf::Message; end
    class QueryPredicate < ::Protobuf::Message; end
    class QueryPredicateResponse < ::Protobuf::Message; end
    class UpdatePredicate < ::Protobuf::Message; end
    class UpdatePredicateResponse < ::Protobuf::Message; end
    class GetPredicateInfo < ::Protobuf::Message; end
    class GetPredicateInfoResponse < ::Protobuf::Message; end
    class GetPredicateInfoBulk < ::Protobuf::Message; end
    class GetPredicateInfoBulkResponse < ::Protobuf::Message; end
    class GetPredicatePopcount < ::Protobuf::Message; end
    class GetPredicatePopcountResponse < ::Protobuf::Message; end
    class GetProtocolDescriptors < ::Protobuf::Message; end
    class GetProtocolDescriptorsResponse < ::Protobuf::Message; end
    class ProtocolDescriptor < ::Protobuf::Message; end
    class ImportProtoBuf < ::Protobuf::Message; end
    class ImportProtoBufResponse < ::Protobuf::Message; end
    class ExportProtoBuf < ::Protobuf::Message; end
    class ExportProtoBufResponse < ::Protobuf::Message; end
    class LogMessage < ::Protobuf::Message; end
    class LogMessageResponse < ::Protobuf::Message; end
    class ReplaceBlock < ::Protobuf::Message; end
    class ReplaceBlockResponse < ::Protobuf::Message; end
    class ProtoAddSpec < ::Protobuf::Message; end
    class ProtoAddSpecResponse < ::Protobuf::Message; end
    class XMLAddSpec < ::Protobuf::Message; end
    class XMLAddSpecResponse < ::Protobuf::Message; end
    class ImportXMLDoc < ::Protobuf::Message; end
    class ImportXMLDocResponse < ::Protobuf::Message; end
    class GenerateFullUpdateDeltas < ::Protobuf::Message; end
    class GenerateFullUpdateDeltasResponse < ::Protobuf::Message; end
    class ExecuteImportScript < ::Protobuf::Message; end
    class ExecuteImportScriptResponse < ::Protobuf::Message; end
    class FaultInjection < ::Protobuf::Message; end
    class InputBinding < ::Protobuf::Message; end
    class Relation < ::Protobuf::Message; end
    class Column < ::Protobuf::Message; end
    class BoolColumn < ::Protobuf::Message; end
    class Int32Column < ::Protobuf::Message; end
    class Int64Column < ::Protobuf::Message; end
    class UInt32Column < ::Protobuf::Message; end
    class UInt64Column < ::Protobuf::Message; end
    class Float32Column < ::Protobuf::Message; end
    class Float64Column < ::Protobuf::Message; end
    class DateTimeColumn < ::Protobuf::Message; end
    class StringColumn < ::Protobuf::Message; end
    class Decimal64Column < ::Protobuf::Message; end
    class Decimal128Column < ::Protobuf::Message; end
    class DecimalColumn < ::Protobuf::Message; end
    class EntityColumn < ::Protobuf::Message; end
    class PredicateName < ::Protobuf::Message; end
    class LocalPredicateName < ::Protobuf::Message; end
    class GlobalPredicateName < ::Protobuf::Message; end


    ##
    # Message Fields
    #
    class Command
      optional ::Blox::Connect::AddBlock, :add_block, 1
      optional ::Blox::Connect::InstallLibrary, :install_library, 2
      optional ::Blox::Connect::ExecInactiveBlock, :exec_inactive, 3
      optional ::Blox::Connect::ExecBlock, :exec, 4
      optional ::Blox::Connect::QueryPredicate, :query_predicate, 5
      optional ::Blox::Connect::UpdatePredicate, :update_predicate, 6
      optional ::Blox::Connect::GetPredicateInfo, :pred_info, 7
      optional ::Blox::Connect::GetPredicateInfoBulk, :pred_info_bulk, 17
      optional ::Blox::Connect::ImportProtoBuf, :import_protobuf, 8
      optional ::Blox::Connect::CompileBlock, :compile_block, 9
      optional ::Blox::Connect::InstallProject, :install_project, 10
      optional ::Blox::Connect::RemoveBlock, :remove_block, 11
      optional ::Blox::Connect::LogMessage, :log_message, 12
      optional ::Blox::Connect::ReplaceBlock, :replace_block, 13
      optional ::Blox::Connect::ExportProtoBuf, :export_protobuf, 14
      optional ::Blox::Connect::ProtoAddSpec, :proto_add_spec, 15
      optional ::Blox::Connect::FaultInjection, :fault, 16
      optional ::Blox::Connect::XMLAddSpec, :xml_add_spec, 18
      optional ::Blox::Connect::ImportXMLDoc, :import_xml_doc, 19
      optional ::Blox::Connect::GetPredicatePopcount, :pred_popcount, 20
      optional ::Blox::Connect::GenerateFullUpdateDeltas, :pred_full_update_deltas, 21
      optional ::Blox::Connect::ExecuteImportScript, :exec_import_script, 22
      optional ::Blox::Connect::GetProtocolDescriptors, :proto_get_descriptors, 23
    end

    class CommandResponse
      optional ::Blox::Connect::ExceptionContainer, :exception, 1
      optional ::Blox::Connect::AddBlockResponse, :add_block, 2
      optional ::Blox::Connect::InstallLibraryResponse, :install_library, 3
      optional ::Blox::Connect::ExecInactiveBlockResponse, :exec_inactive, 4
      optional ::Blox::Connect::ExecBlockResponse, :exec, 5
      optional ::Blox::Connect::QueryPredicateResponse, :query_predicate, 6
      optional ::Blox::Connect::UpdatePredicateResponse, :update_predicate, 7
      optional ::Blox::Connect::GetPredicateInfoResponse, :pred_info, 8
      optional ::Blox::Connect::GetPredicateInfoBulkResponse, :pred_info_bulk, 18
      optional ::Blox::Connect::ImportProtoBufResponse, :import_protobuf, 9
      optional ::Blox::Connect::CompileBlockResponse, :compile_block, 10
      optional ::Blox::Connect::InstallProjectResponse, :install_project, 11
      optional ::Blox::Connect::RemoveBlockResponse, :remove_block, 12
      optional ::Blox::Connect::LogMessageResponse, :log_message, 13
      optional ::Blox::Connect::ReplaceBlockResponse, :replace_block, 14
      optional ::Blox::Connect::ExportProtoBufResponse, :export_protobuf, 15
      optional ::Blox::Connect::ProtoAddSpecResponse, :proto_add_spec, 16
      optional ::Blox::Connect::FaultInjection, :fault, 17
      optional ::Blox::Connect::XMLAddSpecResponse, :xml_add_spec, 19
      optional ::Blox::Connect::ImportXMLDocResponse, :import_xml_doc, 20
      optional ::Blox::Connect::GetPredicatePopcountResponse, :pred_popcount, 21
      optional ::Blox::Connect::GenerateFullUpdateDeltasResponse, :pred_full_update_deltas, 22
      optional ::Blox::Connect::ExecuteImportScriptResponse, :exec_import_script, 23
      optional ::Blox::Connect::GetProtocolDescriptorsResponse, :proto_get_descriptors, 24
    end

    class AddBlock
      optional ::Protobuf::Field::StringField, :block_name, 1
      optional ::Protobuf::Field::BoolField, :active, 2
      required ::Protobuf::Field::BytesField, :logic, 3
      optional ::Blox::Connect::Language, :language, 4
      optional ::Protobuf::Field::BoolField, :after_fixpoint, 5
    end

    class AddBlockResponse
      optional ::Protobuf::Field::StringField, :block_name, 1
      optional ::Blox::Common::Protocol::CompilationProblems, :problems, 2
    end

    class RemoveBlock
      required ::Protobuf::Field::StringField, :block_name, 1
    end

    class RemoveBlockResponse
      optional ::Protobuf::Field::StringField, :block_name, 1
      optional ::Blox::Common::Protocol::CompilationProblems, :problems, 2
    end

    class CompileBlock
      optional ::Protobuf::Field::StringField, :block_name, 1
      required ::Blox::Common::Protocol::LogicSort, :sort, 2
      required ::Protobuf::Field::StringField, :logic, 3
    end

    class CompileBlockResponse
      optional ::Blox::Common::Protocol::CompilationProblems, :problems, 1
      optional ::Protobuf::Field::BytesField, :result, 2
    end

    class InstallLibrary
      required ::Protobuf::Field::StringField, :name, 1
    end

    class InstallProject
      required ::Protobuf::Field::StringField, :projDir, 1
      optional ::Protobuf::Field::BoolField, :recurse, 2, :default => true
      optional ::Protobuf::Field::BoolField, :copy, 3, :default => true
      optional ::Protobuf::Field::StringField, :lib_path, 4
    end

    class ExecInactiveBlock
      required ::Protobuf::Field::StringField, :block_name, 1
      repeated ::Blox::Connect::InputBinding, :input, 2
      repeated ::Protobuf::Field::StringField, :return_local, 3
      repeated ::Blox::Connect::ReturnLocalProtoBuf, :return_protobuf, 4
    end

    class ExecInactiveBlockResponse
      repeated ::Blox::Connect::Relation, :return_local, 1
      repeated ::Blox::Connect::ReturnLocalProtoBufResponse, :return_protobuf, 2
    end

    class ReturnLocalProtoBuf
      required ::Protobuf::Field::StringField, :predicate, 1
      required ::Protobuf::Field::StringField, :protocol, 2
    end

    class ReturnLocalProtoBufResponse
      optional ::Protobuf::Field::StringField, :predicate, 1
      repeated ::Protobuf::Field::BytesField, :message, 2
    end

    class ExecBlock
      optional ::Protobuf::Field::StringField, :block_name, 1
      required ::Protobuf::Field::BytesField, :logic, 2
      optional ::Blox::Connect::Language, :language, 3
      repeated ::Blox::Connect::InputBinding, :input, 4
      repeated ::Protobuf::Field::StringField, :return_local, 5
      repeated ::Blox::Connect::ReturnLocalProtoBuf, :return_protobuf, 6
    end

    class ExecBlockResponse
      optional ::Blox::Common::Protocol::CompilationProblems, :problems, 1
      repeated ::Blox::Connect::Relation, :return_local, 2
      repeated ::Blox::Connect::ReturnLocalProtoBufResponse, :return_protobuf, 3
    end

    class QueryPredicate
      required ::Blox::Connect::PredicateName, :predicate, 1
      optional ::Blox::Connect::DeltaModifier, :delta, 2
    end

    class QueryPredicateResponse
      required ::Blox::Connect::Relation, :relation, 1
    end

    class UpdatePredicate
      required ::Blox::Connect::PredicateName, :predicate, 1
      required ::Blox::Connect::Relation, :relation, 2
      required ::Blox::Connect::DeltaModifier, :delta, 3
      optional ::Blox::Connect::EntityMode, :entity_mode, 4
    end

    class GetPredicateInfo
      required ::Blox::Connect::PredicateName, :predicate, 1
    end

    class GetPredicateInfoResponse
      required ::Blox::Common::Protocol::PredicateInfo, :info, 1
    end

    class GetPredicateInfoBulk
      repeated ::Blox::Connect::PredicateName, :predicate, 1
      repeated ::Blox::Connect::PredicateName, :omit, 2
    end

    class GetPredicateInfoBulkResponse
      repeated ::Blox::Common::Protocol::PredicateInfo, :info, 1
    end

    class GetPredicatePopcount
      required ::Protobuf::Field::BoolField, :all, 1, :default => true
      repeated ::Blox::Connect::PredicateName, :predicate, 2
      optional ::Protobuf::Field::StringField, :include_regexp, 3
      optional ::Protobuf::Field::StringField, :exclude_regexp, 4
      optional ::Protobuf::Field::BoolField, :only_predicate_names, 5, :default => false
    end

    class GetPredicatePopcountResponse
      repeated ::Blox::Common::Protocol::PredicatePopcount, :popcount, 1
    end

    class GetProtocolDescriptors
      required ::Protobuf::Field::BoolField, :all, 1
      repeated ::Protobuf::Field::StringField, :protocol_name, 2
      optional ::Protobuf::Field::StringField, :include_regexp, 3
      optional ::Protobuf::Field::StringField, :exclude_regexp, 4
    end

    class GetProtocolDescriptorsResponse
      repeated ::Blox::Connect::ProtocolDescriptor, :protocols, 1
    end

    class ProtocolDescriptor
      required ::Protobuf::Field::StringField, :name, 1
      required ::Protobuf::Field::BytesField, :descriptor_data, 2
    end

    class ImportProtoBuf
      required ::Protobuf::Field::StringField, :protocol, 1
      required ::Protobuf::Field::StringField, :type_name, 2
      required ::Protobuf::Field::BytesField, :message, 3
    end

    class ExportProtoBuf
      required ::Protobuf::Field::StringField, :protocol, 1
      required ::Protobuf::Field::StringField, :type_name, 2
    end

    class ExportProtoBufResponse
      required ::Protobuf::Field::BytesField, :message, 1
    end

    class LogMessage
      required ::Protobuf::Field::StringField, :message, 1
    end

    class LogMessageResponse
      required ::Protobuf::Field::StringField, :log_file_path, 1
    end

    class ReplaceBlock
      required ::Protobuf::Field::StringField, :block_name, 1
      required ::Protobuf::Field::BytesField, :logic, 2
      optional ::Blox::Connect::Language, :language, 3
    end

    class ReplaceBlockResponse
      required ::Protobuf::Field::StringField, :block_name, 1
    end

    class ProtoAddSpec
      required ::Protobuf::Field::StringField, :name, 1
      required ::Protobuf::Field::BytesField, :descriptor_msg, 2
    end

    class XMLAddSpec
      required ::Protobuf::Field::StringField, :name, 1
      required ::Protobuf::Field::BytesField, :descriptor_msg, 2
    end

    class ImportXMLDoc
      optional ::Protobuf::Field::StringField, :schema, 1
      required ::Protobuf::Field::BytesField, :document, 2
    end

    class GenerateFullUpdateDeltas
      required ::Blox::Connect::PredicateName, :predicate, 1
    end

    class ExecuteImportScript
      required ::Protobuf::Field::StringField, :script_path, 1
      optional ::Protobuf::Field::BoolField, :incremental, 2
    end

    class ExecuteImportScriptResponse
      required ::Protobuf::Field::BoolField, :success, 1
    end

    class FaultInjection
      required ::Blox::Connect::FaultKind, :kind, 1
      optional ::Protobuf::Field::Uint32Field, :seconds, 2
    end

    class InputBinding
      required ::Protobuf::Field::StringField, :name, 1
      required ::Blox::Connect::Relation, :relation, 2
    end

    class Relation
      optional ::Protobuf::Field::StringField, :name, 1
      repeated ::Blox::Connect::Column, :column, 2
    end

    class Column
      optional ::Blox::Connect::EntityColumn, :entity_column, 1
      optional ::Blox::Connect::BoolColumn, :bool_column, 2
      optional ::Blox::Connect::Int32Column, :int32_column, 3
      optional ::Blox::Connect::Int64Column, :int64_column, 4
      optional ::Blox::Connect::UInt32Column, :uint32_column, 5
      optional ::Blox::Connect::UInt64Column, :uint64_column, 6
      optional ::Blox::Connect::Float32Column, :float32_column, 7
      optional ::Blox::Connect::Float64Column, :float64_column, 8
      optional ::Blox::Connect::StringColumn, :string_column, 9
      optional ::Blox::Connect::DateTimeColumn, :datetime_column, 10
      optional ::Blox::Connect::Decimal64Column, :decimal64_column, 11
      optional ::Blox::Connect::Decimal128Column, :decimal128_column, 12
      optional ::Blox::Connect::DecimalColumn, :decimal_column, 13
    end

    class BoolColumn
      repeated ::Protobuf::Field::BoolField, :values, 1, :packed => true
    end

    class Int32Column
      repeated ::Protobuf::Field::Int32Field, :values, 1, :packed => true
    end

    class Int64Column
      repeated ::Protobuf::Field::Int64Field, :values, 1, :packed => true
    end

    class UInt32Column
      repeated ::Protobuf::Field::Uint32Field, :values, 1, :packed => true
    end

    class UInt64Column
      repeated ::Protobuf::Field::Uint64Field, :values, 1, :packed => true
    end

    class Float32Column
      repeated ::Protobuf::Field::FloatField, :values, 1, :packed => true
    end

    class Float64Column
      repeated ::Protobuf::Field::DoubleField, :values, 1, :packed => true
    end

    class DateTimeColumn
      repeated ::Protobuf::Field::Int64Field, :values, 1, :packed => true
    end

    class StringColumn
      repeated ::Protobuf::Field::StringField, :values, 1
    end

    class Decimal64Column
      repeated ::Protobuf::Field::StringField, :values, 1
    end

    class Decimal128Column
      repeated ::Protobuf::Field::StringField, :values, 1
    end

    class DecimalColumn
      repeated ::Protobuf::Field::Int64Field, :values, 1, :packed => true
    end

    class EntityColumn
      optional ::Protobuf::Field::StringField, :name, 1
      optional ::Blox::Connect::Column, :index_values, 2
      optional ::Blox::Connect::Column, :refmode_values, 3
    end

    class PredicateName
      optional ::Blox::Connect::LocalPredicateName, :local_name, 1
      optional ::Blox::Connect::GlobalPredicateName, :global_name, 2
    end

    class LocalPredicateName
      required ::Protobuf::Field::StringField, :local_name, 1
      required ::Protobuf::Field::StringField, :block_name, 2
    end

    class GlobalPredicateName
      required ::Protobuf::Field::StringField, :qualified_name, 1
    end

  end

end


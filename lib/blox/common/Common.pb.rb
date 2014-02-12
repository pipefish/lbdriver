##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf/message'

module Blox
  module Common
    module Protocol

      ##
      # Enum Classes
      #
      class Severity < ::Protobuf::Enum
        define :SEV_ERROR, 0
        define :SEV_WARNING, 1
        define :SEV_NONE, 2
      end

      class Lifetime < ::Protobuf::Enum
        define :TRANSACTION, 1
        define :DATABASE, 2
        define :SESSION, 3
      end

      class DerivationType < ::Protobuf::Enum
        define :NOT_DERIVED, 0
        define :EXTENSIONAL, 1
        define :DERIVED, 2
        define :DERIVED_AND_STORED, 3
        define :INTEGRITY_CONSTRAINT, 4
      end

      class LogicSort < ::Protobuf::Enum
        define :ACTIVE, 1
        define :INACTIVE, 2
        define :EXECUTE, 3
        define :INACTIVE_AFTER_FIXPOINT, 4
        define :EXECUTE_AFTER_FIXPOINT, 5
      end


      ##
      # Message Classes
      #
      class CompilationProblems < ::Protobuf::Message; end
      class Problem < ::Protobuf::Message; end
      class Position < ::Protobuf::Message; end
      class PredicateInfo < ::Protobuf::Message; end
      class PredicatePopcount < ::Protobuf::Message; end
      class Constant < ::Protobuf::Message
        class Kind < ::Protobuf::Enum
          define :BOOL, 0
          define :INT, 1
          define :FLOAT, 2
          define :STRING, 3
          define :DATETIME, 4
          define :UINT, 5
          define :DECIMAL, 6
        end

      end

      class BoolConstant < ::Protobuf::Message; end
      class IntConstant < ::Protobuf::Message; end
      class UnsignedIntConstant < ::Protobuf::Message; end
      class FloatConstant < ::Protobuf::Message; end
      class DecimalConstant < ::Protobuf::Message; end
      class StringConstant < ::Protobuf::Message; end
      class DateTimeConstant < ::Protobuf::Message; end
      class Type < ::Protobuf::Message
        class Kind < ::Protobuf::Enum
          define :PRIMITIVE, 0
          define :UNARY, 1
        end

      end

      class PrimitiveType < ::Protobuf::Message
        class Kind < ::Protobuf::Enum
          define :BOOL, 0
          define :DECIMAL, 1
          define :SHAPE, 2
          define :IMAGE, 3
          define :BLOB, 4
          define :DATETIME, 5
          define :INT, 6
          define :UINT, 7
          define :FLOAT, 8
          define :STRING, 9
        end

      end

      class UnaryPredicateType < ::Protobuf::Message; end


      ##
      # Message Fields
      #
      class CompilationProblems
        repeated ::Blox::Common::Protocol::Problem, :error, 1
        repeated ::Blox::Common::Protocol::Problem, :warning, 2
      end

      class Problem
        optional ::Protobuf::Field::StringField, :code, 1
        required ::Protobuf::Field::StringField, :msg, 2
        required ::Blox::Common::Protocol::Position, :position, 4
        required ::Blox::Common::Protocol::Severity, :severity_code, 5
        optional ::Protobuf::Field::StringField, :quote, 7
      end

      class Position
        required ::Protobuf::Field::Int64Field, :start_line, 1
        required ::Protobuf::Field::Int64Field, :start_column, 2
        optional ::Protobuf::Field::Int64Field, :end_line, 3
        optional ::Protobuf::Field::Int64Field, :end_column, 4
        optional ::Protobuf::Field::Int64Field, :start_offset, 5
        optional ::Protobuf::Field::Int64Field, :end_offset, 6
        required ::Protobuf::Field::StringField, :block_name, 7
        optional ::Protobuf::Field::StringField, :file_name, 8
      end

      class PredicateInfo
        required ::Protobuf::Field::StringField, :name, 1
        required ::Protobuf::Field::StringField, :qualified_name, 2
        required ::Protobuf::Field::Int64Field, :arity, 3
        required ::Protobuf::Field::Int64Field, :key_arity, 4
        required ::Protobuf::Field::Int64Field, :value_arity, 5
        repeated ::Protobuf::Field::StringField, :key_argument, 6
        repeated ::Protobuf::Field::StringField, :value_argument, 7
        required ::Protobuf::Field::BoolField, :is_entity, 8, :default => false
        required ::Protobuf::Field::BoolField, :is_ref_mode, 9, :default => false
        required ::Protobuf::Field::BoolField, :is_one_to_one, 10, :default => false
        required ::Protobuf::Field::BoolField, :is_ordered, 11, :default => false
        required ::Protobuf::Field::BoolField, :has_default_value, 12, :default => false
        required ::Protobuf::Field::BoolField, :is_subtype, 14, :default => false
        optional ::Protobuf::Field::StringField, :supertype, 15
        optional ::Protobuf::Field::StringField, :toptype, 42
        required ::Protobuf::Field::BoolField, :has_ref_mode, 16, :default => false
        optional ::Protobuf::Field::StringField, :ref_mode_name, 17
        required ::Protobuf::Field::BoolField, :is_meta_predicate, 18, :default => false
        required ::Protobuf::Field::BoolField, :is_pulse_predicate, 19, :default => false
        required ::Protobuf::Field::BoolField, :is_calculated, 20, :default => false
        required ::Blox::Common::Protocol::DerivationType, :derivation_type, 22
        optional ::Protobuf::Field::BoolField, :is_built_in, 28, :default => false
        required ::Protobuf::Field::BoolField, :is_skolem, 29, :default => false
        required ::Blox::Common::Protocol::Lifetime, :lifetime, 30
        required ::Protobuf::Field::BoolField, :is_auto_numbered, 31
        optional ::Blox::Common::Protocol::Constant, :actual_default_value, 32
        optional ::Protobuf::Field::StringField, :file_path, 33
        optional ::Protobuf::Field::StringField, :delimiter, 34
        optional ::Protobuf::Field::BoolField, :has_column_names, 35
        optional ::Protobuf::Field::StringField, :delim_column_names, 36
        optional ::Protobuf::Field::BoolField, :is_sealed, 37, :default => false
        optional ::Protobuf::Field::StringField, :local_name, 38
        optional ::Protobuf::Field::StringField, :definition_block, 44
        optional ::Protobuf::Field::StringField, :display_name, 39
        optional ::Protobuf::Field::BoolField, :is_synthetic, 41
        optional ::Protobuf::Field::BoolField, :is_constructor, 43
      end

      class PredicatePopcount
        required ::Protobuf::Field::StringField, :qualified_name, 1
        optional ::Protobuf::Field::Int64Field, :popcount, 2, :default => -1
      end

      class Constant
        required ::Blox::Common::Protocol::Constant::Kind, :kind, 1
        optional ::Blox::Common::Protocol::BoolConstant, :bool_constant, 2
        optional ::Blox::Common::Protocol::IntConstant, :int_constant, 3
        optional ::Blox::Common::Protocol::FloatConstant, :float_constant, 4
        optional ::Blox::Common::Protocol::StringConstant, :string_constant, 5
        optional ::Blox::Common::Protocol::DateTimeConstant, :date_time_constant, 6
        optional ::Blox::Common::Protocol::UnsignedIntConstant, :uint_constant, 7
        optional ::Blox::Common::Protocol::DecimalConstant, :decimal_constant, 8
      end

      class BoolConstant
        required ::Protobuf::Field::BoolField, :value, 1
        optional ::Blox::Common::Protocol::Position, :position, 2
      end

      class IntConstant
        required ::Protobuf::Field::Int64Field, :value, 1
        required ::Blox::Common::Protocol::Type, :type, 2
        optional ::Blox::Common::Protocol::Position, :position, 3
      end

      class UnsignedIntConstant
        required ::Protobuf::Field::Int64Field, :value, 1
        required ::Blox::Common::Protocol::Type, :type, 2
        optional ::Blox::Common::Protocol::Position, :position, 3
      end

      class FloatConstant
        required ::Protobuf::Field::StringField, :value, 1
        required ::Blox::Common::Protocol::Type, :type, 2
        optional ::Blox::Common::Protocol::Position, :position, 3
      end

      class DecimalConstant
        required ::Protobuf::Field::StringField, :value, 1
        required ::Blox::Common::Protocol::Type, :type, 2
        optional ::Blox::Common::Protocol::Position, :position, 3
      end

      class StringConstant
        required ::Protobuf::Field::StringField, :value, 1
        optional ::Blox::Common::Protocol::Position, :position, 2
      end

      class DateTimeConstant
        optional ::Protobuf::Field::Int64Field, :value, 1
        optional ::Blox::Common::Protocol::Position, :position, 2
      end

      class Type
        required ::Blox::Common::Protocol::Type::Kind, :kind, 1
        optional ::Blox::Common::Protocol::PrimitiveType, :primitive, 2
        optional ::Blox::Common::Protocol::UnaryPredicateType, :unary, 3
      end

      class PrimitiveType
        required ::Blox::Common::Protocol::PrimitiveType::Kind, :kind, 1
        optional ::Protobuf::Field::Int64Field, :capacity, 2
      end

      class UnaryPredicateType
        required ::Protobuf::Field::StringField, :name, 1
      end

    end

  end

end


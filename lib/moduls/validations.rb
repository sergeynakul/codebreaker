# frozen_string_literal: true

module Validations
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validates

    def validate(variable, type, *conditional_value)
      @validates ||= []
      @validates << { variable: variable, type: type, conditional_value: conditional_value }
    end
  end

  module InstanceMethods
    def validate!
      @validates = self.class.instance_variable_get(:@validates)
      @validates.each do |validate|
        value = instance_variable_get("@#{validate[:variable]}")
        name = validate[:variable].capitalize
        send("validate_#{validate[:type]}", value, name, *validate[:conditional_value])
      end
    end

    def validate_presence(value, name)
      raise PresenceError, "#{name} can't be blank" if value.to_s.empty?
    end

    def validate_range(value, name, range)
      return unless value.to_s.split('').map(&:to_i).any? { |number| !range.include?(number) }

      raise OutOfRangeError, "#{name} must be in #{range}"
    end

    def validate_type(value, name, type_class)
      raise ClassTypeError, "#{name} must be an instance of #{type_class} class" unless value.instance_of? type_class
    end

    def validate_length(value, name, length)
      raise LengthError, "#{name} must be #{length} characters" unless valid_length?(value.to_s.split('').count, length)
    end

    def validate_inclusion(value, name, array)
      raise InclusionError, "#{name} must be in #{array.join(', ')}" unless array.include?(value)
    end

    def valid_length?(count, length)
      if length.instance_of?(Integer)
        count == length
      elsif length.instance_of?(Range)
        length.member?(count)
      end
    end
  end
end

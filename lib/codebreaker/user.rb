# frozen_string_literal: true

module Codebreaker
  class User
    NAME_LENGTH = (3..20).freeze
    include Validations

    attr_reader :name

    validate :name, :presence
    validate :name, :type, String
    validate :name, :length, NAME_LENGTH

    def initialize(name)
      @name = name
      validate!
    end
  end
end

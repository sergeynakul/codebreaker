# frozen_string_literal: true

module Codebreaker
  class Guess
    include Validations

    attr_reader :numbers

    validate :numbers, :presence
    validate :numbers, :type, Integer
    validate :numbers, :length, Codebreaker::Codemaker::AMOUNT_OF_NUMBERS
    validate :numbers, :range, Codebreaker::Codemaker::RANGE_OF_NUMBERS

    def initialize(numbers)
      @numbers = numbers
      validate!
    end
  end
end

# frozen_string_literal: true

module Codebreaker
  class Codemaker
    attr_reader :secret_code

    def initialize
      @secret_code = ''
    end

    def generate_secret_code(amout = ::AMOUNT_OF_NUMBERS, range = ::RANGE_OF_NUMBERS)
      array_of_numbers = []
      amout.times { array_of_numbers << rand(range) }
      @secret_code = array_of_numbers.join.to_i
    end
  end
end

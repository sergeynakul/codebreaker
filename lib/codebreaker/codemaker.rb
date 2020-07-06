# frozen_string_literal: true

module Codebreaker
  class Codemaker
    NON_OCCURRING_VALUE_FIRST = 'X'
    NON_OCCURRING_VALUE_SECOND = 'Y'
    NON_OCCURRING_VALUE_THIRD = 'Z'
    IN_PLACE = '+'
    OUT_OF_PLACE = '-'

    attr_reader :secret_code, :response

    def initialize
      @secret_code = ''
      @response = []
    end

    def generate_secret_code(amout = ::AMOUNT_OF_NUMBERS, range = ::RANGE_OF_NUMBERS)
      array_of_numbers = []
      amout.times { array_of_numbers << rand(range) }
      @secret_code = array_of_numbers.join.to_i
    end

    def check(guess_array, secret_code_array)
      guess_array.each_with_index do |number, index|
        next unless number == secret_code_array[index]

        @response << IN_PLACE
        guess_array[index] = NON_OCCURRING_VALUE_FIRST
        secret_code_array[index] = NON_OCCURRING_VALUE_SECOND
      end
      guess_array.each do |number|
        if secret_code_array.include?(number)
          @response << OUT_OF_PLACE
          secret_code_array[secret_code_array.index(number)] = NON_OCCURRING_VALUE_THIRD
        end
      end
    end
  end
end

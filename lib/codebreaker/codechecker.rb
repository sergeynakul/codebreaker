# frozen_string_literal: true

module Codebreaker
  class Codechecker
    attr_reader :guess_array, :secret_code_array, :response

    def initialize(guess_array, secret_code_array)
      @guess_array = guess_array
      @secret_code_array = secret_code_array
      @response = { in_plase: 0, out_of_place: 0 }
    end

    def call
      in_plase_check
      out_of_place_check
    end

    private

    def in_plase_check
      index = 0
      while index < guess_array.size
        if guess_array[index] == secret_code_array[index]
          response[:in_plase] += 1
          guess_array[index] = nil
          secret_code_array[index] = nil
        end
        index += 1
      end
    end

    def out_of_place_check
      guess_array.each do |number|
        if !number.nil? && secret_code_array.include?(number)
          response[:out_of_place] += 1
          secret_code_array[secret_code_array.index(number)] = nil
        end
      end
    end
  end
end

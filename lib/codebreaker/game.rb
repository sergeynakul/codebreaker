# frozen_string_literal: true

module Codebreaker
  class Game
    include Validations

    validate :difficulty, :inclusion, DIFFICULTY_HASH.keys

    attr_reader :user, :difficulty, :secret_code

    def initialize(user, difficulty, secret_code)
      @user = user
      @difficulty = difficulty
      @secret_code = secret_code
      @attempts_used = 0
      @hints_used = []
      validate!
    end

    def check(guess)
      @attempts_used += 1

      guess_array = guess.to_s.split('').map(&:to_i)
      secret_code_array = @secret_code.to_s.split('').map(&:to_i)

      codechecker = Codechecker.new(guess_array, secret_code_array)
      codechecker.call
      codechecker.response
    end

    def any_hints_left?
      DIFFICULTY_HASH[@difficulty][:hints] > @hints_used.count
    end

    def take_hint
      secret_code_array = @secret_code.to_s.split('').map(&:to_i)
      @hints_used.each do |hint_used|
        secret_code_array.delete_at(secret_code_array.index(hint_used))
      end
      random_element = secret_code_array.sample
      @hints_used << random_element
      random_element
    end

    def win?(guess)
      guess == @secret_code
    end

    def lose?
      @attempts_used >= DIFFICULTY_HASH[@difficulty][:attempts]
    end

    def save_result
      saver = Saver.new(@user, @difficulty, @attempts_used, @hints_used)
      saver.call
    end
  end
end

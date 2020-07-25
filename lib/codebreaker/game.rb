# frozen_string_literal: true

module Codebreaker
  class Game
    DIFFICULTY_HASH = { easy: { attempts: 15, hints: 2 },
                        medium: { attempts: 10, hints: 1 },
                        hell: { attempts: 5, hints: 1 } }.freeze

    include Validations

    validate :difficulty, :inclusion, DIFFICULTY_HASH.keys

    attr_reader :user, :difficulty, :secret_code, :hints_used
    attr_accessor :attempts_used

    def initialize(user, difficulty, secret_code)
      @user = user
      @difficulty = difficulty
      @secret_code = secret_code
      @attempts_used = 0
      @hints_used = []
      validate!
    end

    def check(guess)
      self.attempts_used += 1

      guess_array = guess.digits.reverse
      secret_code_array = secret_code.digits.reverse

      codechecker = Codechecker.new(guess_array, secret_code_array)
      codechecker.call
      codechecker.response
    end

    def any_hints_left?
      DIFFICULTY_HASH[difficulty][:hints] > hints_used.count
    end

    def take_hint
      secret_code_array = secret_code.digits.reverse
      hints_used.each do |hint_used|
        secret_code_array.delete_at(secret_code_array.index(hint_used))
      end
      hint = secret_code_array.sample
      hints_used << hint
      hint
    end

    def win?(guess)
      guess == secret_code
    end

    def lose?
      attempts_used >= DIFFICULTY_HASH[difficulty][:attempts]
    end
  end
end

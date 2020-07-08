# frozen_string_literal: true

module Codebreaker
  class Game
    include Validations

    DIFFICULTY_HASH = { easy: { attempts: 15, hints: 2 },
                        medium: { attempts: 10, hints: 1 },
                        hell: { attempts: 5, hints: 1 } }.freeze

    validate :difficulty, :inclusion, %i[easy medium hell]

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

      codemaker = Codebreaker::Codemaker.new
      codemaker.check(guess_array, secret_code_array)
      codemaker.response
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
      data = "#{@user.name},#{@difficulty},"
      data += "#{DIFFICULTY_HASH[@difficulty][:attempts]},#{@attempts_used},"
      data += "#{DIFFICULTY_HASH[@difficulty][:hints]},#{@hints_used.count}"
      File.open(RESULTS_FILE, 'a') do |file|
        file.puts data
      end
    end
  end
end

# frozen_string_literal: true

module Codebreaker
  class Game
    include Validations

    DIFFICULTY_HASH = { easy: { attempts: 15, hints: 2 },
                        medium: { attempts: 10, hints: 1 },
                        hell: { attempts: 5, hints: 1 } }.freeze
    NON_OCCURRING_VALUE_FIRST = 'X'
    NON_OCCURRING_VALUE_SECOND = 'Y'
    NON_OCCURRING_VALUE_THIRD = 'Z'
    IN_PLACE = '+'
    OUT_OF_PLACE = '-'
    WIN = [IN_PLACE, IN_PLACE, IN_PLACE, IN_PLACE].freeze

    validate :difficulty, :inclusion, %i[easy medium hell]

    def initialize(user, difficulty)
      @user = user
      @difficulty = difficulty
      @attempts_used = 0
      @hints_used = []
      validate!
    end

    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def check(guess, secret_code)
      @attempts_used += 1
      return WIN if guess == secret_code

      response = []
      guess_array = guess.to_s.split('').map(&:to_i)
      secret_code_array = secret_code.to_s.split('').map(&:to_i)
      guess_array.each_with_index do |number, index|
        next unless number == secret_code_array[index]

        response << IN_PLACE
        guess_array[index] = NON_OCCURRING_VALUE_FIRST
        secret_code_array[index] = NON_OCCURRING_VALUE_SECOND
      end
      guess_array.each do |number|
        if secret_code_array.include?(number)
          response << OUT_OF_PLACE
          secret_code_array[secret_code_array.index(number)] = NON_OCCURRING_VALUE_THIRD
        end
      end
      response
    end
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    def any_hints_left?
      DIFFICULTY_HASH[@difficulty][:hints] > @hints_used.count
    end

    def take_hint(secret_code)
      secret_code_array = secret_code.to_s.split('').map(&:to_i)
      @hints_used.each do |hint_used|
        secret_code_array.delete_at(secret_code_array.index(hint_used))
      end
      random_element = secret_code_array.sample
      @hints_used << random_element
      random_element
    end

    def win?(guess, secret_code)
      guess == secret_code
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

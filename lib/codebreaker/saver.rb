# frozen_string_literal: true

module Codebreaker
  class Saver
    RESULTS_FILE = 'lib/files/results_file.csv'

    attr_reader :user, :difficulty, :attempts_used, :hints_used

    def initialize(user, difficulty, attempts_used, hints_used)
      @user = user
      @difficulty = difficulty
      @attempts_used = attempts_used
      @hints_used = hints_used
    end

    def call
      data = "#{user.name},#{difficulty},"
      data += "#{DIFFICULTY_HASH[difficulty][:attempts]},#{attempts_used},"
      data += "#{DIFFICULTY_HASH[difficulty][:hints]},#{hints_used.count}"
      File.open(RESULTS_FILE, 'a') do |file|
        file.puts data
      end
    end
  end
end

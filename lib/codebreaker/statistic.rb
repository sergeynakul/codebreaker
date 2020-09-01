# frozen_string_literal: true

module Codebreaker
  class Statistic
    attr_reader :file_path

    def initialize(file_path)
      @file_path = file_path
    end

    def save(game)
      data = File.file?(file_path) && !File.zero?(file_path) ? read : []
      data << new_record(game)
      file = File.open(file_path, 'w')
      file.write(data.to_yaml)
      file.close
    end

    def read
      YAML.load_file(file_path)
    end

    private

    def new_record(game)
      user = game.user.name
      attempts_total = Codebreaker::Game::DIFFICULTY_HASH[game.difficulty][:attempts]
      attempts_used = game.attempts_used
      hints_total = Codebreaker::Game::DIFFICULTY_HASH[game.difficulty][:hints]
      hints_used = game.hints_used.size
      { user: user, difficulty: game.difficulty, attempts_total: attempts_total,
        attempts_used: attempts_used, hints_total: hints_total, hints_used: hints_used }
    end
  end
end

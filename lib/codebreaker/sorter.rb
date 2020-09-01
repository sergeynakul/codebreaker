# frozen_string_literal: true

module Codebreaker
  class Sorter
    CONDITIONAL_ARRAY = %i[hell medium easy].freeze

    attr_reader :data

    def initialize(data)
      @data = data
    end

    def call
      sorted = sort_by_hints(data)
      sorted = sort_by_attempts(sorted)
      sorted = sort_by_difficulties(sorted)
      sorted
    end

    private

    def sort_by_hints(data)
      data.sort_by { |row| row[:hints_used] }
    end

    def sort_by_attempts(data)
      data.sort_by { |row| row[:attempts_used] }
    end

    def sort_by_difficulties(data)
      data.sort_by { |row| CONDITIONAL_ARRAY.index(row[:difficulty]) }
    end
  end
end

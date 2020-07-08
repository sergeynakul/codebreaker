# frozen_string_literal: true

RANGE_OF_NUMBERS = (1..6).freeze
AMOUNT_OF_NUMBERS = 4
DIFF_ARRAY = %w[hell medium easy].freeze
RESULTS_FILE = 'lib/files/results_file.csv'
RULES_FILE = 'lib/files/rules.txt'

module Codebreaker
  require 'csv'
  require 'codebreaker/version'
  require 'moduls/validations'
  require 'codebreaker/game'
  require 'codebreaker/user'
  require 'codebreaker/codemaker'
  require 'codebreaker/guess'
  require 'errors/validation_error'
  require 'errors/length_error'
  require 'errors/presence_error'
  require 'errors/out_of_range_error'
  require 'errors/class_type_error'
  require 'errors/inclusion_error'
end

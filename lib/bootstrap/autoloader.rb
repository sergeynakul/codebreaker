# frozen_string_literal: true

RANGE_OF_NUMBERS = (1..6).freeze
AMOUNT_OF_NUMBERS = 4
DIFF_ARRAY = %w[hell medium easy].freeze
RESULTS_FILE = 'lib/bootstrap/results_file.csv'
RULES_FILE = 'lib/bootstrap/rules.txt'

require 'csv'
require_relative '../codebreaker'
require_relative '../codebreaker/version'
require_relative '../moduls/validations'
require_relative '../codebreaker/game'
require_relative '../codebreaker/user'
require_relative '../codebreaker/codemaker'
require_relative '../codebreaker/guess'
require_relative '../errors/validation_error'
require_relative '../errors/length_error'
require_relative '../errors/presence_error'
require_relative '../errors/out_of_range_error'
require_relative '../errors/class_type_error'
require_relative '../errors/inclusion_error'

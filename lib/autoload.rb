# frozen_string_literal: true

RANGE_OF_NUMBERS = (1..6).freeze
AMOUNT_OF_NUMBERS = 4
DIFFICULTY_HASH = { easy: { attempts: 15, hints: 2 },
                    medium: { attempts: 10, hints: 1 },
                    hell: { attempts: 5, hints: 1 } }.freeze

require 'csv'
require_relative 'codebreaker/version'
require_relative 'moduls/validations'
require_relative 'codebreaker/game'
require_relative 'codebreaker/user'
require_relative 'codebreaker/codemaker'
require_relative 'codebreaker/codechecker'
require_relative 'codebreaker/guess'
require_relative 'codebreaker/saver'
require_relative 'errors/validation_error'
require_relative 'errors/length_error'
require_relative 'errors/presence_error'
require_relative 'errors/out_of_range_error'
require_relative 'errors/class_type_error'
require_relative 'errors/inclusion_error'

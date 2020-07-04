# frozen_string_literal: true

require 'spec_helper'

module Codebreaker
  RSpec.describe Guess do
    context '.new' do
      describe 'invalid' do
        it 'raise PresenceError if numbers blank' do
          expect { Codebreaker::Guess.new('') }.to raise_error(PresenceError)
        end

        it 'raise ClassTypeError if numbers is not a integer' do
          expect { Codebreaker::Guess.new('123') }.to raise_error(ClassTypeError)
        end

        it 'raise LengthError if numbers is not 4 length' do
          expect { Codebreaker::Guess.new(123) }.to raise_error(LengthError)
          expect { Codebreaker::Guess.new(12_345) }.to raise_error(LengthError)
        end

        it 'raise OutOfRangeError if numbers is not from 1 to 6' do
          expect { Codebreaker::Guess.new(7777) }.to raise_error(OutOfRangeError)
        end
      end
    end
  end
end

# frozen_string_literal: true

module Codebreaker
  RSpec.describe Guess do
    describe '.new' do
      describe 'invalid' do
        it 'raise PresenceError if numbers blank' do
          expect { described_class.new('') }.to raise_error(PresenceError)
        end

        it 'raise ClassTypeError if numbers is not a integer' do
          expect { described_class.new('123') }.to raise_error(ClassTypeError)
        end

        it 'raise LengthError if numbers is less then 4 length' do
          expect { described_class.new(123) }.to raise_error(LengthError)
        end

        it 'raise LengthError if numbers is more then 4 length' do
          expect { described_class.new(12_345) }.to raise_error(LengthError)
        end

        it 'raise OutOfRangeError if numbers is not from 1 to 6' do
          expect { described_class.new(7777) }.to raise_error(OutOfRangeError)
        end
      end
    end
  end
end

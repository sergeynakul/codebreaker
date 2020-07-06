# frozen_string_literal: true

require 'spec_helper'

module Codebreaker
  RSpec.describe User do
    describe '.new' do
      describe 'invalid' do
        it 'raise PresenceError if name blank' do
          expect { described_class.new('') }.to raise_error(PresenceError)
        end

        it 'raise ClassTypeError if name is not a string' do
          expect { described_class.new(123) }.to raise_error(ClassTypeError)
        end

        it 'raise LengthError if name is less then 3 length' do
          expect { described_class.new('S') }.to raise_error(LengthError)
        end

        it 'raise LengthError if name is more then 20 length' do
          expect { described_class.new('Sssssssssssssssssssss') }.to raise_error(LengthError)
        end
      end
    end
  end
end

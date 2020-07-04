# frozen_string_literal: true

require 'spec_helper'

module Codebreaker
  RSpec.describe User do
    context '.new' do
      describe 'invalid' do
        it 'raise PresenceError if name blank' do
          expect { Codebreaker::User.new('') }.to raise_error(PresenceError)
        end

        it 'raise ClassTypeError if name is not a string' do
          expect { Codebreaker::User.new(123) }.to raise_error(ClassTypeError)
        end

        it 'raise LengthError if name is not 3-20 length' do
          expect { Codebreaker::User.new('S') }.to raise_error(LengthError)
          expect { Codebreaker::User.new('Sssssssssssssssssssss') }.to raise_error(LengthError)
        end
      end
    end
  end
end

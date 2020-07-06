# frozen_string_literal: true

require 'spec_helper'

module Codebreaker
  # rubocop:disable Metrics/BlockLength
  RSpec.describe Game do
    let(:user) { Codebreaker::User.new('Ivan') }
    let(:secret_code) { 1234 }
    let(:game) { described_class.new(user, :easy, secret_code) }

    describe '.new' do
      it 'raise InclusionError if difficulty is not :easy, :medium or :hell' do
        expect { described_class.new(user, :hard, secret_code) }.to raise_error(InclusionError)
      end
    end

    describe '#check' do
      context 'when secret_code is 6543' do
        let(:secret_code) { 6543 }

        it 'return valid response when guess 5643' do
          expect(game.check(5643)).to eq ['+', '+', '-', '-']
        end

        it 'return valid response when guess 6411' do
          expect(game.check(6411)).to eq ['+', '-']
        end

        it 'return valid response when guess 6544' do
          expect(game.check(6544)).to eq ['+', '+', '+']
        end

        it 'return valid response when guess 3456' do
          expect(game.check(3456)).to eq ['-', '-', '-', '-']
        end

        it 'return valid response when guess 6666' do
          expect(game.check(6666)).to eq ['+']
        end

        it 'return valid response when guess 2666' do
          expect(game.check(2666)).to eq ['-']
        end

        it 'return valid response when guess 2222' do
          expect(game.check(2222)).to eq []
        end
      end

      context 'when secret_code is 6666' do
        let(:secret_code) { 6666 }

        it 'return valid response' do
          expect(game.check(1661)).to eq ['+', '+']
        end
      end

      context 'when secret_code is 1234' do
        it 'return valid response when guess 3124' do
          expect(game.check(3124)).to eq ['+', '-', '-', '-']
        end

        it 'return valid response when guess 1524' do
          expect(game.check(1524)).to eq ['+', '+', '-']
        end

        it 'return valid response when guess 1234' do
          expect(game.check(1234)).to eq ['+', '+', '+', '+']
        end
      end
    end

    describe '#any_hints_left?' do
      it 'return true' do
        expect(game.any_hints_left?).to be true
      end

      it 'return false' do
        game.take_hint
        game.take_hint
        expect(game.any_hints_left?).to be false
      end
    end

    describe '#take_hint' do
      let(:first_hint) { game.take_hint }

      it 'return random number of secret code' do
        expect(first_hint).to eq(1).or eq(2).or eq(3).or eq(4)
      end

      it 'not return the same number' do
        second_hint = game.take_hint
        expect(second_hint).not_to eq(first_hint)
      end
    end

    describe '#win?' do
      it 'return true' do
        expect(game.win?(1234)).to be true
      end

      it 'return false' do
        expect(game.win?(6543)).to be false
      end
    end

    describe '#lose?' do
      it 'return false' do
        expect(game.lose?).to be false
      end

      it 'return true' do
        15.times { game.check(6543) }
        expect(game.lose?).to be true
      end
    end
  end
  # rubocop:enable Metrics/BlockLength
end

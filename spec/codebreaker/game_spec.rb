# frozen_string_literal: true

require 'spec_helper'

module Codebreaker
  # rubocop:disable Metrics/BlockLength
  RSpec.describe Game do
    let(:user) { Codebreaker::User.new('Ivan') }
    let(:game) { Codebreaker::Game.new(user, :easy) }

    context '.new' do
      it 'raise InclusionError if difficulty is not :easy, :medium or :hell' do
        expect { Codebreaker::Game.new(user, :hard) }.to raise_error(InclusionError)
      end
    end

    context '#check' do
      it 'return valid response' do
        expect(game.check(5643, 6543)).to eq ['+', '+', '-', '-']
        expect(game.check(6411, 6543)).to eq ['+', '-']
        expect(game.check(6544, 6543)).to eq ['+', '+', '+']
        expect(game.check(3456, 6543)).to eq ['-', '-', '-', '-']
        expect(game.check(6666, 6543)).to eq ['+']
        expect(game.check(2666, 6543)).to eq ['-']
        expect(game.check(2222, 6543)).to eq []
        expect(game.check(1661, 6666)).to eq ['+', '+']
        expect(game.check(3124, 1234)).to eq ['+', '-', '-', '-']
        expect(game.check(1524, 1234)).to eq ['+', '+', '-']
        expect(game.check(1234, 1234)).to eq ['+', '+', '+', '+']
      end
    end

    context '#any_hints_left?' do
      it 'return true' do
        expect(game.any_hints_left?).to be true
      end

      it 'return false' do
        game.take_hint(1111)
        game.take_hint(1111)
        expect(game.any_hints_left?).to be false
      end
    end

    context '#take_hint' do
      it 'return random number of secret code' do
        first_hint = game.take_hint(1234)
        expect(first_hint).to eq(1).or eq(2).or eq(3).or eq(4)
        second_hint = game.take_hint(1234)
        expect(second_hint).to_not eq(first_hint)
      end
    end

    context '#win?' do
      it 'return true' do
        expect(game.win?(1234, 1234)).to be true
      end

      it 'return false' do
        expect(game.win?(1234, 6543)).to be false
      end
    end

    context '#lose?' do
      it 'return false' do
        expect(game.lose?).to be false
      end

      it 'return true' do
        15.times { game.check(1234, 6543) }
        expect(game.lose?).to be true
      end
    end
  end
  # rubocop:enable Metrics/BlockLength
end

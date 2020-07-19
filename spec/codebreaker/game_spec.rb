# frozen_string_literal: true

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
      describe 'then secret_code is 6543' do
        [
          { secret_code: 6543, guess: 5643, response: { in_plase: 2, out_of_place: 2 } },
          { secret_code: 6543, guess: 6411, response: { in_plase: 1, out_of_place: 1 } },
          { secret_code: 6543, guess: 6544, response: { in_plase: 3, out_of_place: 0 } },
          { secret_code: 6543, guess: 6544, response: { in_plase: 3, out_of_place: 0 } },
          { secret_code: 6543, guess: 3456, response: { in_plase: 0, out_of_place: 4 } },
          { secret_code: 6543, guess: 6666, response: { in_plase: 1, out_of_place: 0 } },
          { secret_code: 6543, guess: 2666, response: { in_plase: 0, out_of_place: 1 } },
          { secret_code: 6543, guess: 2222, response: { in_plase: 0, out_of_place: 0 } }
        ].each do |check|
          let(:secret_code) { check[:secret_code] }

          it 'return valid response' do
            expect(game.check(check[:guess])).to eq(check[:response])
          end
        end
      end

      describe 'then secret_code is 6666' do
        let(:secret_code) { 6666 }

        it 'return valid response' do
          expect(game.check(1661)).to eq({ in_plase: 2, out_of_place: 0 })
        end
      end

      describe 'then secret_code is 1234' do
        [
          { secret_code: 1234, guess: 3124, response: { in_plase: 1, out_of_place: 3 } },
          { secret_code: 1234, guess: 1524, response: { in_plase: 2, out_of_place: 1 } },
          { secret_code: 1234, guess: 1234, response: { in_plase: 4, out_of_place: 0 } }
        ].each do |check|
          let(:secret_code) { check[:secret_code] }

          it 'return valid response' do
            expect(game.check(check[:guess])).to eq(check[:response])
          end
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

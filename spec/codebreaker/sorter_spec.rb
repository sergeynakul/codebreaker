# frozen_string_literal: true

module Codebreaker
  RSpec.describe Sorter do
    data = []
    subject(:sorter) { described_class.new(data) }

    describe '#call' do
      it 'sort by hints' do
        data = [{ user: 'Ivan', difficulty: :hell, attempts_total: 5, attempts_used: 2, hints_total: 1, hints_used: 1 },
                { user: 'Ivan', difficulty: :hell, attempts_total: 5, attempts_used: 2, hints_total: 1, hints_used: 0 }]
        sorted_data = sorter.call
        expect(sorted_data.first[:hints_used]).to be < sorted_data.last[:hints_used]
      end

      it 'sort by attempts' do
        data = [{ user: 'Ivan', difficulty: :hell, attempts_total: 5, attempts_used: 2, hints_total: 1, hints_used: 0 },
                { user: 'Ivan', difficulty: :hell, attempts_total: 5, attempts_used: 1, hints_total: 1, hints_used: 0 }]
        sorted_data = sorter.call
        expect(sorted_data.first[:attempts_used]).to be < sorted_data.last[:attempts_used]
      end

      it 'sort by difficulties' do
        data = [{ user: 'Ivan', difficulty: :easy, attempts_total: 5, attempts_used: 2, hints_total: 1, hints_used: 0 },
                { user: 'Ivan', difficulty: :hell, attempts_total: 5, attempts_used: 2, hints_total: 1, hints_used: 0 }]
        sorted_data = sorter.call
        expect(sorted_data.first[:difficulty]).to eq :hell
      end
    end
  end
end

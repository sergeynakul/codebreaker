# frozen_string_literal: true

module Codebreaker
  RSpec.describe Codemaker do
    describe '#generate_secret_code' do
      subject(:code_maker) { described_class.new }

      before do
        code_maker.generate_secret_code
      end

      it 'saves secret code' do
        expect(code_maker.instance_variable_get(:@secret_code).to_s).not_to be_empty
      end

      it 'saves 4 numbers secret code' do
        expect(code_maker.instance_variable_get(:@secret_code).to_s.size).to eq 4
      end

      it 'saves secret code with numbers from 1 to 6' do
        expect(code_maker.instance_variable_get(:@secret_code).to_s).to match(/[1-6]+/)
      end
    end
  end
end

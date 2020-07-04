# frozen_string_literal: true

require 'spec_helper'

module Codebreaker
  RSpec.describe Codemaker do
    context '#generate_secret_code' do
      let(:code_maker) { Codebreaker::Codemaker.new }

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

require 'rails_helper'

RSpec.describe Host, type: :model do
  describe '#description' do
    it 'show name, lastname and email' do
      host = Host.new(name: 'Julia', lastname: 'Almeida', email: 'julia@yahoo.com')

      result = host.description

      expect(result).to eq 'Julia Almeida - julia@yahoo.com'
    end
  end
end

require 'rails_helper'

RSpec.describe Host, type: :model do
  describe '#description' do
    it 'show name, lastname and email' do
      host = Host.new(name: 'Julia', lastname: 'Almeida', email: 'julia@yahoo.com')

      result = host.description

      expect(result).to eq 'Julia Almeida - julia@yahoo.com'
    end
  end

  describe '#valid?' do
    it 'returns false when name is empty' do
      host = Host.new(name: '', lastname: 'Xavier', email: 'paulo@email.com', password: 'password')

      result = host.valid?
      
      expect(result).to eq false
    end

    it 'returns false when lastname is empty' do
      host = Host.new(name: 'Paulo', lastname: '', email: 'paulo@email.com', password: 'password')

      result = host.valid?
      
      expect(result).to eq false
    end

    it 'returns false when email is empty' do
      host = Host.new(name: 'Paulo', lastname: 'Xavier', email: '', password: 'password')

      result = host.valid?
      
      expect(result).to eq false
    end

    it 'returns false when password is empty' do
      host = Host.new(name: 'Paulo', lastname: 'Xavier', email: 'paulo@email.com', password: '')

      result = host.valid?
      
      expect(result).to eq false
    end
  end
end

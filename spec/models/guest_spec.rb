require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe '#valid?' do
  it 'returns false when name is empty' do
    guest = Guest.new(name: '', lastname: 'Xavier', document_number: '10.111.222-3', email: 'paulo@email.com', password: 'password')

    result = guest.valid?
    
    expect(result).to eq false
  end

  it 'returns false when lastname is empty' do
    guest = Guest.new(name: 'Paulo', lastname: '', document_number: '10.111.222-3', email: 'paulo@email.com', password: 'password')

    result = guest.valid?
    
    expect(result).to eq false
  end

  it 'returns false when email is empty' do
    guest = Guest.new(name: 'Paulo', lastname: 'Xavier', document_number: '10.111.222-3', email: '', password: 'password')

    result = guest.valid?
    
    expect(result).to eq false
  end

  it 'returns false when password is empty' do
    guest = Guest.new(name: 'Paulo', lastname: 'Xavier', document_number: '10.111.222-3', email: 'paulo@email.com', password: '')

    result = guest.valid?
    
    expect(result).to eq false
  end
end
end

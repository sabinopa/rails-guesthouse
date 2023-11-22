require 'rails_helper'

describe 'Guesthouse API' do
  context 'GET /api/v1/guesthouses/1' do
    it 'success' do
      host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
      payment_method = PaymentMethod.create!(method: 'PIX')
      guesthouse = Guesthouse.create!(host: host,  description: 'Um refúgio à beira-mar com vista panorâmica', brand_name: 'Pousada Maré Alta',
                                      corporate_name: 'Maré Alta Hospedagens Ltda', registration_number: '11.111.111/0001-11', phone_number: '55 55555-5555',
                                      email: 'contato@pousadamarealta.com', address: 'Avenida Beira Mar, 123', neighborhood: 'Costa Brilhante',
                                      city: 'Florianópolis', state: 'SC', postal_code: '54321-90', payment_method_id: payment_method.id, 
                                      pet_friendly: 'Aceita animais de estimação', usage_policy: 'Proibido fumar nas dependências.',
                                      checkin: '15:00', checkout: '11:00', status: :active)
                                      
      get "/api/v1/guesthouses/#{guesthouse.id}"

      expect(response.status).to eq 200
    end
  end
end
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
      expect(response.content_type).to include 'application/json'
      expect(response.body).to include 'Pousada Maré Alta'
      json_response = JSON.parse(response.body)
      expect(json_response["guesthouse"]["brand_name"]).to eq 'Pousada Maré Alta'
      expect(json_response["guesthouse"]["city"]).to eq 'Florianópolis'
      expect(json_response.keys).not_to include 'created_at' 
      expect(json_response.keys).not_to include 'updated_at' 
      expect(json_response.keys).not_to include 'corporate_name' 
      expect(json_response.keys).not_to include 'registration_number' 
    end

    it 'with search params' do
      host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
      payment_method = PaymentMethod.create!(method: 'PIX')
      guesthouse = Guesthouse.create!(host: host,  description: 'Um refúgio à beira-mar com vista panorâmica', brand_name: 'Pousada Maré Alta',
                                      corporate_name: 'Maré Alta Hospedagens Ltda', registration_number: '11.111.111/0001-11', phone_number: '55 55555-5555',
                                      email: 'contato@pousadamarealta.com', address: 'Avenida Beira Mar, 123', neighborhood: 'Costa Brilhante',
                                      city: 'Florianópolis', state: 'SC', postal_code: '54321-90', payment_method_id: payment_method.id, 
                                      pet_friendly: 'Aceita animais de estimação', usage_policy: 'Proibido fumar nas dependências.',
                                      checkin: '15:00', checkout: '11:00', status: :active)
                                      
      get "/api/v1/guesthouses/#{guesthouse.id}", params: { search: 'Pousada' }

      expect(response.status).to eq 200
    end

    it 'fail if guesthouse was not found' do
      get "/api/v1/guesthouses/999"
      expect(response.status).to eq 404
    end
  end

  context 'GET /api/v1/guesthouses' do
    it 'list all guesthouses and ordered by name' do
      host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
      payment_method = PaymentMethod.create!(method: 'PIX')
      guesthouse_one = Guesthouse.create!(host: host,  description: 'Um refúgio à beira-mar com vista panorâmica', brand_name: 'Pousada Maré Alta',
                                      corporate_name: 'Maré Alta Hospedagens Ltda', registration_number: '11.111.111/0001-11', phone_number: '55 55555-5555',
                                      email: 'contato@pousadamarealta.com', address: 'Avenida Beira Mar, 123', neighborhood: 'Costa Brilhante',
                                      city: 'Florianópolis', state: 'SC', postal_code: '54321-90', payment_method_id: payment_method.id, 
                                      pet_friendly: 'Aceita animais de estimação', usage_policy: 'Proibido fumar nas dependências.',
                                      checkin: '15:00', checkout: '11:00', status: :active)

      second_host = Host.create!(name: 'Bruna', lastname: 'Almeida', email: 'bruna@email.com', password: '12345678')
      guesthouse_two = Guesthouse.create!(host: second_host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
                                      

      get '/api/v1/guesthouses'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]["brand_name"]).to eq 'Pousada Maré Alta'
      expect(json_response[1]["brand_name"]).to eq 'Pousada Serenidade'
    end

    it 'return empty if there is no guesthouse' do
      get '/api/v1/guesthouses'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'and raise internal error' do
      allow(Guesthouse).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/guesthouses'
      expect(response).to have_http_status(500)
    end
  end
end
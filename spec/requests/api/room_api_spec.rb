require 'rails_helper'

describe 'Room Availability API' do
  context 'GET /api/v1/guesthouses/1/rooms/1/availability' do
    it 'successfully' do
      host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
      payment_method = PaymentMethod.create!(method: 'PIX')
      guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                      corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                      email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                      city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                      usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
      room = Room.create!(guesthouse: guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, max_people: '4', 
                                      price: '100,00', bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                                      accessibility: 'Acessível para pessoas com deficiência', status: 0)

      get "/api/v1/guesthouses/#{guesthouse.id}/rooms/#{room.id}/availability", params: { start_date: 20.days.from_now, end_date: 25.days.from_now, number_guests: 3 }

      expect(response.status).to eq 200
      json_response = JSON.parse(response.body)
      expect(json_response).to have_key('available')
      expect(json_response).to have_key('total_price')
      expect(json_response['total_price']).to eq 500.00
      expect(json_response['available']).to eq true
      expect(json_response['total_price']).to be_a Float
    end

    it 'returns an error when room availability check fails' do
      host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
      payment_method = PaymentMethod.create!(method: 'PIX')
      guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                      corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                      email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                      city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                      usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
      room = Room.create!(guesthouse: guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, max_people: '4', 
                                      price: '220,00', bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                                      accessibility: 'Acessível para pessoas com deficiência', status: 0)
      guest = Guest.create!(name: 'Guilherme', lastname: 'Oliveira', document_number: '10.111.222-3', email: 'guilherme@email.com', password: 'senha1234')
      booking = Booking.create!(guest: guest, host: host, start_date: 20.days.ago, end_date: 25.days.from_now, number_guests: '3', 
                                      room: room, prices: 100.0, status: :ongoing, checkin_time: 2.days.ago)
    
      get "/api/v1/guesthouses/#{guesthouse.id}/rooms/#{room.id}/availability", params: { start_date: 20.days.from_now, end_date: 25.days.from_now, number_guests: 3 } 
    
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['available']).to eq false
    end

    it 'fail if if room not found' do
      host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
      payment_method = PaymentMethod.create!(method: 'PIX')
      guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                      corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                      email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                      city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                      usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
 
      get "/api/v1/guesthouses/#{guesthouse.id}/rooms/XYZ"
      expect(response.status).to eq 404
    end

     it 'fail if parameters are not complete' do 
       host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
       payment_method = PaymentMethod.create!(method: 'PIX')
       guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                       corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                       email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                       city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                       usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
       room = Room.create!(guesthouse: guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, max_people: '4', 
                                       price: '220,00', bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                                       accessibility: 'Acessível para pessoas com deficiência', status: 0)
 
      get "/api/v1/guesthouses/#{guesthouse.id}/rooms/#{room.id}/availability", params: { start_date: '', end_date: '', number_guests: '' }

      expect(response).to have_http_status 412 
      expect(response.body).to include 'Data de início não pode ficar em branco'
      expect(response.body).to include 'Data de término não pode ficar em branco'
      expect(response.body).to include 'Número de hóspedes não pode ficar em branco'
    end
  end
end

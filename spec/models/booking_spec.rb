require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe '#valid?' do
    it 'returns false when start date is empty' do
      host = Host.create!(name: 'Paulo', lastname: 'Xavier', email: 'paulo@email.com', password: 'password')
      payment_method = PaymentMethod.create!(method: 'Crédito até 3x')
      guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                      corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                      email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                      city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                      usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
      room = Room.create!(guesthouse: guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, max_people: '4', 
                          price: 100.0, bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                          accessibility: 'Acessível para pessoas com deficiência', status: 1)
      guest = Guest.create!(name: 'Leticia', lastname: 'Souza', document_number: '10.111.222-3', email: 'leticia@email.com', password: '12345678')
      booking = Booking.new(guest: guest, host: host, start_date: '', end_date: 3.days.from_now, number_guests: '2', room: room, prices: 500.0, status: :done)

      result = booking.valid?
      
      expect(result).to eq false
    end

    it 'returns false when end date is empty' do
      host = Host.create!(name: 'Paulo', lastname: 'Xavier', email: 'paulo@email.com', password: 'password')
      payment_method = PaymentMethod.create!(method: 'Crédito até 3x')
      guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                      corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                      email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                      city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                      usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
      room = Room.create!(guesthouse: guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, max_people: '4', 
                          price: 100.0, bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                          accessibility: 'Acessível para pessoas com deficiência', status: 1)
      guest = Guest.create!(name: 'Leticia', lastname: 'Souza', document_number: '10.111.222-3', email: 'leticia@email.com', password: '12345678')
      booking = Booking.new(guest: guest, host: host, start_date: 2.days.from_now, end_date: '', number_guests: '2', room: room, prices: 500.0, status: :done)

      result = booking.valid?
      
      expect(result).to eq false
    end

    it 'returns false when number guests is empty' do
      host = Host.create!(name: 'Paulo', lastname: 'Xavier', email: 'paulo@email.com', password: 'password')
      payment_method = PaymentMethod.create!(method: 'Crédito até 3x')
      guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                      corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                      email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                      city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                      usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
      room = Room.create!(guesthouse: guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, max_people: '4', 
                          price: 100.0, bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                          accessibility: 'Acessível para pessoas com deficiência', status: 1)
      guest = Guest.create!(name: 'Leticia', lastname: 'Souza', document_number: '10.111.222-3', email: 'leticia@email.com', password: '12345678')
      booking = Booking.new(guest: guest, host: host, start_date: 2.days.from_now, end_date: 3.days.from_now, number_guests: '', room: room, prices: 500.0, status: :done)

      result = booking.valid?
      
      expect(result).to eq false
    end
  end
end

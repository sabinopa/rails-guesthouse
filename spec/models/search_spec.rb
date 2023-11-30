require 'rails_helper'

RSpec.describe Search, type: :model do
  describe 'successfull search' do
    it 'returns results by brand_name' do
      host = Host.create!(name: 'Paulo', lastname: 'Xavier', email: 'paulo@email.com', password: 'password')
      payment_method = PaymentMethod.create!(method: 'Crédito até 3x')
      guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                      corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                      email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                      city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                      usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
      second_host = Host.create!(name: 'Bruna', lastname: 'Almeida', email: 'bruna@email.com', password: '12345678')
      second_guesthouse = Guesthouse.create!(host: second_host,  description: 'Um refúgio à beira-mar com vista panorâmica', brand_name: 'Pousada Maré Alta',
                                            corporate_name: 'Maré Alta Hospedagens Ltda', registration_number: '11.111.111/0001-11', phone_number: '55 55555-5555',
                                            email: 'contato@pousadamarealta.com', address: 'Avenida Beira Mar, 123', neighborhood: 'Costa Brilhante',
                                            city: 'Florianópolis', state: 'SC', postal_code: '54321-90', payment_method_id: payment_method.id, 
                                            pet_friendly: 'Aceita animais de estimação', usage_policy: 'Proibido fumar nas dependências.',
                                            checkin: '15:00', checkout: '11:00', status: 1)
      
      result = Guesthouse.search('serenidade')

      expect(result).to eq [guesthouse]
    end

    it 'returns results by neighbourhood' do
      host = Host.create!(name: 'Paulo', lastname: 'Xavier', email: 'paulo@email.com', password: 'password')
      payment_method = PaymentMethod.create!(method: 'Crédito até 3x')
      guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                      corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                      email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                      city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                      usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
      second_host = Host.create!(name: 'Bruna', lastname: 'Almeida', email: 'bruna@email.com', password: '12345678')
      second_guesthouse = Guesthouse.create!(host: second_host,  description: 'Um refúgio à beira-mar com vista panorâmica', brand_name: 'Pousada Maré Alta',
                                            corporate_name: 'Maré Alta Hospedagens Ltda', registration_number: '11.111.111/0001-11', phone_number: '55 55555-5555',
                                            email: 'contato@pousadamarealta.com', address: 'Avenida Beira Mar, 123', neighborhood: 'Costa Brilhante',
                                            city: 'Florianópolis', state: 'SC', postal_code: '54321-90', payment_method_id: payment_method.id, 
                                            pet_friendly: 'Aceita animais de estimação', usage_policy: 'Proibido fumar nas dependências.',
                                            checkin: '15:00', checkout: '11:00', status: 1)
      
      result = Guesthouse.search('costa brilhante')

      expect(result).to eq [second_guesthouse]
    end

    it 'returns results by city' do
      host = Host.create!(name: 'Paulo', lastname: 'Xavier', email: 'paulo@email.com', password: 'password')
      payment_method = PaymentMethod.create!(method: 'Crédito até 3x')
      guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                      corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                      email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                      city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                      usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
      second_host = Host.create!(name: 'Bruna', lastname: 'Almeida', email: 'bruna@email.com', password: '12345678')
      second_guesthouse = Guesthouse.create!(host: second_host,  description: 'Um refúgio à beira-mar com vista panorâmica', brand_name: 'Pousada Maré Alta',
                                            corporate_name: 'Maré Alta Hospedagens Ltda', registration_number: '11.111.111/0001-11', phone_number: '55 55555-5555',
                                            email: 'contato@pousadamarealta.com', address: 'Avenida Beira Mar, 123', neighborhood: 'Costa Brilhante',
                                            city: 'Florianópolis', state: 'SC', postal_code: '54321-90', payment_method_id: payment_method.id, 
                                            pet_friendly: 'Aceita animais de estimação', usage_policy: 'Proibido fumar nas dependências.',
                                            checkin: '15:00', checkout: '11:00', status: 1)
      
      result = Guesthouse.search('maceió')

      expect(result).to eq [guesthouse]
    end

    it 'returns nil result' do
      
      result = Guesthouse.search('saudades')

      expect(result).to eq []
    end
  end
end

require 'rails_helper'

RSpec.describe Guesthouse, type: :model do
  describe '#valid?' do
    context 'incomplete datas' do
      it 'false when description is empty' do
        host = Host.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@email.com', password: 'secretpassword')
        payment_method = PaymentMethod.create!(method: 'Dinheiro')
        guesthouse = Guesthouse.new(host: host, description: '', brand_name: 'Hotel Vista Verde', 
                                        corporate_name: 'Vista Verde Hospedagens S.A.', registration_number: '15.678.543/0001-30', 
                                        phone_number: '42 98765-4321', email: 'reservas@hotelvistaverde.com', address: 'Avenida das Montanhas, 123', 
                                        neighborhood: 'Bosque Sereno', city: 'Gramado', state: 'RS', postal_code: '98765-432', 
                                        payment_method_id: payment_method.id, pet_friendly: 'Não aceita animais de estimação', 
                                        usage_policy: 'Proibido fumar em todas as áreas internas.', checkin: '15:00', checkout: '11:00', status: 1)

        result = guesthouse.valid?
      
        expect(result).to eq false
      end

      it 'false brand_name is empty' do
        host = Host.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@email.com', password: 'secretpassword')
        payment_method = PaymentMethod.create!(method: 'Dinheiro')
        guesthouse = Guesthouse.new(host: host, description: 'Um refúgio luxuoso no coração da natureza', brand_name: '', 
                                        corporate_name: 'Vista Verde Hospedagens S.A.', registration_number: '15.678.543/0001-30', 
                                        phone_number: '42 98765-4321', email: 'reservas@hotelvistaverde.com', address: 'Avenida das Montanhas, 123', 
                                        neighborhood: 'Bosque Sereno', city: 'Gramado', state: 'RS', postal_code: '98765-432', 
                                        payment_method_id: payment_method.id, pet_friendly: 'Não aceita animais de estimação', 
                                        usage_policy: 'Proibido fumar em todas as áreas internas.', checkin: '15:00', checkout: '11:00', status: 1)

        result = guesthouse.valid?
      
        expect(result).to eq false
      end

      it 'false when corporate_name is empty' do
        host = Host.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@email.com', password: 'secretpassword')
        payment_method = PaymentMethod.create!(method: 'Dinheiro')
        guesthouse = Guesthouse.new(host: host, description: 'Um refúgio luxuoso no coração da natureza', brand_name: 'Hotel Vista Verde', 
                                        corporate_name: '', registration_number: '15.678.543/0001-30', phone_number: '42 98765-4321', 
                                        email: 'reservas@hotelvistaverde.com', address: 'Avenida das Montanhas, 123', 
                                        neighborhood: 'Bosque Sereno', city: 'Gramado', state: 'RS', postal_code: '98765-432', 
                                        payment_method_id: payment_method.id, pet_friendly: 'Não aceita animais de estimação', 
                                        usage_policy: 'Proibido fumar em todas as áreas internas.', checkin: '15:00', checkout: '11:00', status: 1)

        result = guesthouse.valid?
      
        expect(result).to eq false
      end

      it 'false when registration_number is empty' do
        host = Host.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@email.com', password: 'secretpassword')
        payment_method = PaymentMethod.create!(method: 'Dinheiro')
        guesthouse = Guesthouse.new(host: host, description: 'Um refúgio luxuoso no coração da natureza', brand_name: 'Hotel Vista Verde', 
                                        corporate_name: 'Vista Verde Hospedagens S.A.', registration_number: '', 
                                        phone_number: '42 98765-4321', email: 'reservas@hotelvistaverde.com', address: 'Avenida das Montanhas, 123', 
                                        neighborhood: 'Bosque Sereno', city: 'Gramado', state: 'RS', postal_code: '98765-432', 
                                        payment_method_id: payment_method.id, pet_friendly: 'Não aceita animais de estimação', 
                                        usage_policy: 'Proibido fumar em todas as áreas internas.', checkin: '15:00', checkout: '11:00', status: 1)

        result = guesthouse.valid?
      
        expect(result).to eq false
      end

      it 'false when phone_number is empty' do
        host = Host.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@email.com', password: 'secretpassword')
        payment_method = PaymentMethod.create!(method: 'Dinheiro')
        guesthouse = Guesthouse.new(host: host, description: 'Um refúgio luxuoso no coração da natureza', brand_name: 'Hotel Vista Verde', 
                                        corporate_name: 'Vista Verde Hospedagens S.A.', registration_number: '15.678.543/0001-30', 
                                        phone_number: '', email: 'reservas@hotelvistaverde.com', address: 'Avenida das Montanhas, 123', 
                                        neighborhood: 'Bosque Sereno', city: 'Gramado', state: 'RS', postal_code: '98765-432', 
                                        payment_method_id: payment_method.id, pet_friendly: 'Não aceita animais de estimação', 
                                        usage_policy: 'Proibido fumar em todas as áreas internas.', checkin: '15:00', checkout: '11:00', status: 1)

        result = guesthouse.valid?
      
        expect(result).to eq false
      end

      it 'false when email is empty' do
        host = Host.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@email.com', password: 'secretpassword')
        payment_method = PaymentMethod.create!(method: 'Dinheiro')
        guesthouse = Guesthouse.new(host: host, description: 'Um refúgio luxuoso no coração da natureza', brand_name: 'Hotel Vista Verde', 
                                        corporate_name: 'Vista Verde Hospedagens S.A.', registration_number: '15.678.543/0001-30', 
                                        phone_number: '42 98765-4321', email: '', address: 'Avenida das Montanhas, 123', 
                                        neighborhood: 'Bosque Sereno', city: 'Gramado', state: 'RS', postal_code: '98765-432', 
                                        payment_method_id: payment_method.id, pet_friendly: 'Não aceita animais de estimação', 
                                        usage_policy: 'Proibido fumar em todas as áreas internas.', checkin: '15:00', checkout: '11:00', status: 1)

        result = guesthouse.valid?
      
        expect(result).to eq false
      end

      it 'false when address is empty' do
        host = Host.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@email.com', password: 'secretpassword')
        payment_method = PaymentMethod.create!(method: 'Dinheiro')
        guesthouse = Guesthouse.new(host: host, description: 'Um refúgio luxuoso no coração da natureza', brand_name: 'Hotel Vista Verde', 
                                        corporate_name: 'Vista Verde Hospedagens S.A.', registration_number: '15.678.543/0001-30', 
                                        phone_number: '42 98765-4321', email: 'reservas@hotelvistaverde.com', address: '', 
                                        neighborhood: 'Bosque Sereno', city: 'Gramado', state: 'RS', postal_code: '98765-432', 
                                        payment_method_id: payment_method.id, pet_friendly: 'Não aceita animais de estimação', 
                                        usage_policy: 'Proibido fumar em todas as áreas internas.', checkin: '15:00', checkout: '11:00', status: 1)

        result = guesthouse.valid?
      
        expect(result).to eq false
      end

      it 'false when neithborhood is empty' do
        host = Host.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@email.com', password: 'secretpassword')
        payment_method = PaymentMethod.create!(method: 'Dinheiro')
        guesthouse = Guesthouse.new(host: host, description: 'Um refúgio luxuoso no coração da natureza', brand_name: 'Hotel Vista Verde', 
                                        corporate_name: 'Vista Verde Hospedagens S.A.', registration_number: '15.678.543/0001-30', 
                                        phone_number: '42 98765-4321', email: 'reservas@hotelvistaverde.com', address: 'Avenida das Montanhas, 123', 
                                        neighborhood: '', city: 'Gramado', state: 'RS', postal_code: '98765-432', 
                                        payment_method_id: payment_method.id, pet_friendly: 'Não aceita animais de estimação', 
                                        usage_policy: 'Proibido fumar em todas as áreas internas.', checkin: '15:00', checkout: '11:00', status: 1)

        result = guesthouse.valid?
      
        expect(result).to eq false
      end

      it 'false when city is empty' do
        host = Host.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@email.com', password: 'secretpassword')
        payment_method = PaymentMethod.create!(method: 'Dinheiro')
        guesthouse = Guesthouse.new(host: host, description: 'Um refúgio luxuoso no coração da natureza', brand_name: 'Hotel Vista Verde', 
                                        corporate_name: 'Vista Verde Hospedagens S.A.', registration_number: '15.678.543/0001-30', 
                                        phone_number: '42 98765-4321', email: 'reservas@hotelvistaverde.com', address: 'Avenida das Montanhas, 123', 
                                        neighborhood: 'Bosque Sereno', city: '', state: 'RS', postal_code: '98765-432', 
                                        payment_method_id: payment_method.id, pet_friendly: 'Não aceita animais de estimação', 
                                        usage_policy: 'Proibido fumar em todas as áreas internas.', checkin: '15:00', checkout: '11:00', status: 1)

        result = guesthouse.valid?
      
        expect(result).to eq false
      end

      it 'false when state is empty' do
        host = Host.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@email.com', password: 'secretpassword')
        payment_method = PaymentMethod.create!(method: 'Dinheiro')
        guesthouse = Guesthouse.new(host: host, description: 'Um refúgio luxuoso no coração da natureza', brand_name: 'Hotel Vista Verde', 
                                        corporate_name: 'Vista Verde Hospedagens S.A.', registration_number: '15.678.543/0001-30', 
                                        phone_number: '42 98765-4321', email: 'reservas@hotelvistaverde.com', address: 'Avenida das Montanhas, 123', 
                                        neighborhood: 'Bosque Sereno', city: 'Gramado', state: '', postal_code: '98765-432', 
                                        payment_method_id: payment_method.id, pet_friendly: 'Não aceita animais de estimação', 
                                        usage_policy: 'Proibido fumar em todas as áreas internas.', checkin: '15:00', checkout: '11:00', status: 1)

        result = guesthouse.valid?
      
        expect(result).to eq false
      end

      it 'false when postal_code is empty' do
        host = Host.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@email.com', password: 'secretpassword')
        payment_method = PaymentMethod.create!(method: 'Dinheiro')
        guesthouse = Guesthouse.new(host: host, description: 'Um refúgio luxuoso no coração da natureza', brand_name: 'Hotel Vista Verde', 
                                        corporate_name: 'Vista Verde Hospedagens S.A.', registration_number: '15.678.543/0001-30', 
                                        phone_number: '42 98765-4321', email: 'reservas@hotelvistaverde.com', address: 'Avenida das Montanhas, 123', 
                                        neighborhood: 'Bosque Sereno', city: 'Gramado', state: 'RS', postal_code: '', 
                                        payment_method_id: payment_method.id, pet_friendly: 'Não aceita animais de estimação', 
                                        usage_policy: 'Proibido fumar em todas as áreas internas.', checkin: '15:00', checkout: '11:00', status: 1)

        result = guesthouse.valid?
      
        expect(result).to eq false
      end

      it 'false when payment_method_id is empty' do
        host = Host.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@email.com', password: 'secretpassword')
        payment_method = PaymentMethod.create!(method: 'Dinheiro')
        guesthouse = Guesthouse.new(host: host, description: 'Um refúgio luxuoso no coração da natureza', brand_name: 'Hotel Vista Verde', 
                                        corporate_name: 'Vista Verde Hospedagens S.A.', registration_number: '15.678.543/0001-30', 
                                        phone_number: '42 98765-4321', email: 'reservas@hotelvistaverde.com', address: 'Avenida das Montanhas, 123', 
                                        neighborhood: 'Bosque Sereno', city: 'Gramado', state: 'RS', postal_code: '98765-432', 
                                        payment_method_id: '', pet_friendly: 'Não aceita animais de estimação', 
                                        usage_policy: 'Proibido fumar em todas as áreas internas.', checkin: '15:00', checkout: '11:00', status: 1)

        result = guesthouse.valid?
      
        expect(result).to eq false
      end

      it 'false when usage_policy is empty' do
        host = Host.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@email.com', password: 'secretpassword')
        payment_method = PaymentMethod.create!(method: 'Dinheiro')
        guesthouse = Guesthouse.new(host: host, description: 'Um refúgio luxuoso no coração da natureza', brand_name: 'Hotel Vista Verde', 
                                        corporate_name: 'Vista Verde Hospedagens S.A.', registration_number: '15.678.543/0001-30', 
                                        phone_number: '42 98765-4321', email: 'reservas@hotelvistaverde.com', address: 'Avenida das Montanhas, 123', 
                                        neighborhood: 'Bosque Sereno', city: 'Gramado', state: 'RS', postal_code: '98765-432', 
                                        payment_method_id: payment_method.id, pet_friendly: 'Não aceita animais de estimação', 
                                        usage_policy: '', checkin: '15:00', checkout: '11:00', status: 1)

        result = guesthouse.valid?
      
        expect(result).to eq false
      end

      it 'false when check in is empty' do
        host = Host.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@email.com', password: 'secretpassword')
        payment_method = PaymentMethod.create!(method: 'Dinheiro')
        guesthouse = Guesthouse.new(host: host, description: 'Um refúgio luxuoso no coração da natureza', brand_name: 'Hotel Vista Verde', 
                                        corporate_name: 'Vista Verde Hospedagens S.A.', registration_number: '15.678.543/0001-30', 
                                        phone_number: '42 98765-4321', email: 'reservas@hotelvistaverde.com', address: 'Avenida das Montanhas, 123', 
                                        neighborhood: 'Bosque Sereno', city: 'Gramado', state: 'RS', postal_code: '98765-432', 
                                        payment_method_id: payment_method.id, pet_friendly: 'Não aceita animais de estimação', 
                                        usage_policy: 'Proibido fumar em todas as áreas internas.', checkin: '', checkout: '11:00', status: 1)

        result = guesthouse.valid?
      
        expect(result).to eq false
      end

      it 'false when check out is empty' do
        host = Host.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@email.com', password: 'secretpassword')
        payment_method = PaymentMethod.create!(method: 'Dinheiro')
        guesthouse = Guesthouse.new(host: host, description: 'Um refúgio luxuoso no coração da natureza', brand_name: 'Hotel Vista Verde', 
                                        corporate_name: 'Vista Verde Hospedagens S.A.', registration_number: '15.678.543/0001-30', 
                                        phone_number: '42 98765-4321', email: 'reservas@hotelvistaverde.com', address: 'Avenida das Montanhas, 123', 
                                        neighborhood: 'Bosque Sereno', city: 'Gramado', state: 'RS', postal_code: '98765-432', 
                                        payment_method_id: payment_method.id, pet_friendly: 'Não aceita animais de estimação', 
                                        usage_policy: 'Proibido fumar em todas as áreas internas.', checkin: '15:00', checkout: '', status: 1)

        result = guesthouse.valid?
      
        expect(result).to eq false
      end
    end
  end
end

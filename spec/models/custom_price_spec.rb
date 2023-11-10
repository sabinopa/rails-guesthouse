require 'rails_helper'

RSpec.describe CustomPrice, type: :model do
  describe '#valid?' do
    context 'incomplete datas' do
      it 'false when start date is empty' do
        host = Host.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@email.com', password: 'secretpassword')
        payment_method = PaymentMethod.create!(method: 'Dinheiro')
        guesthouse = Guesthouse.create!(host: host, description: 'Um refúgio luxuoso no coração da natureza', brand_name: 'Hotel Vista Verde', 
                                        corporate_name: 'Vista Verde Hospedagens S.A.', registration_number: '15.678.543/0001-30', 
                                        phone_number: '42 98765-4321', email: 'reservas@hotelvistaverde.com', address: 'Avenida das Montanhas, 123', 
                                        neighborhood: 'Bosque Sereno', city: 'Gramado', state: 'RS', postal_code: '98765-432', 
                                        payment_method_id: payment_method.id, pet_friendly: 'Não aceita animais de estimação', 
                                        usage_policy: 'Proibido fumar em todas as áreas internas.', checkin: '15:00', checkout: '11:00', status: 1)
        room = Room.create!(guesthouse: guesthouse, name: 'Aconchego', description: 'Um espaço acolhedor para momentos especiais.', size: 18, 
                        max_people: '2', price: 200, bathroom: true, balcony: false, tv: true, wardrobe: true, safe: false, accessibility: true, status: 1)
        custom_price = CustomPrice.new(room: room, start_date: '', end_date: '15/12/2023', price: 300.00)

        result = custom_price.valid?
      
        expect(result).to eq false
      end

      it 'false when end date is empty' do
        host = Host.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@email.com', password: 'secretpassword')
        payment_method = PaymentMethod.create!(method: 'Dinheiro')
        guesthouse = Guesthouse.create!(host: host, description: 'Um refúgio luxuoso no coração da natureza', brand_name: 'Hotel Vista Verde', 
                                        corporate_name: 'Vista Verde Hospedagens S.A.', registration_number: '15.678.543/0001-30', 
                                        phone_number: '42 98765-4321', email: 'reservas@hotelvistaverde.com', address: 'Avenida das Montanhas, 123', 
                                        neighborhood: 'Bosque Sereno', city: 'Gramado', state: 'RS', postal_code: '98765-432', 
                                        payment_method_id: payment_method.id, pet_friendly: 'Não aceita animais de estimação', 
                                        usage_policy: 'Proibido fumar em todas as áreas internas.', checkin: '15:00', checkout: '11:00', status: 1)
        room = Room.create!(guesthouse: guesthouse, name: 'Aconchego', description: 'Um espaço acolhedor para momentos especiais.', size: 18, 
                        max_people: '2', price: 200, bathroom: true, balcony: false, tv: true, wardrobe: true, safe: false, accessibility: true, status: 1)
        custom_price = CustomPrice.new(room: room, start_date: '10/12/2023', end_date: '', price: 300.00)

        result = custom_price.valid?
      
        expect(result).to eq false
      end

      it 'false when price is empty' do
        host = Host.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@email.com', password: 'secretpassword')
        payment_method = PaymentMethod.create!(method: 'Dinheiro')
        guesthouse = Guesthouse.create!(host: host, description: 'Um refúgio luxuoso no coração da natureza', brand_name: 'Hotel Vista Verde', 
                                        corporate_name: 'Vista Verde Hospedagens S.A.', registration_number: '15.678.543/0001-30', 
                                        phone_number: '42 98765-4321', email: 'reservas@hotelvistaverde.com', address: 'Avenida das Montanhas, 123', 
                                        neighborhood: 'Bosque Sereno', city: 'Gramado', state: 'RS', postal_code: '98765-432', 
                                        payment_method_id: payment_method.id, pet_friendly: 'Não aceita animais de estimação', 
                                        usage_policy: 'Proibido fumar em todas as áreas internas.', checkin: '15:00', checkout: '11:00', status: 1)
        room = Room.create!(guesthouse: guesthouse, name: 'Aconchego', description: 'Um espaço acolhedor para momentos especiais.', size: 18, 
                        max_people: '2', price: 200, bathroom: true, balcony: false, tv: true, wardrobe: true, safe: false, accessibility: true, status: 1)
        custom_price = CustomPrice.new(room: room, start_date: '10/12/2023', end_date: '15/12/2023', price: '')

        result = custom_price.valid?
      
        expect(result).to eq false
      end
    end
  end
end

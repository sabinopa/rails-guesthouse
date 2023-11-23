require 'rails_helper'

describe 'Guest creates review' do
  it 'from home page' do
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
    guest = Guest.create!(name: 'Leticia', lastname: 'Souza', email: 'leticia@email.com', password: '12345678')
    booking = Booking.create!(guest: guest, host: host, start_date: 10.days.ago, end_date: 5.days.ago, number_guests: '2', room: room, 
                              prices: 500.0, status: :done)

    allow(SecureRandom).to receive(:alphanumeric).and_return('QWERT123')

    login_as(guest, :scope => :guest)  
    visit my_bookings_path
    click_on 'Avaliar Estadia'
                       
                          
    expect(current_path).to eq guesthouse_room_path(guesthouse.id, room.id)


  end
end
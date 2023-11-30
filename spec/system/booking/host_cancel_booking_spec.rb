require 'rails_helper'

describe 'Host cancels booking' do
  it 'successfully' do
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
    booking = Booking.create!(guest: guest, host: host, start_date: 2.days.ago, end_date: 3.days.from_now, number_guests: '2', room: room, prices: 500.0, status: 0)

    login_as(host, :scope => :host)  
    visit root_path
    click_on 'Reservas'
    click_on 'Gerenciar Reserva'
    click_on 'Cancelar Reserva'

    expect(page).to have_content "Reserva #{booking.code} cancelada com sucesso!"
    expect(current_path).to eq host_control_guesthouse_room_booking_path(guesthouse.id, room.id, booking.id)
  end

  it 'check-in is delayed more than two days' do
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
    booking = Booking.create!(guest: guest, host: host, start_date: 2.days.ago, end_date: 3.days.from_now, number_guests: '2', room: room, prices: 500.0, status: 0)

    login_as(host, :scope => :host)  
    visit root_path
    click_on 'Reservas'
    click_on 'Gerenciar Reserva'

    expect(page).to have_button 'Cancelar Reserva'
  end

  it 'check-in is not delayed more than two days' do
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
    booking = Booking.create!(guest: guest, host: host, start_date: 3.days.from_now, end_date: 5.days.from_now, number_guests: '2', room: room, prices: 200.0, status: 0)

    login_as(host, :scope => :host)  
    visit root_path
    click_on 'Reservas'
    click_on 'Gerenciar Reserva'

    expect(page).not_to have_button 'Cancelar Reserva'
  end
end
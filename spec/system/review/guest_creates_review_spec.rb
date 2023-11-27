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

    login_as(guest, :scope => :guest) 
    visit root_path
    click_on 'Minhas Reservas'
    click_on 'Avaliar Estadia'
 
    expect(current_path).to eq new_guesthouse_room_booking_review_path(guesthouse.id, room.id, booking.id)
    expect(page).to have_content "Como foi sua experiência em #{guesthouse.brand_name} durante a reserva #{booking.code} ?"
    expect(page).to have_field 'Nota'  
    expect(page).to have_field 'Comentário'  
    expect(page).to have_button 'Criar Avaliação'  
  end

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
    guest = Guest.create!(name: 'Leticia', lastname: 'Souza', email: 'leticia@email.com', password: '12345678')
    booking = Booking.create!(guest: guest, host: host, start_date: 10.days.ago, end_date: 5.days.ago, number_guests: '2', room: room, 
                              prices: 500.0, status: :done)

    allow(SecureRandom).to receive(:alphanumeric).and_return('QWERT123')

    login_as(guest, :scope => :guest)  
    visit my_bookings_path
    click_on 'Avaliar Estadia'
    select 5, from: 'Nota'
    fill_in 'Comentário', with: 'O atendimento da equipe é excepcional!'
    click_on 'Criar Avaliação'
                         
    expect(current_path).to eq my_bookings_path
    expect(page).not_to have_content 'Avaliar Estadia'
  end

  it 'with empties fields' do
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

    login_as(guest, :scope => :guest)  
    visit my_bookings_path
    click_on 'Avaliar Estadia'
    select 5, from: 'Nota'
    fill_in 'Comentário', with: ''
    click_on 'Criar Avaliação'
                         
    expect(current_path).to eq guesthouse_room_booking_reviews_path(guesthouse.id, room.id, booking.id)
    expect(page).to have_content 'Comentário não pode ficar em branco'
  end

  it 'only after checkout' do
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
    booking = Booking.create!(guest: guest, host: host, start_date: 2.days.ago, end_date: 4.days.from_now, number_guests: '2', room: room, 
                              prices: 600.0, status: :ongoing)

    login_as(guest, :scope => :guest)  
    visit new_guesthouse_room_booking_review_path(guesthouse.id, room.id, booking.id)
                         
    expect(current_path).to eq my_bookings_path
    expect(page).to have_content 'Desculpe, mas você não tem permissão para realizar essa ação.'
  end

  it 'unable to review bookings made by others.' do
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
    guest_one = Guest.create!(name: 'Leticia', lastname: 'Souza', email: 'leticia@email.com', password: '12345678')
    booking_one = Booking.create!(guest: guest_one, host: host, start_date: 15.days.ago, end_date: 10.days.ago, number_guests: '2', room: room, 
                              prices: 500.0, status: :done)
    guest_two = Guest.create(name: 'Camila', lastname: 'Melo', email: 'camila@email.com', password: 'senha135')
    booking_two = Booking.create(guest: guest_two, host: host, start_date: 25.days.from_now, end_date: 20.days.ago, number_guests: '2', room: room,
                                prices: 500.0, status: :done)

    login_as(guest_two, :scope => :guest)
    visit new_guesthouse_room_booking_review_path(guesthouse.id, room.id, booking_one.id)

    expect(page).to have_content 'Desculpe, mas você não tem permissão para realizar essa ação.'
    expect(current_path).to eq my_bookings_path
  end

  it 'only one review for each booking' do
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
    booking = Booking.create!(guest: guest, host: host, start_date: 4.days.ago, end_date: 2.days.ago, number_guests: '2', room: room, 
                              prices: 200.0, status: :ongoing)
    review = Review.create!(guest: guest, booking: booking, rating: 5, comment: 'Lugar maravilhoso!')

    login_as(guest, :scope => :guest)  
    visit new_guesthouse_room_booking_review_path(guesthouse.id, room.id, booking.id)
                         
    expect(current_path).to eq my_bookings_path
    expect(page).to have_content 'Desculpe, mas você não tem permissão para realizar essa ação.'
  end
end
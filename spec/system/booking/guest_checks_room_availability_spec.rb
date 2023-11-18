require 'rails_helper'

describe 'Guest checks availability of a room' do
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
    custom_price = CustomPrice.create!(room: room, start_date: 2.days.from_now, end_date: 4.days.from_now, price: 300.0)
    guest = Guest.create!(name: 'Leticia', lastname: 'Souza', email: 'leticia@email.com', password: '12345678')


    login_as(guest, :scope => :guest)  
    visit root_path
    click_on 'Pousada Serenidade'
    click_on 'Tranquilidade - 4 pessoas'
    fill_in 'Entrada', with: 2.days.from_now
    fill_in 'Saída', with: 6.days.from_now
    fill_in 'Número de hóspedes', with: '3'
    click_on 'Verificar'

    expect(page).to have_content 'Antes de finalizar, confirme os dados da sua reserva:'
    start_date = I18n.localize 2.days.from_now.to_date
    end_date = I18n.localize 6.days.from_now.to_date
    expect(page).to have_content "Entrada: #{start_date} - 14:00"
    expect(page).to have_content "Saída: #{end_date} - 10:00"
    expect(page).to have_content 'Número de hóspedes: 3'
    expect(page).to have_content "Valor total: R$ 800.0" 
  end

  it 'must be authenticated' do
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
    custom_price = CustomPrice.create!(room: room, start_date: 2.days.from_now, end_date: 12.days.from_now, price: 300.0)
    guest = Guest.create!(name: 'Leticia', lastname: 'Souza', email: 'leticia@email.com', password: '12345678')

    visit root_path
    click_on 'Pousada Serenidade'
    click_on 'Tranquilidade - 4 pessoas'
    fill_in 'Entrada', with: 2.days.from_now
    fill_in 'Saída', with: 5.days.from_now
    fill_in 'Número de hóspedes', with: '3'
    click_on 'Verificar'

    expect(current_path).to eq new_guest_session_path
    expect(page).to have_content 'Olá, hóspede!'
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
    expect(page).to have_content 'Acesse o seu perfil:'
    expect(page).to have_content 'E-mail'
    expect(page).to have_content 'Senha'
  end

  it 'after being redirected to log in as a guest, guest is redirected to your previous screen' do
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
    custom_price = CustomPrice.create!(room: room, start_date: 2.days.from_now, end_date: 12.days.from_now, price: 300.0)
    guest = Guest.create!(name: 'Leticia', lastname: 'Souza', email: 'leticia@email.com', password: '12345678')

    visit guesthouse_room_path(guesthouse.id, room.id)
    fill_in 'Entrada', with: 5.days.from_now
    fill_in 'Saída', with: 10.days.from_now
    fill_in 'Número de hóspedes', with: '3'
    click_on 'Verificar'
    fill_in 'E-mail', with: 'leticia@email.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'

    expect(current_path).to eq new_guesthouse_room_booking_path(guesthouse.id, room.id)
    expect(page).to have_content 'Antes de finalizar, confirme os dados da sua reserva:'
    start_date = I18n.localize 5.days.from_now.to_date
    end_date = I18n.localize 10.days.from_now.to_date
    expect(page).to have_content "Entrada: #{start_date} - 14:00"
    expect(page).to have_content "Saída: #{end_date} - 10:00"
    expect(page).to have_content 'Número de hóspedes: 3'
    expect(page).to have_content "Valor total: R$ 1500.0" 
  end

  it 'with dates empties' do
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


    login_as(guest, :scope => :guest)  
    visit guesthouse_room_path(guesthouse.id, room.id)
    fill_in 'Entrada', with: ''
    fill_in 'Saída', with: ''
    fill_in 'Número de hóspedes', with: '3'
    click_on 'Verificar'

    expect(current_path).to eq guesthouse_room_path(guesthouse.id, room.id)
    expect(page).to have_content 'Por favor, preencha todos os campos.'
  end

  it 'with guests number empty' do
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


    login_as(guest, :scope => :guest)  
    visit guesthouse_room_path(guesthouse.id, room.id)
    fill_in 'Entrada', with: 1.day.from_now
    fill_in 'Saída', with: 3.days.from_now
    fill_in 'Número de hóspedes', with: ''
    click_on 'Verificar'

    expect(current_path).to eq guesthouse_room_path(guesthouse.id, room.id)
    expect(page).to have_content 'Por favor, preencha todos os campos.'
  end

  it 'and room is not available in the period' do
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
    first_guest = Guest.create!(name: 'Leticia', lastname: 'Souza', email: 'leticia@email.com', password: '12345678')
    booking = Booking.create!(guest: first_guest, host: host, start_date: 2.days.from_now, end_date: 4.days.from_now, number_guests: '2', room: room, prices: 200.0, status: :booked)
    second_guest = Guest.create!(name: 'Lucas', lastname: 'Garcia', email: 'lucas@email.com', password: 'senhasenha')

    login_as(second_guest, :scope => :guest)  
    visit guesthouse_room_path(guesthouse.id, room.id)
    fill_in 'Entrada', with: 2.day.from_now
    fill_in 'Saída', with: 6.days.from_now
    fill_in 'Número de hóspedes', with: '3'
    click_on 'Verificar'

    expect(current_path).to eq guesthouse_room_path(guesthouse.id, room.id)
    expect(page).to have_content 'Esse quarto não está disponível nas datas escolhidas, tente novas datas.'
  end

  it 'and selected a number of people greater than the capacity' do
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


    login_as(guest, :scope => :guest)  
    visit guesthouse_room_path(guesthouse.id, room.id)
    fill_in 'Entrada', with: 1.day.from_now
    fill_in 'Saída', with: 3.days.from_now
    fill_in 'Número de hóspedes', with: '6'
    click_on 'Verificar'

    expect(current_path).to eq guesthouse_room_path(guesthouse.id, room.id)
    expect(page).to have_content 'Este quarto não suporta tantas pessoas.'
  end

  it 'and insert past dates' do
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


    login_as(guest, :scope => :guest)  
    visit guesthouse_room_path(guesthouse.id, room.id)
    fill_in 'Entrada', with: 10.days.ago
    fill_in 'Saída', with: 3.days.ago
    fill_in 'Número de hóspedes', with: '3'
    click_on 'Verificar'

    expect(current_path).to eq guesthouse_room_path(guesthouse.id, room.id)
    expect(page).to have_content 'A data de início não pode ser no passado.'
  end

  it 'and insert end_date before start_date' do
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


    login_as(guest, :scope => :guest)  
    visit guesthouse_room_path(guesthouse.id, room.id)
    fill_in 'Entrada', with: 1.day.from_now
    fill_in 'Saída', with: 15.days.ago
    fill_in 'Número de hóspedes', with: '3'
    click_on 'Verificar'

    expect(current_path).to eq guesthouse_room_path(guesthouse.id, room.id)
    expect(page).to have_content 'A data de início deve ser anterior à data final.'
  end
end
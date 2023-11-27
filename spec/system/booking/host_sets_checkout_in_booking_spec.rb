require 'rails_helper'

describe 'Host sets checkout in booking' do
  it 'successfully' do
    host = Host.create!(name: 'Ana', lastname: 'Silva', email: 'ana@email.com', password: 'senha123')
    payment_method = PaymentMethod.create!(method: 'Débito')
    guesthouse = Guesthouse.create!(host: host, description: 'Local aconchegante para momentos especiais', brand_name: 'Pousada Encanto',
                                corporate_name: 'Encanto Hospedagens Eireli', registration_number: '12.345.678/0001-90', 
                                phone_number: '11 98765-4321', email: 'contato@pousadaencanto.com.br', address: 'Rua das Flores, 123', 
                                neighborhood: 'Bela Vista', city: 'São Paulo', state:'SP', postal_code: '98765-43', 
                                payment_method_id: payment_method.id, pet_friendly:  'Aceita animais de estimação', 
                                usage_policy: 'Proibido fumar nas dependências.', checkin: '15:00', checkout: '11:00', status: 1)
    room = Room.create!(guesthouse: guesthouse, name: 'Harmonia', description: 'Espaço agradável para relaxar.', size: 20, max_people: '3',
                        price: 100.0, bathroom: 'Compartilhado', balcony: 'Possui', tv: 'Não possui', wardrobe: 'Possui',
                        safe: 'Não possui', accessibility: 'Não acessível para cadeiras de rodas', status: 1)
    guest = Guest.create!(name: 'Guilherme', lastname: 'Oliveira', email: 'guilherme@email.com', password: 'senha1234')
    booking = Booking.create!(guest: guest, host: host, start_date: 3.days.ago, end_date: Date.today, number_guests: '3', 
                              room: room, prices: 400.0, status: :ongoing, checkin_time: 3.days.ago)

    login_as(host, :scope => :host)
    visit root_path
    click_on 'Estadias Ativas'
    click_on 'Gerenciar Reserva'
    click_on 'Registrar Check-out'
    click_on 'Finalizar Check-out'

    expect(page).to have_content "Reserva #{booking.code} finalizada!" 
    expect(page).not_to have_button 'Registrar Check-in' 
    expect(page).not_to have_button 'Registrar Check-out' 
    expect(page).not_to have_button 'Cancelar Reserva' 
  end

  it 'before end date and price is adjusted' do
    host = Host.create!(name: 'Ana', lastname: 'Silva', email: 'ana@email.com', password: 'senha123')
    payment_method = PaymentMethod.create!(method: 'Débito')
    guesthouse = Guesthouse.create!(host: host, description: 'Local aconchegante para momentos especiais', brand_name: 'Pousada Encanto',
                                corporate_name: 'Encanto Hospedagens Eireli', registration_number: '12.345.678/0001-90', 
                                phone_number: '11 98765-4321', email: 'contato@pousadaencanto.com.br', address: 'Rua das Flores, 123', 
                                neighborhood: 'Bela Vista', city: 'São Paulo', state:'SP', postal_code: '98765-43', 
                                payment_method_id: payment_method.id, pet_friendly:  'Aceita animais de estimação', 
                                usage_policy: 'Proibido fumar nas dependências.', checkin: '15:00', checkout: '11:00', status: 1)
    room = Room.create!(guesthouse: guesthouse, name: 'Harmonia', description: 'Espaço agradável para relaxar.', size: 20, max_people: '3',
                    price: 100.0, bathroom: 'Compartilhado', balcony: 'Possui', tv: 'Não possui', wardrobe: 'Possui',
                    safe: 'Não possui', accessibility: 'Não acessível para cadeiras de rodas', status: 1)
    guest = Guest.create!(name: 'Guilherme', lastname: 'Oliveira', email: 'guilherme@email.com', password: 'senha1234')
    booking = Booking.create!(guest: guest, host: host, start_date: 2.days.ago, end_date: 5.days.from_now, number_guests: '3', 
                              room: room, prices: 700.0, status: :ongoing, checkin_time: 45.hours.ago)

    login_as(host, :scope => :host)
    visit root_path
    click_on 'Estadias Ativas'
    click_on 'Gerenciar Reserva'
    click_on 'Registrar Check-out'

    expect(page).to have_content "Check-out da Reserva #{booking.code}" 
    expect(page).to have_content "Horário do Check-in: #{45.hours.ago.strftime('%d/%m/%Y %H:%M')}"
    expect(page).to have_content "Valor final até a data atual: R$ 200,00"
    expect(page).to have_content "Método de pagamento: #{payment_method.method}"
    expect(page).to have_button 'Finalizar Check-out'
  end

  it 'after end date and price is adjusted' do
    host = Host.create!(name: 'Ana', lastname: 'Silva', email: 'ana@email.com', password: 'senha123')
    payment_method = PaymentMethod.create!(method: 'Débito')
    guesthouse = Guesthouse.create!(host: host, description: 'Local aconchegante para momentos especiais', brand_name: 'Pousada Encanto',
                                corporate_name: 'Encanto Hospedagens Eireli', registration_number: '12.345.678/0001-90', 
                                phone_number: '11 98765-4321', email: 'contato@pousadaencanto.com.br', address: 'Rua das Flores, 123', 
                                neighborhood: 'Bela Vista', city: 'São Paulo', state:'SP', postal_code: '98765-43', 
                                payment_method_id: payment_method.id, pet_friendly:  'Aceita animais de estimação', 
                                usage_policy: 'Proibido fumar nas dependências.', checkin: '15:00', checkout: '11:00', status: 1)
    room = Room.create!(guesthouse: guesthouse, name: 'Harmonia', description: 'Espaço agradável para relaxar.', size: 20, max_people: '3',
                    price: 100.0, bathroom: 'Compartilhado', balcony: 'Possui', tv: 'Não possui', wardrobe: 'Possui',
                    safe: 'Não possui', accessibility: 'Não acessível para cadeiras de rodas', status: 1)
    guest = Guest.create!(name: 'Guilherme', lastname: 'Oliveira', email: 'guilherme@email.com', password: 'senha1234')
    booking = Booking.create!(guest: guest, host: host, start_date: 2.days.ago, end_date: 1.day.ago, number_guests: '3', 
                              room: room, prices: 100.0, status: :ongoing, checkin_time: 2.days.ago)

    login_as(host, :scope => :host)
    travel_to 1.day.ago.end_of_day do
      visit root_path
      click_on 'Estadias Ativas'
      click_on 'Gerenciar Reserva'
      click_on 'Registrar Check-out'
    end
 
    expect(page).to have_content "Check-out da Reserva #{booking.code}" 
    expect(page).to have_content "Horário do Check-in: #{2.days.ago.strftime('%d/%m/%Y %H:%M')}"
    expect(page).to have_content "Valor final até a data atual: R$ 200,00"
    expect(page).to have_content "Método de pagamento: #{payment_method.method}"
    expect(page).to have_button 'Finalizar Check-out'
  end

  it 'but check-in was not done previously' do
    host = Host.create!(name: 'Ana', lastname: 'Silva', email: 'ana@email.com', password: 'senha123')
    payment_method = PaymentMethod.create!(method: 'Débito')
    guesthouse = Guesthouse.create!(host: host, description: 'Local aconchegante para momentos especiais', brand_name: 'Pousada Encanto',
                                corporate_name: 'Encanto Hospedagens Eireli', registration_number: '12.345.678/0001-90', 
                                phone_number: '11 98765-4321', email: 'contato@pousadaencanto.com.br', address: 'Rua das Flores, 123', 
                                neighborhood: 'Bela Vista', city: 'São Paulo', state:'SP', postal_code: '98765-43', 
                                payment_method_id: payment_method.id, pet_friendly:  'Aceita animais de estimação', 
                                usage_policy: 'Proibido fumar nas dependências.', checkin: '15:00', checkout: '11:00', status: 1)
    room = Room.create!(guesthouse: guesthouse, name: 'Harmonia', description: 'Espaço agradável para relaxar.', size: 20, max_people: '3',
                    price: 100.0, bathroom: 'Compartilhado', balcony: 'Possui', tv: 'Não possui', wardrobe: 'Possui',
                    safe: 'Não possui', accessibility: 'Não acessível para cadeiras de rodas', status: 1)
    guest = Guest.create!(name: 'Guilherme', lastname: 'Oliveira', email: 'guilherme@email.com', password: 'senha1234')
    booking = Booking.create!(guest: guest, host: host, start_date: 2.days.ago, end_date: 2.days.from_now, number_guests: '3', 
                              room: room, prices: 400.0, status: :booked)

    login_as(host, :scope => :host)
    visit checkout_register_guesthouse_room_booking_path(guesthouse.id, room.id, booking.id)
    
    expect(page).not_to have_button 'Finalizar Check-out'
  end
end
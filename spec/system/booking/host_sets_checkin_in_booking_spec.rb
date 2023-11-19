require 'rails_helper'

describe 'Host sets checkin in booking' do
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
                    price: 150.0, bathroom: 'Compartilhado', balcony: 'Possui', tv: 'Não possui', wardrobe: 'Possui',
                    safe: 'Não possui', accessibility: 'Não acessível para cadeiras de rodas', status: 1)
    guest = Guest.create!(name: 'Guilherme', lastname: 'Oliveira', email: 'guilherme@email.com', password: 'senha1234')
    booking = Booking.create!(guest: guest, host: host, start_date: Date.today, end_date: 5.days.from_now, number_guests: '3', 
                              room: room, prices: 180.0, status: :booked)

    login_as(host, :scope => :host)
    visit root_path    
    click_on 'Reservas'
    click_on 'Gerenciar Reserva'
    click_on 'Registrar Check-in'

    expect(page).to  have_content "Reserva #{booking.code} em andamento!" 
    expect(current_path).to eq host_control_guesthouse_room_booking_path(guesthouse.id, room.id, booking.id)
  end

  it 'and sees details' do
    host = Host.create!(name: 'Ana', lastname: 'Silva', email: 'ana@email.com', password: 'senha123')
    payment_method = PaymentMethod.create!(method: 'Débito')
    guesthouse = Guesthouse.create!(host: host, description: 'Local aconchegante para momentos especiais', brand_name: 'Pousada Encanto',
                                corporate_name: 'Encanto Hospedagens Eireli', registration_number: '12.345.678/0001-90', 
                                phone_number: '11 98765-4321', email: 'contato@pousadaencanto.com.br', address: 'Rua das Flores, 123', 
                                neighborhood: 'Bela Vista', city: 'São Paulo', state:'SP', postal_code: '98765-43', 
                                payment_method_id: payment_method.id, pet_friendly:  'Aceita animais de estimação', 
                                usage_policy: 'Proibido fumar nas dependências.', checkin: '15:00', checkout: '11:00', status: 1)
    room = Room.create!(guesthouse: guesthouse, name: 'Harmonia', description: 'Espaço agradável para relaxar.', size: 20, max_people: '3',
                    price: 150.0, bathroom: 'Compartilhado', balcony: 'Possui', tv: 'Não possui', wardrobe: 'Possui',
                    safe: 'Não possui', accessibility: 'Não acessível para cadeiras de rodas', status: 1)
    guest = Guest.create!(name: 'Guilherme', lastname: 'Oliveira', email: 'guilherme@email.com', password: 'senha1234')
    booking = Booking.create!(guest: guest, host: host, start_date: Date.today, end_date: 5.days.from_now, number_guests: '3', 
                              room: room, prices: 180.0, status: :ongoing, checkin_time: DateTime.now)

    login_as(host, :scope => :host)
    visit root_path
    click_on 'Estadias Ativas'

    expect(page).to have_content 'Estadias Ativas' 
    expect(page).to have_content "Reservas em #{guesthouse.brand_name}"
    expect(page).to have_content "Reserva #{booking.code}"
    expect(page).to have_content "Quarto #{room.name}"
    expect(page).to have_content "Nome: #{guest.name}"
    start_date = I18n.localize Date.today.to_date
    end_date = I18n.localize 5.days.from_now.to_date
    expect(page).to have_content "Entrada: #{start_date} - 15:00"
    expect(page).to have_content "Saída: #{end_date} - 11:00"
    expect(page).to have_content "Valor total: R$ #{booking.prices}"
    expect(page).to have_content "Método de pagamento: #{payment_method.method}"
    expect(page).to have_content "Data e horário do checkin: #{I18n.l((booking.checkin_time - 3.hours), format: '%d/%m/%Y %H:%M:%S')}"
    expect(page).to have_button 'Gerenciar Reserva'
  end
end
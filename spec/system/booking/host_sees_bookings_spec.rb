require 'rails_helper'

describe 'Host sees bookings of your own guesthouse' do
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
    booking = Booking.create!(guest: guest, host: host, start_date: 30.days.from_now, end_date: 35.days.from_now, number_guests: '3', 
                              room: room, prices: 180.0, status: 0)

    login_as(host, :scope => :host)
    visit root_path    

    expect(page).to have_link 'Reservas'
  end

  it 'and sees several bookings' do
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
    guest1 = Guest.create!(name: 'Maria', lastname: 'Silva', email: 'maria@email.com', password: 'senha1234')
    guest2 = Guest.create!(name: 'João', lastname: 'Pereira', email: 'joao@email.com', password: 'senha5678')
    guest3 = Guest.create!(name: 'Sophia', lastname: 'Oliveira', email: 'sophia@email.com', password: 'senha9876')
    booking1 = Booking.create!(guest: guest1, host: host, start_date: 25.days.from_now, end_date: 28.days.from_now, 
                              number_guests: '2', room: room, prices: 450.0, status: 0)
    booking2 = Booking.create!(guest: guest2, host: host, start_date: 20.days.from_now, end_date: 23.days.from_now, 
                              number_guests: '1', room: room, prices: 450.0, status: 0)
    booking3 = Booking.create!(guest: guest3, host: host, start_date: 40.days.from_now, end_date: 45.days.from_now, 
                              number_guests: '3', room: room, prices: 750.0, status: 0)

    login_as(host, :scope => :host)
    visit root_path    
    click_on 'Reservas'
    
    expect(page).to have_content "Reservas em #{guesthouse.brand_name}"
    expect(page).to have_content "Quarto #{room.name}"
    expect(page).to have_content "Nome: #{guest1.name}"
    expect(page).to have_content "Nome: #{guest2.name}"
    expect(page).to have_content "Nome: #{guest3.name}"
    start_date1 = I18n.localize 25.days.from_now.to_date
    end_date1 = I18n.localize 28.days.from_now.to_date
    expect(page).to have_content "Entrada: #{start_date1} - 15:00"
    expect(page).to have_content "Saída: #{end_date1} - 11:00"
    start_date2 = I18n.localize 20.days.from_now.to_date
    end_date2 = I18n.localize 23.days.from_now.to_date
    expect(page).to have_content "Entrada: #{start_date2} - 15:00"
    expect(page).to have_content "Saída: #{end_date2} - 11:00"
    start_date3 = I18n.localize 40.days.from_now.to_date
    end_date3 = I18n.localize 45.days.from_now.to_date
    expect(page).to have_content "Entrada: #{start_date3} - 15:00"
    expect(page).to have_content "Saída: #{end_date3} - 11:00"
    expect(page).to have_content "Número de hóspedes: #{booking1.number_guests}"
    expect(page).to have_content "Número de hóspedes: #{booking2.number_guests}"
    expect(page).to have_content "Número de hóspedes: #{booking3.number_guests}"
    expect(page).to have_content "Valor total: R$ #{booking1.prices}"
    expect(page).to have_content "Valor total: R$ #{booking2.prices}"
    expect(page).to have_content "Valor total: R$ #{booking3.prices}"
    expect(page).to have_button 'Gerenciar Reserva'
  end
end
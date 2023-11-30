require 'rails_helper'

describe 'Guest cancels booking' do
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
    booking = Booking.create!(guest: guest, host: host, start_date: 40.days.from_now, end_date: 45.days.from_now, number_guests: '2', room: room, prices: 200.0, status: 0)

    login_as(guest, :scope => :guest)  
    visit root_path
    click_on 'Minhas Reservas'
    click_on 'Cancelar Reserva'

    expect(page).to have_content "Reserva #{booking.code} cancelada com sucesso!"
    expect(page).not_to have_content 'Pousada Serenidade'
    expect(page).not_to have_content "Entrada: #{booking.start_date} - #{guesthouse.checkin}"
    expect(page).not_to have_content "Saída: #{booking.end_date} - #{guesthouse.checkout}"
    expect(page).not_to have_content "Valor total: R$ #{booking.prices}"
  end

  it 'up to 7 days before check-in' do
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
    booking = Booking.create!(guest: guest, host: host, start_date: 4.days.from_now, end_date: 8.days.from_now, number_guests: '2', room: room, prices: 200.0, status: 0)

    login_as(guest, :scope => :guest)  
    visit root_path
    click_on 'Minhas Reservas'

    expect(page).not_to have_button 'Cancelar Reserva'
  end
end
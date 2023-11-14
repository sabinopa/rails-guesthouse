require 'rails_helper'

describe 'Guest starts booking a room' do
  it 'successfully' do
    host = Host.create!(name: 'Paulo', lastname: 'Xavier', email: 'paulo@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'Crédito até 3x')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
    room = Room.create!(guesthouse: guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, max_people: '4', 
                        price: 220.00, bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                        accessibility: 'Acessível para pessoas com deficiência', status: 1)
    custom_price = CustomPrice.create!(room: room, start_date: '10/12/2023', end_date: '15/12/2023', price: 300.00)
    guest = Guest.create!(name: 'Leticia', lastname: 'Souza', email: 'leticia@email.com', password: '12345678')


    login_as(guest, :scope => :guest)  
    visit root_path
    click_on 'Pousada Serenidade'
    click_on 'Tranquilidade - 4 pessoas'
    click_on 'Reservar'

    fill_in 'Início', with: 5.days.from_now
    fill_in 'Fim', with: 15.days.from_now
    fill_in 'Número de hóspedes', with: '3'
    click_on 'Verificar'

    expect(page).to have_content 'Confirmar dados da reserva'


  end
end
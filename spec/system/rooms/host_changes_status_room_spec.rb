require 'rails_helper'

describe 'Host change status of his room' do
  it 'and turns room inactive' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'PIX')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
    room = Room.create!(guesthouse: guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, max_people: '4', 
                                    price: '220,00', bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                                    accessibility: 'Acessível para pessoas com deficiência', status: 1)

    login_as(host, :scope => :host)
    visit root_path
    click_on 'Ver quartos'
    click_on 'Tranquilidade - 4 pessoas'
    click_button 'Tornar quarto indisponível'

    expect(current_path).to eq guesthouse_room_path(guesthouse.id, room.id)
    expect(page).to have_content "Quarto inativo!"
    expect(page).to have_content 'Status: Indisponível'
  end

  it 'and turns room active' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'PIX')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
    room = Room.create!(guesthouse: guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, max_people: '4', 
                                    price: '220,00', bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                                    accessibility: 'Acessível para pessoas com deficiência', status: 0)

    login_as(host, :scope => :host)
    visit root_path
    click_on 'Ver quartos'
    click_on 'Tranquilidade - 4 pessoas'
    click_button 'Tornar quarto disponível'

    expect(current_path).to eq guesthouse_room_path(guesthouse.id, room.id)
    expect(page).to have_content "Quarto ativo!"
    expect(page).to have_content 'Status: Disponível'
  end
end
require 'rails_helper'

describe 'Host edits room' do 
  it 'must be authenticated' do
    host = Host.create!(name: 'Paulo', lastname: 'Xavier', email: 'paulo@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'Crédito até 3x')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
    room = Room.create!(guesthouse: guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, max_people: '4', 
                        price: '220,00', bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                        accessibility: 'Acessível para pessoas com deficiência', status: 'Disponível')


    visit edit_guesthouse_room_path(guesthouse.id, room.id)
    expect(current_path).to eq new_host_session_path
  end

  it 'succesfully' do
    host = Host.create!(name: 'Paulo', lastname: 'Xavier', email: 'paulo@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'Crédito até 3x')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
    room = Room.create!(guesthouse: guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, max_people: '4', 
                        price: '220,00', bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                        accessibility: 'Acessível para pessoas com deficiência', status: 'Disponível')

    login_as(host, :scope => :host)  
    visit root_path
    click_on 'Ver quartos'
    click_on 'Tranquilidade - 4 pessoas'
    click_on 'Editar'

    fill_in 'Nome', with: 'Ensolarado'
    fill_in 'Descrição', with: 'Sol o dia todo!'
    fill_in 'Dimensão', with: '15 m2'
    fill_in 'Capacidade', with: '5 pessoas'
    fill_in 'Preço', with: '350.0'
    check 'Varanda'
    uncheck 'Televisão'
    click_on 'Salvar'
      
    expect(page).to have_content 'Atualizado com sucesso!'
    expect(page).to have_content 'Quarto Ensolarado'
    expect(page).to have_content 'Sol o dia todo!'
    expect(page).to have_content 'Dimensão: 15 m2'
    expect(page).to have_content 'Capacidade: 5 pessoas'
    expect(page).to have_content 'Preço: R$ 350.0'
    expect(page).to have_content 'Varanda: Possui'
    expect(page).to have_content 'Televisão: Não possui'
    expect(page).to have_content 'Disponibilidade para reservas: Disponível'
  end

  it 'must be the owner' do
    host = Host.create!(name: 'Paulo', lastname: 'Xavier', email: 'paulo@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'Crédito até 3x')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
    room = Room.create!(guesthouse: guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, max_people: '4', 
                        price: '220,00', bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                        accessibility: 'Acessível para pessoas com deficiência', status: 'Disponível')
    second_host = Host.create!(name: 'Hugo', lastname: 'Silveira', email: 'hugo@email.com', password: '12345678')
    second_guesthouse = Guesthouse.create!(host: second_host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                                        corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                                        email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                                        city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                                        usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)

     login_as(second_host, :scope => :host)  
     visit edit_guesthouse_room_path(guesthouse.id, room.id)

     expect(page).to have_content 'Ops, você não é o anfitrião dessa pousada.'
     expect(current_path).to eq(root_path)
  end

  it 'with incomplete data' do
    host = Host.create!(name: 'Paulo', lastname: 'Xavier', email: 'paulo@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'Crédito até 3x')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
    room = Room.create!(guesthouse: guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, max_people: '4', 
                        price: '220,00', bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                        accessibility: 'Acessível para pessoas com deficiência', status: 'Disponível')


    login_as(host, :scope => :host)  
    visit root_path
    click_on 'Ver quartos'
    click_on 'Tranquilidade - 4 pessoas'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Dimensão', with: ''
    fill_in 'Capacidade', with: ''
    fill_in 'Preço', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Dimensão não pode ficar em branco'
    expect(page).to have_content 'Capacidade não pode ficar em branco'
    expect(page).to have_content 'Preço não pode ficar em branco'
  end

  it 'and turn room inactive' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'PIX')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
    room = Room.create!(guesthouse: guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, max_people: '4', 
                                    price: '220,00', bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                                    accessibility: 'Acessível para pessoas com deficiência', status: 'Disponível')

    login_as(host, :scope => :host)
    visit root_path
    click_on 'Ver quartos'
    click_on 'Tranquilidade - 4 pessoas'
    click_on 'Editar'
    uncheck 'Disponibilidade para reservas'
    click_on 'Salvar'

    expect(current_path).to eq guesthouse_room_path(guesthouse.id, room.id)
    expect(page).to have_content "#{room.name}: Atualizado com sucesso!"
    expect(page).to have_content 'Indisponível'
  end
end
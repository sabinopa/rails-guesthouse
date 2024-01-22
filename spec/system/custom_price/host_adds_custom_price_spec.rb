require 'rails_helper'

describe 'Host adds custom price to a room' do 
  it 'from details room page' do
    host = Host.create!(name: 'Paulo', lastname: 'Xavier', email: 'paulo@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'Crédito até 3x')
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
    click_on 'Adicionar preços personalizados'

    expect(current_path).to eq new_guesthouse_room_custom_price_path(guesthouse.id, room.id)
    expect(page).to have_content 'Personalizar preço no período:'
    expect(page).to have_field 'Início'
    expect(page).to have_field 'Fim'
    expect(page).to have_field 'Preço no período'
    expect(page).to have_button 'Salvar'
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
                        price: 220.00, bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                        accessibility: 'Acessível para pessoas com deficiência', status: 1)
  
    login_as(host, :scope => :host)  
    visit root_path
    click_on 'Ver quartos'
    click_on 'Tranquilidade - 4 pessoas'
    click_on 'Adicionar preços personalizados'
    fill_in 'Início', with: 8.days.from_now
    fill_in 'Fim', with: 12.days.from_now
    fill_in 'Preço no período', with: 350.00
    click_on 'Salvar'

    expect(current_path).to eq guesthouse_room_path(guesthouse.id, room.id)
    expect(page).to have_content 'Novo preço cadastrado com sucesso!'
    start_date = I18n.localize 8.days.from_now.to_date
    end_date = I18n.localize 12.days.from_now.to_date
    expect(page).to have_content "Início: #{start_date}"
    expect(page).to have_content "Fim: #{end_date}"
    expect(page).to have_content 'Preço personalizado: R$350.0'
    expect(page).to have_link 'Adicionar preços personalizados'
  end

  it 'and must be authenticated' do
    host = Host.create!(name: 'Paulo', lastname: 'Xavier', email: 'paulo@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'Crédito até 3x')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
    room = Room.create!(guesthouse: guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, max_people: '4', 
                        price: '220,00', bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                        accessibility: 'Acessível para pessoas com deficiência', status: 1)


    visit new_guesthouse_room_custom_price_path(guesthouse.id, room.id)
    expect(current_path).to eq new_host_session_path
  end

  it 'must be the host' do
    first_host = Host.create!(name: 'Paulo', lastname: 'Xavier', email: 'paulo@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'Crédito até 3x')
    first_guesthouse = Guesthouse.create!(host: first_host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
    first_room = Room.create!(guesthouse: first_guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, max_people: '4', 
                        price: '220,00', bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                        accessibility: 'Acessível para pessoas com deficiência', status: 1)
    second_host = Host.create!(name: 'Hugo', lastname: 'Silveira', email: 'hugo@email.com', password: '12345678')


     login_as(second_host, :scope => :host)  
     visit new_guesthouse_room_custom_price_path(first_guesthouse.id, first_room.id)

     expect(page).to have_content 'Ops, você não é o anfitrião dessa pousada.'
     expect(current_path).to eq root_path
  end

  it 'with incomplete datas' do
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
  
    login_as(host, :scope => :host)  
    visit root_path
    click_on 'Ver quartos'
    click_on 'Tranquilidade - 4 pessoas'
    click_on 'Adicionar preços personalizados'
    fill_in 'Início', with: ''
    fill_in 'Fim', with: ''
    fill_in 'Preço no período', with: ''
    click_on 'Salvar'

    expect(current_path).not_to eq guesthouse_room_path(guesthouse.id, room.id)
    expect(page).to have_content 'Verifique os erros abaixo:'   
    expect(page).to have_content 'Início não pode ficar em branco'
    expect(page).to have_content 'Fim não pode ficar em branco'
    expect(page).to have_content 'Preço no período não pode ficar em branco'
  end

  it 'fill in start date with past date' do 
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
  
    login_as(host, :scope => :host)  
    visit root_path
    click_on 'Ver quartos'
    click_on 'Tranquilidade - 4 pessoas'
    click_on 'Adicionar preços personalizados'
    fill_in 'Início', with: 10.days.ago
    fill_in 'Fim', with: 10.days.from_now
    fill_in 'Preço no período', with: 350.00
    click_on 'Salvar'

    expect(current_path).not_to eq guesthouse_room_path(guesthouse.id, room.id)
    expect(page).to have_content 'Verifique os erros abaixo:'   
    expect(page).to have_content 'Ops, a data de início não pode ser passada'
  end

  it 'fill in end date with a date preceding the start date' do 
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
  
    login_as(host, :scope => :host)  
    visit root_path
    click_on 'Ver quartos'
    click_on 'Tranquilidade - 4 pessoas'
    click_on 'Adicionar preços personalizados'
    fill_in 'Início', with: 15.days.from_now
    fill_in 'Fim', with: 8.days.from_now
    fill_in 'Preço no período', with: 350.00
    click_on 'Salvar'

    expect(current_path).not_to eq guesthouse_room_path(guesthouse.id, room.id)
    expect(page).to have_content 'Verifique os erros abaixo:'   
    expect(page).to have_content 'Ops, a data de início deve ser anterior a data final.'
  end

  it 'and do not overlap dates' do
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
    
    custom_price = CustomPrice.create!(room: room, start_date: 8.days.from_now, end_date: 20.days.from_now, price: 300.00)
    
    login_as(host, :scope => :host)  
    visit root_path
    click_on 'Ver quartos'
    click_on 'Tranquilidade - 4 pessoas'
    click_on 'Adicionar preços personalizados'
    fill_in 'Início', with: 10.days.from_now
    fill_in 'Fim', with: 15.days.from_now
    fill_in 'Preço no período', with: 350.00
    click_on 'Salvar'

    expect(current_path).not_to eq guesthouse_room_path(guesthouse.id, room.id)
    expect(page).to have_content 'Verifique os erros abaixo:'   
    expect(page).to have_content 'Ops, você já tem um preço especial cadastrado nessa data.'
  end

  it 'to a specific room' do
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
    
    custom_price = CustomPrice.create!(room: room, start_date: 8.days.from_now, end_date: 20.days.from_now, price: 300.00)

    second_room = Room.create!(guesthouse: guesthouse, name: 'Calmaria', description: 'Decoração adorável.', size: 10, 
                              max_people: '2', price: '180,00', bathroom: false, balcony: false, tv: true, wardrobe: true, 
                              safe: true, accessibility: true, status: 1) 

    login_as(host, :scope => :host)  
    visit root_path
    click_on 'Ver quartos'
    click_on 'Calmaria - 2 pessoas'
    click_on 'Adicionar preços personalizados'
    fill_in 'Início', with: 8.days.from_now
    fill_in 'Fim', with: 13.days.from_now
    fill_in 'Preço no período', with: 400.00
    click_on 'Salvar'

    expect(current_path).to eq guesthouse_room_path(guesthouse.id, second_room.id)
    expect(page).to have_content 'Novo preço cadastrado com sucesso!'
    start_date = I18n.localize 8.days.from_now.to_date
    end_date = I18n.localize 13.days.from_now.to_date
    expect(page).to have_content "Início: #{start_date}"
    expect(page).to have_content "Fim: #{end_date}"
    expect(page).to have_content 'Preço personalizado: R$400.0'
    expect(page).to have_link 'Adicionar preços personalizados'
  end
end
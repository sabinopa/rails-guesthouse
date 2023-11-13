require 'rails_helper'

describe 'Visitor search for a guesthouse' do 
  it 'from the menu' do
    visit root_path
  
    within('nav') do
      expect(page).to have_field 'Busque aqui...'
      expect(page).to have_button 'Buscar Pousada'
    end
  end

  it 'and finds guesthouse by name' do
    host = Host.create!(name: 'Bruna', lastname: 'Almeida', email: 'bruna@email.com', password: '12345678')
    payment_method = PaymentMethod.create!(method: 'Dinheiro')
    guesthouse = Guesthouse.create!(host: host,  description: 'Um refúgio à beira-mar com vista panorâmica', brand_name: 'Pousada Maré Alta',
                                          corporate_name: 'Maré Alta Hospedagens Ltda', registration_number: '11.111.111/0001-11', phone_number: '55 55555-5555',
                                          email: 'contato@pousadamarealta.com', address: 'Avenida Beira Mar, 123', neighborhood: 'Costa Brilhante',
                                          city: 'Florianópolis', state: 'SC', postal_code: '54321-90', payment_method_id: payment_method.id, 
                                          pet_friendly: 'Aceita animais de estimação', usage_policy: 'Proibido fumar nas dependências.',
                                          checkin: '15:00', checkout: '11:00', status: 1)

    visit root_path
    fill_in 'Busque aqui...', with: guesthouse.brand_name
    click_on 'Buscar Pousada'

    expect(page).to have_content "Resultados da busca por: #{guesthouse.brand_name}"
    expect(page).to have_content '1 pousada encontrada'
    expect(page).to have_link 'Pousada Maré Alta'
  end

  it 'and finds several guesthouses' do
    host = Host.create!(name: 'Bruna', lastname: 'Almeida', email: 'bruna@email.com', password: '12345678')
    payment_method = PaymentMethod.create!(method: 'Dinheiro')
    guesthouse = Guesthouse.create!(host: host,  description: 'Um refúgio à beira-mar com vista panorâmica', brand_name: 'Pousada Serenidade do Verão',
                                          corporate_name: 'Verão Hospedagens Ltda', registration_number: '11.111.111/0001-11', phone_number: '55 55555-5555',
                                          email: 'contato@pousadamarealta.com', address: 'Avenida Beira Mar, 123', neighborhood: 'Costa Brilhante',
                                          city: 'Florianópolis', state: 'SC', postal_code: '54321-90', payment_method_id: payment_method.id, 
                                          pet_friendly: 'Aceita animais de estimação', usage_policy: 'Proibido fumar nas dependências.',
                                          checkin: '15:00', checkout: '11:00', status: 1)
    second_host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    second_guesthouse = Guesthouse.create!(host: second_host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade da Alma', 
                                          corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                          email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                          city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                          usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
    visit root_path                                  
    fill_in 'Busque aqui...', with: 'Serenidade'
    click_on 'Buscar Pousada'

    expect(page).to have_content '2 pousadas encontradas'
    expect(page).to have_content 'Pousada Serenidade da Alma'
    expect(page).to have_content 'Pousada Serenidade do Verão'
    expect(page).to have_content 'Resultados da busca por: Serenidade'
    expect(page).not_to have_content 'Nenhuma pousada encontrada!'
  end

  it 'by cities' do
    host = Host.create!(name: 'Bruna', lastname: 'Almeida', email: 'bruna@email.com', password: '12345678')
    payment_method = PaymentMethod.create!(method: 'Dinheiro')
    guesthouse = Guesthouse.create!(host: host,  description: 'Um refúgio à beira-mar com vista panorâmica', brand_name: 'Pousada Serenidade do Verão',
                                          corporate_name: 'Verão Hospedagens Ltda', registration_number: '11.111.111/0001-11', phone_number: '55 55555-5555',
                                          email: 'contato@pousadamarealta.com', address: 'Avenida Beira Mar, 123', neighborhood: 'Costa Brilhante',
                                          city: 'Florianópolis', state: 'SC', postal_code: '54321-90', payment_method_id: payment_method.id, 
                                          pet_friendly: 'Aceita animais de estimação', usage_policy: 'Proibido fumar nas dependências.',
                                          checkin: '15:00', checkout: '11:00', status: 1)
   
    visit root_path                                      
    fill_in 'Busque aqui...', with: 'Florianópolis'
    click_on 'Buscar Pousada'

    expect(page).to have_content '1 pousada encontrada'
    expect(page).to have_link 'Pousada Serenidade do Verão'
    expect(page).to have_content 'Resultados da busca por: Florianópolis'
    expect(page).not_to have_content 'Nenhuma pousada encontrada!'
  end

  it 'by neighborhood' do
    host = Host.create!(name: 'Bruna', lastname: 'Almeida', email: 'bruna@email.com', password: '12345678')
    payment_method = PaymentMethod.create!(method: 'Dinheiro')
    guesthouse = Guesthouse.create!(host: host,  description: 'Um refúgio à beira-mar com vista panorâmica', brand_name: 'Pousada Serenidade do Verão',
                                          corporate_name: 'Verão Hospedagens Ltda', registration_number: '11.111.111/0001-11', phone_number: '55 55555-5555',
                                          email: 'contato@pousadamarealta.com', address: 'Avenida Beira Mar, 123', neighborhood: 'Costa Brilhante',
                                          city: 'Florianópolis', state: 'SC', postal_code: '54321-90', payment_method_id: payment_method.id, 
                                          pet_friendly: 'Aceita animais de estimação', usage_policy: 'Proibido fumar nas dependências.',
                                          checkin: '15:00', checkout: '11:00', status: 1)
   
    visit root_path                                      
    fill_in 'Busque aqui...', with: 'Costa Brilhante'
    click_on 'Buscar Pousada'

    expect(page).to have_content '1 pousada encontrada'
    expect(page).to have_link 'Pousada Serenidade do Verão'
    expect(page).to have_content 'Resultados da busca por: Costa Brilhante'
    expect(page).not_to have_content 'Nenhuma pousada encontrada!'
  end
end
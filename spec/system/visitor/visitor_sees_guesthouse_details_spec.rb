require 'rails_helper'

describe 'Visitor sees guesthouse' do
  it 'from home page' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    second_host = Host.create!(name: 'Bruna', lastname: 'Almeida', email: 'bruna@email.com', password: '12345678')
    payment_method = PaymentMethod.create!(method: 'Crédito 3x')
    Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                      corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                      email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                      city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                      usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)

    Guesthouse.create!(host: second_host, description: 'Um refúgio à beira-mar com vista panorâmica', brand_name: 'Pousada Maré Alta',
                      corporate_name: 'Maré Alta Hospedagens Ltda', registration_number: '11.111.111/0001-11', phone_number: '55 55555-5555',
                      email: 'contato@pousadamarealta.com', address: 'Avenida Beira Mar, 123', neighborhood: 'Costa Brilhante',
                      city: 'Florianópolis', state: 'SC', postal_code: '54321-90', payment_method_id: payment_method.id, 
                      pet_friendly: 'Aceita animais de estimação', usage_policy: 'Proibido fumar nas dependências.',
                      checkin: '15:00', checkout: '11:00', status: 1)

    visit root_path
    click_on 'Pousada Maré Alta - Florianópolis'

    expect(page).to have_content 'Pousada Maré Alta'
    expect(page).to have_content 'Um refúgio à beira-mar com vista panorâmica'
    expect(page).to have_content 'Contato: 55 55555-5555'
    expect(page).to have_content 'E-mail: contato@pousadamarealta.com'
    expect(page).to have_content 'Endereço: Avenida Beira Mar, 123 - Costa Brilhante, Florianópolis - SC - 54321-90'
    expect(page).to have_content 'Animais de estimação: Aceita'
    expect(page).to have_content 'Regras de uso: Proibido fumar nas dependências.'
    expect(page).to have_content 'Entrada: 15:00'
    expect(page).to have_content 'Saída: 11:00'
    expect(page).to have_content 'Status: Disponível'
  end

  it 'and return to home page' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    second_host = Host.create!(name: 'Bruna', lastname: 'Almeida', email: 'bruna@email.com', password: '12345678')
    payment_method = PaymentMethod.create!(method: 'Crédito 3x')
    Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                      corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                      email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                      city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                      usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)

    Guesthouse.create!(host: second_host, description: 'Um refúgio à beira-mar com vista panorâmica', brand_name: 'Pousada Maré Alta',
                      corporate_name: 'Maré Alta Hospedagens Ltda', registration_number: '11.111.111/0001-11', phone_number: '55 55555-5555',
                      email: 'contato@pousadamarealta.com', address: 'Avenida Beira Mar, 123', neighborhood: 'Costa Brilhante',
                      city: 'Florianópolis', state: 'SC', postal_code: '54321-90', payment_method_id: payment_method.id, 
                      pet_friendly: 'Aceita animais de estimação', usage_policy: 'Proibido fumar nas dependências.',
                      checkin: '15:00', checkout: '11:00', status: 1)

    visit root_path
    click_on 'Pousada Maré Alta - Florianópolis'
    click_on 'Voltar'

    expect(current_path).to eq root_path
    
  end
end
require 'rails_helper'

describe 'Visitor views homepage' do 
  it 'and see the application name' do
    visit root_path

    expect(page).to have_content 'Pousadaria'
    expect(page).to have_link 'Pousadaria', href: root_path
  end

  it 'and see registered guesthouses' do
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

    expect(page). not_to have_content 'Não existem pousadas cadastrados.'
    expect(page).to have_content 'Pousada Serenidade - Maceió'
    expect(page).to have_content 'Pousada Maré Alta - Florianópolis'
    expect(page).to have_content 'Pousadas recentes'
    expect(page).to have_content 'Demais pousadas'
  end

  it 'and see cities availables' do
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

    expect(page). not_to have_content 'Não existem pousadas cadastrados.' 
    expect(page).to have_content 'Maceió' 
    expect(page).to have_content 'Florianópolis' 
  end

  it 'there is no registered guesthouses' do 
    visit root_path

    expect(page).to have_content 'Não existem pousadas cadastrados' 
  end
end
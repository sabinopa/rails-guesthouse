require 'rails_helper'

describe 'Host edits guesthouse' do
  it 'must be logged in' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'PIX')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                  corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                  email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                  city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                  usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
    
    patch guesthouse_path(guesthouse.id), params: { guesthouse: { brand_name: 'Pousada Amanhecer'}}
    guesthouse.reload

    expect(response).to redirect_to new_host_session_path 
    expect(guesthouse.brand_name).to eq 'Pousada Serenidade'
  end

  it 'must be the owner' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'PIX')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                  corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                  email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                  city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                  usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00')

    second_host = Host.create!(name: 'Bruna', lastname: 'Almeida', email: 'bruna@email.com', password: '12345678')
    second_guesthouse = Guesthouse.create!(host: second_host,  description: 'Um refúgio à beira-mar com vista panorâmica', brand_name: 'Pousada Maré Alta',
                                          corporate_name: 'Maré Alta Hospedagens Ltda', registration_number: '11.111.111/0001-11', phone_number: '55 55555-5555',
                                          email: 'contato@pousadamarealta.com', address: 'Avenida Beira Mar, 123', neighborhood: 'Costa Brilhante',
                                          city: 'Florianópolis', state: 'SC', postal_code: '54321-90', payment_method_id: payment_method.id, 
                                          pet_friendly: 'Aceita animais de estimação', usage_policy: 'Proibido fumar nas dependências.',
                                          checkin: '15:00', checkout: '11:00', status: :active)
    login_as(second_host, :scope => :host)                                      
    patch guesthouse_path(guesthouse.id), params: { guesthouse: { brand_name: 'Pousada Amanhecer'}}
                                                            
    expect(response).to redirect_to root_path
    expect(guesthouse.brand_name).to eq 'Pousada Serenidade'
  end
end
require 'rails_helper'

describe 'Visitor sees rooms details' do
  it 'from home page' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'Crédito 3x')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                      corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                      email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                      city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                      usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
    room = Room.create!(guesthouse: guesthouse, name: 'Elegância', description: 'Um quarto sofisticado para uma estadia luxuosa.', size: 25, 
                      max_people: '2', price: 350.00, air_conditioner: false, bathroom: true, balcony: true, tv: true, wardrobe: true, safe: true, 
                      accessibility: false, status: 1)

    visit root_path
    click_on 'Pousada Serenidade - Maceió'
    click_on 'Elegância - 2 pessoas'

    expect(page).to have_content 'Quarto Elegância'
    expect(page).to have_content 'Um quarto sofisticado para uma estadia luxuosa.'
    expect(page).to have_content 'Dimensão: 25 m2'
    expect(page).to have_content 'Capacidade: 2 pessoas'
    expect(page).to have_content 'Preço: R$ 350.0'
    expect(page).to have_content 'Ar Condicionado: Não possui'
    expect(page).to have_content 'Banheiro: Particular'
    expect(page).to have_content 'Varanda: Possui'
    expect(page).to have_content 'Televisão: Possui'
    expect(page).to have_content 'Armário: Possui'
    expect(page).to have_content 'Cofre: Possui'
    expect(page).to have_content 'Acessibilidade: Não acessível'
    expect(page).to have_content 'Status: Disponível'
  end

  it 'and return to home page' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'Crédito 3x')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                      corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                      email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                      city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                      usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
    room = Room.create!(guesthouse: guesthouse, name: 'Elegância', description: 'Um quarto sofisticado para uma estadia luxuosa.', size: 25, 
                      max_people: '2', price: 350.00, air_conditioner: false, bathroom: true, balcony: true, tv: true, wardrobe: true, safe: true, 
                      accessibility: false, status: 1)

    visit root_path
    click_on 'Pousada Serenidade - Maceió'
    click_on 'Elegância - 2 pessoas'
    click_on 'Voltar'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'and dont see inactive rooms' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'Crédito 3x')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                      corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                      email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                      city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                      usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
    room1 = Room.create!(guesthouse: guesthouse, name: 'Elegância', description: 'Um quarto sofisticado para uma estadia luxuosa.', size: 25, 
                      max_people: '2', price: 350.00, air_conditioner: false, bathroom: true, balcony: true, tv: true, wardrobe: true, safe: true, 
                      accessibility: false, status: :inactive)
    room2 = Room.create!(guesthouse: guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, max_people: '4', 
                      price: '220,00', bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                      accessibility: 'Acessível para pessoas com deficiência', status: :active)

    visit root_path
    click_on 'Pousada Serenidade - Maceió'

    expect(page).to have_content 'Tranquilidade - 4 pessoas'
    expect(page).not_to have_content 'Elegância - 2 pessoas'
  end
end
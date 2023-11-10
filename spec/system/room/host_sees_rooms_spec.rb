require "rails_helper"

describe 'Host sees rooms' do
  it 'yet no rooms are registered' do
    host = Host.create!(name: 'Paulo', lastname: 'Xavier', email: 'paulo@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'Crédito até 3x')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)

    login_as(host, :scope => :host)
    visit root_path

    expect(page).to have_content 'Adicionar quartos'
    expect(page).not_to have_content 'Ver quartos'
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
                                    price: '220.0', bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                                    accessibility: 'Acessível para pessoas com deficiência', status: 1)
    login_as(host, :scope => :host)
    visit root_path
    click_on 'Ver quartos'
    click_on 'Tranquilidade - 4 pessoas'

    expect(page).to have_content 'Quarto Tranquilidade'
    expect(page).to have_content 'Pousada Serenidade'
    expect(page).to have_content 'Um ambiente calmo e reconfortante.'
    expect(page).to have_content 'Dimensão: 15 m2'
    expect(page).to have_content 'Capacidade: 4 pessoas'
    expect(page).to have_content 'Preço: R$ 220.0'
    expect(page).to have_content 'Banheiro: Particular'
    expect(page).to have_content 'Televisão: Possui'
    expect(page).to have_content 'Armário: Possui'
    expect(page).to have_content 'Cofre: Possui'
    expect(page).to have_content 'Acessibilidade: Acessível para pessoas com deficiência'
    expect(page).to have_content 'Status: Disponível'
  end
end
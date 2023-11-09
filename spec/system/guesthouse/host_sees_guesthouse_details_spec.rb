require 'rails_helper'

describe 'Host sees your own guesthouse details' do
  it 'and sees aditional informations' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'PIX')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method: payment_method, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
    
    login_as(host, :scope => :host)                                
    visit root_path 
    click_on 'Ver detalhes da pousada'
    expect(page).to have_content('Pousada Serenidade')
    expect(page).to have_content('Atmosfera acolhedora e serviços personalizados')
    expect(page).to have_content('Serenidade Hospedagens Ltda')
    expect(page).to have_content('CNPJ: 10.290.988/0001-20')
    expect(page).to have_content('Contato: 42 98989-0000')
    expect(page).to have_content('E-mail: contato@pousadaencanto.com')
    expect(page).to have_content('Endereço: Estrada das Colinas, Km 5 - Vale Tranquilo, Maceió - AL - 12345-67')
    expect(page).to have_content('Método de pagamento: PIX')
    expect(page).to have_content('Animais de estimação: Aceita')
    expect(page).to have_content('Regras de uso: Manter silêncio nas áreas comuns.')
    expect(page).to have_content('Entrada: 14:00')
    expect(page).to have_content('Saída: 10:00')
    expect(page).to have_content('Status: Disponível')
    end

  it 'and returns to home page' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'PIX')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method: payment_method, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
  
    login_as(host, :scope => :host)                                
    visit root_path
    click_on 'Ver detalhes da pousada'
    click_on 'Voltar' 

    expect(current_path).to eq root_path
    end
end
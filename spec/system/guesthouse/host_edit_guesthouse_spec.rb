require 'rails_helper'

describe 'Host edits guesthouse' do
  it 'must be loged in' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    visit root_path
    click_on 'Entrar como Anfitrião'                              
    within('form') do
      fill_in 'E-mail', with: 'aline@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    expect(page).not_to have_link('Entrar como Anfitrião')
  end

  it 'from the details screen' do 
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'PIX')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                  corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                  email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                  city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                  usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 'Ativo')
    
    visit root_path
    click_on 'Entrar como Anfitrião'
    within('form') do
      fill_in 'E-mail', with: 'aline@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Gerenciar pousada'

    expect(page).to have_content 'Gerenciar pousada'
    expect(page).to have_field 'Nome', with: 'Pousada Serenidade' 
    expect(page).to have_field 'Descrição' 
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Cidade' 
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'CEP'  
    expect(page).to have_field 'Método de pagamento' 
  end

  it 'com sucesso' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'Crédito à vista')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                  corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                  email: 'contato@pousadaserenidade.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                  city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                  usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '11:00', status: 'Ativo')
    
    visit root_path
    click_on 'Entrar como Anfitrião'                              
    within('form') do
      fill_in 'E-mail', with: 'aline@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Gerenciar pousada'

    fill_in 'Nome', with: 'Pousada Serena'
    fill_in 'Razão Social', with: 'Serena Hospedagens LTDA'
    fill_in 'CNPJ', with: '10.320.890/0001-33'
    fill_in 'Contato', with: '43 898980909'
    fill_in 'E-mail', with: 'info@serena.com'
    fill_in 'Endereço', with: 'Estrada dos Morros, Km 90'
    fill_in 'Bairro', with: 'Bosque Verde'
    fill_in 'Estado', with: 'AL'
    fill_in 'Cidade', with: 'Campo Alegre'
    fill_in 'CEP', with: '76543-21'
    fill_in 'Descrição', with: 'Para aproveitar o sol e calor.'
    select 'Crédito à vista', from: 'Método de pagamento'
    uncheck 'Animais de estimação'
    fill_in 'Regras de uso', with: 'Proibido bebidas alcóolicas.'
    fill_in 'Entrada', with: "12:00"
    fill_in 'Saída', with: "10:00"
    check 'Ativo'
    click_on 'Salvar'

    expect(page).to have_content "Atualizado com sucesso!"
    expect(page).to have_content 'Nome: Pousada Serena'
    expect(page).to have_content 'Razão Social: Serena Hospedagens LTDA'
    expect(page).to have_content 'CNPJ: 10.320.890/0001-33'
    expect(page).to have_content 'Contato: 43 898980909'
    expect(page).to have_content 'E-mail: info@serena.com'
    expect(page).to have_content 'Endereço: Estrada dos Morros, Km 90 - Bosque Verde, Campo Alegre - AL'
    expect(page).to have_content 'Descrição: Para aproveitar o sol e calor.'
    expect(page).to have_content 'Regras de uso: Proibido bebidas alcóolicas.'
    expect(page).to have_content 'Entrada: 12:00'
    expect(page).to have_content 'Saída: 10:00'
  end

  it 'incomplete data' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'Crédito à vista')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                  corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                  email: 'contato@pousadaserenidade.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                  city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                  usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '11:00', status: 'Ativo')
    
    visit root_path
    click_on 'Entrar como Anfitrião'                              
    within('form') do
      fill_in 'E-mail', with: 'aline@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Gerenciar pousada'

    fill_in 'Nome', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Contato', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Bairro', with: ''
    fill_in 'Estado', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Descrição', with: ''
    select 'Crédito à vista', from: ''
    fill_in 'Regras de uso', with: ''
    fill_in 'Entrada', with: ''
    fill_in 'Saída', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Contato não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Regras de uso não pode ficar em branco'
  end

  it 'turn guesthouse inactive' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'PIX')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 'Ativo')

    login_as(host, :scope => :host)
    visit root_path
    click_on 'Gerenciar pousada'
    uncheck 'Ativo'
    click_on 'Salvar'

    expect(current_path).to eq(guesthouse_path(guesthouse))
    expect(page).to have_content "#{guesthouse.brand_name}: Atualizado com sucesso!"
    expect(page).to have_content 'Inativo'

  end

  it 'try to edit another guesthouse' do
    first_host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'Crédito à vista')
    first_guesthouse = Guesthouse.create!(host: first_host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 'Ativo')
    
    second_host = Host.create!(name: 'Bruna', lastname: 'Almeida', email: 'bruna@email.com', password: '12345678')

    visit root_path
    click_on 'Entrar como Anfitrião'
    within('form') do
      fill_in 'E-mail', with: 'bruna@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end
    visit edit_guesthouse_path(first_guesthouse)

    expect(page).to have_content 'Você não pode editar essa pousada!'
    expect(current_path).to eq(root_path)
  end
end
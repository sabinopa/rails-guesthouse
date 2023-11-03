require 'rails_helper'

describe 'Host register guesthouse' do 
  it 'must be authenticated' do 
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')

    visit root_path
    click_on 'Entrar como Anfitrião'
    fill_in 'E-mail', with: 'aline@email.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    click_on 'Cadastrar pousada'

    expect(current_path).to eq new_guesthouse_path
  end

  it 'successfully' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'PIX')

    visit root_path
    click_on 'Entrar como Anfitrião'
    within('form') do
      fill_in 'E-mail', with: 'aline@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Cadastrar pousada'
    fill_in 'Nome', with: 'Refúgio do Pôr do Sol'
    fill_in 'Razão Social', with: 'Hospitalidade do Pôr do Sol Ltda.'
    fill_in 'CNPJ', with: '10.321.987/0001-30'
    fill_in 'Descrição', with: 'De frente para a praia!'
    fill_in 'Contato', with: '11-9456-7890'
    fill_in 'E-mail', with: 'info@refugiodopordosol.com'
    fill_in 'Endereço', with: 'Rua Principal, 123'
    fill_in 'Bairro', with: 'Beira-Mar'
    fill_in 'Cidade', with: 'Arraial do Cabo'
    fill_in 'Estado', with: 'RJ'
    fill_in 'CEP', with: '20300-200'
    select 'PIX', from: 'Método de pagamento'
    check 'Aceita animais de estimação'
    fill_in 'Regras de uso', with: 'Proibido fumar e receber convidados.'
    fill_in 'Entrada', with: '14:00'
    fill_in 'Saída', with: '11:00'
    choose 'guesthouse_status_on'
    click_on 'Salvar'

    expect(page).to have_content "Refúgio do Pôr do Sol: Criado com sucesso!"
    expect(page).to have_content 'Refúgio do Pôr do Sol'
    expect(page).to have_content 'Contato: 11-9456-7890'
    expect(page).to have_content 'E-mail: info@refugiodopordosol.com'
    expect(page).to have_content 'Endereço: Rua Principal, 123 - Beira-Mar, Arraial do Cabo - RJ'
    expect(page).to have_content 'Aceita animais de estimação'
  end

  it 'incomplete data' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'PIX')

    visit root_path
    click_on 'Entrar como Anfitrião'
    within('form') do
      fill_in 'E-mail', with: 'aline@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Cadastrar pousada'
    fill_in 'Nome', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Contato', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Bairro', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    select '', from: 'Método de pagamento'
    check ''
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
end
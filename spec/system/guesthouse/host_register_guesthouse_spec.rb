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
    fill_in 'Contato', with: '11-9456-7890'
    fill_in 'E-mail', with: 'info@refugiodopordosol.com'
    fill_in 'Endereço', with: 'Rua Principal, 123'
    fill_in 'Bairro', with: 'Beira-Mar'
    fill_in 'Cidade', with: 'Arraial do Cabo'
    fill_in 'Estado', with: 'RJ'
    select 'PIX', from: :payment_method, visible: false
    #check 'Aceita pets'
    fill_in 'Regras de uso', with: 'Proibido fumar e receber convidados.'
    #select_time "14", "00", from: "Entrada"
    #select_time "11", "00", from: "Saída"
    click_on 'Salvar'

    expect(page).to have_content 'Pousada cadastrada com sucesso!'
    expect(page).to have_content 'Refúgio do Pôr do Sol'
    expect(page).to have_content 'Telefone: 11-9456-7890'
    expect(page).to have_content 'E-mail: info@refugiodopordosol.com'
    expect(page).to have_content 'Beira-mar, Arraial do Cabo, RJ'
    expect(page).to have_content 'Entrada: 14:00'
    expect(page).to have_content 'Saída: 11:00'
  end
end
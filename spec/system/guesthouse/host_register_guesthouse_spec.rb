require 'rails_helper'

describe 'Host register guesthouse' do 
  it 'successfully' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    payment_method = PaymentMethod.create!(name: 'Cartão de Crédito')
    guesthouse = Guesthouse.create!(brand_name: 'Refúgio do Pôr do Sol', corporate_name: 'Hospitalidade do Pôr do Sol Ltda.',
                                    registration_number: '10.321.987/0001-30', phone_number: '11-9456-7890', email: 'info@refugiodopordosol.com',
                                    address: 'Rua Principal, 123', neighborhood: 'Beira-Mar', city: 'Arraial do Cabo', state: 'RJ',
                                    payment_method_id: 1, pet_friendly: true, usage_policy: 'Proibido fumar e receber convidados.',
                                    checkin: '14:00', checkout: '11:00', status: 1)

    visit root_path
    click_on 'Entrar como Anfitrião'
    within('form') do
      fill_in 'E-mail', with: 'aline@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
      click_on 'Cadastrar pousada'
    end

    expect(page).to have_content 'Pousada cadastrada com sucesso!'
    expect(page).to have_content 'Refúgio do Pôr do Sol'
    expect(page).to have_content 'Telefone: 11-9456-7890'
    expect(page).to have_content 'E-mail: info@refugiodopordosol.com'
    expect(page).to have_content 'Beira-mar, Arraial do Cabo, RJ'
    expect(page).to have_content 'Check-in: 14:00'
    expect(page).to have_content 'Check-out: 11:00'
  end
end
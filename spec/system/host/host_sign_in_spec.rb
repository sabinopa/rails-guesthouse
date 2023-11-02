require 'rails_helper'

describe 'Host sign in' do
  it 'successfully' do
    Host.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')

    visit root_path
    click_on 'Entrar como Anfitrião'
    within('form') do
      fill_in 'E-mail', with: 'priscila@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end
    
    expect(page).to have_content 'Login efetuado com sucesso!'
    within('nav') do
      expect(page).not_to have_link 'Entrar como Anfitrião'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Priscila Sabino - priscila@email.com'
    end
  end

  it 'e faz logout' do
    Host.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')

    visit root_path
    click_on 'Entrar como Anfitrião'
    within('form') do
      fill_in 'E-mail', with: 'priscila@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(page).to have_content 'Saiu com sucesso.'
    expect(page).to have_link 'Entrar como Anfitrião'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'Priscila Sabino - priscila@email.com'
  end
end
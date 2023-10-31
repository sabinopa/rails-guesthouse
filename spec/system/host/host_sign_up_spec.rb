require 'rails_helper'

describe 'Host sign up' do
  it 'successfully' do
    User.create!(name: 'Priscila Sabino', email: 'priscila@gmail.com', password: '12345678')

    visit root_path
    click_on 'Entrar como Anfritrião'
    within('form') do
      fill_in 'E-mail', with: 'priscila@gmail.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end
    
    expect(page).to have_content 'Login efetuado com sucesso.'
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Priscila Sabino - priscila@gmail.com'
    end
  end

  it 'e faz logout' do
    User.create!(email: 'priscila@gmail.com', password: 'password')

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'priscila@gmail.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'priscila@gmail.com'
  end
end
require 'rails_helper'

describe 'Guest sign in' do
  it 'successfully' do
    Guest.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')

    visit root_path
    click_on 'Entrar como Hóspede'
    fill_in 'E-mail', with: 'priscila@email.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    
    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).not_to have_link 'Entrar como Hóspede'
    expect(page).to have_button 'Sair'
    expect(page).to have_content 'Priscila Sabino - priscila@email.com'
  end

    it 'and logs out' do
      host = Host.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
  
      login_as(host)
      visit root_path
      click_on 'Sair'
  
      expect(page).to have_content 'Logout efetuado com sucesso.'
      expect(page).to have_link 'Entrar como Hóspede'
      expect(page).not_to have_button 'Sair'
      expect(page).not_to have_content 'Priscila Sabino - priscila@email.com'
    end
  
    it 'and submits blank field' do
      visit root_path
      click_on 'Entrar como Hóspede'
      fill_in 'E-mail', with: ''
      fill_in 'Senha', with: ''
      click_on 'Entrar'
  
      expect(page).to have_content 'E-mail ou senha inválidos.'
    end
  end
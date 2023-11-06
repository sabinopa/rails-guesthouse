require 'rails_helper'

describe 'Host sign up' do
  it 'successfully' do
      visit root_path
      click_on 'Entrar como Anfitrião'
      click_on 'Sign up'
      fill_in 'Nome', with: 'Priscila'
      fill_in 'Sobrenome', with: 'Sabino'
      fill_in 'E-mail', with: 'priscila@email.com'
      fill_in 'Senha', with: 'password'
      fill_in 'Confirme sua senha', with: 'password'
      click_on 'Criar conta'
  
      expect(page).to have_content 'Login efetuado com sucesso.'
      expect(page).to have_content 'Priscila Sabino - priscila@email.com'
    end

    it 'and submits blank field' do
      visit root_path
      click_on 'Entrar como Anfitrião'
      click_on 'Sign up'
      fill_in 'Nome', with: ''
      fill_in 'Sobrenome', with: ''
      fill_in 'E-mail', with: ''
      fill_in 'Senha', with: ''
      fill_in 'Confirme sua senha', with: ''
      click_on 'Criar conta' 
  
      expect(page).to have_content 'Não foi possível salvar anfitrião'
    end
  end
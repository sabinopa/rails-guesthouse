require 'rails_helper'

describe 'User visit homepage' do 
  it 'View the application name' do
    visit('/')

    expect(page).to have_content('Pousadaria')
    expect(page).to have_link('Pousadaria', href: root_path)
  end
end
require 'rails_helper'

describe 'Host answer review' do
  it 'succesfully' do
    host = Host.create!(name: 'Paulo', lastname: 'Xavier', email: 'paulo@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'Crédito até 3x')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
    room = Room.create!(guesthouse: guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, max_people: '4', 
                        price: 100.0, bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                        accessibility: 'Acessível para pessoas com deficiência', status: 1)
    guest = Guest.create!(name: 'Leticia', lastname: 'Souza', document_number: '10.111.222-3', email: 'leticia@email.com', password: '12345678')
    booking = Booking.create!(guest: guest, host: host, start_date: 4.days.ago, end_date: 2.days.ago, number_guests: '2', room: room, 
                              prices: 200.0, status: :ongoing)
    review = Review.create!(guest: guest, booking: booking, rating: 5, comment: 'Lugar maravilhoso!')

    login_as(host, :scope => :host) 
    visit root_path
    click_on 'Avaliações'
    fill_in 'Resposta', with: 'Foi uma prazer lhe receber em nossa pousada!'
    click_on 'Enviar'
 
    expect(current_path).to eq host_reviews_path
    expect(page).to have_content 'Resposta salva com sucesso!'
    expect(page).to have_content 'Resposta'
    expect(page).to have_content 'Foi uma prazer lhe receber em nossa pousada!'
  end

  it 'sees your own answers' do
    host = Host.create!(name: 'Paulo', lastname: 'Xavier', email: 'paulo@email.com', password: 'password')
    payment_method = PaymentMethod.create!(method: 'Crédito até 3x')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                                    corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                                    email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                                    city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
    room = Room.create!(guesthouse: guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, max_people: '4', 
                        price: 100.0, bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                        accessibility: 'Acessível para pessoas com deficiência', status: 1)
    guest = Guest.create!(name: 'Leticia', lastname: 'Souza', document_number: '10.111.222-3', email: 'leticia@email.com', password: '12345678')
    booking = Booking.create!(guest: guest, host: host, start_date: 4.days.ago, end_date: 2.days.ago, number_guests: '2', room: room, 
                              prices: 200.0, status: :ongoing)
    review = Review.create!(guest: guest, booking: booking, rating: 5, comment: 'Lugar maravilhoso!', answer: 'Foi uma prazer lhe receber em nossa pousada!')
    answer = 

    login_as(host, :scope => :host) 
    visit host_reviews_path

    expect(page).to have_content 'Resposta: Foi uma prazer lhe receber em nossa pousada!'
  end
end
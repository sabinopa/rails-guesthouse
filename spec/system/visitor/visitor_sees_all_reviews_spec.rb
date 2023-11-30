require 'rails_helper'

describe 'Visitor sees all guesthouse reviews' do
  it 'from home page' do
    host = Host.create!(name: 'Aline', lastname: 'Santos', email: 'aline@email.com', password: 'password')
    second_host = Host.create!(name: 'Bruna', lastname: 'Almeida', email: 'bruna@email.com', password: '12345678')
    payment_method = PaymentMethod.create!(method: 'Crédito 3x')
    guesthouse = Guesthouse.create!(host: host, description: 'Atmosfera acolhedora e serviços personalizados', brand_name: 'Pousada Serenidade', 
                      corporate_name: 'Serenidade Hospedagens Ltda', registration_number: '10.290.988/0001-20', phone_number: '42 98989-0000',
                      email: 'contato@pousadaencanto.com', address: 'Estrada das Colinas, Km 5', neighborhood: 'Vale Tranquilo', 
                      city: 'Maceió', state:'AL', postal_code: '12345-67', payment_method_id: payment_method.id, pet_friendly: 'Aceita animais de estimação', 
                      usage_policy: 'Manter silêncio nas áreas comuns.', checkin: '14:00', checkout: '10:00', status: 1)
    room = Room.create!(guesthouse: guesthouse, name: 'Tranquilidade', description: 'Um ambiente calmo e reconfortante.', size: 15, max_people: '4', 
                      price: 100.0, bathroom: 'Privado', balcony: 'Não possui', tv: 'Possui', wardrobe: 'Possui', safe: 'Possui', 
                      accessibility: 'Acessível para pessoas com deficiência', status: 1)
    guest1 = Guest.create!(name: 'Leticia', lastname: 'Souza', document_number: '10.111.222-3', email: 'leticia@email.com', password: '12345678')
    guest2 = Guest.create!(name: 'Maria', lastname: 'Barros', document_number: '10.111.555-3',email: 'maris@email.com', password: '87654321')
    booking1 = Booking.create!(guest: guest1, host: host, start_date: 15.days.ago, end_date: 10.days.ago, number_guests: '3', room: room, 
                            prices: 600.0, status: :done)
    booking2 = Booking.create!(guest: guest2, host: host, start_date: 6.days.ago, end_date: 3.days.ago, number_guests: '2', room: room, 
                            prices: 600.0, status: :done)
    review1 = Review.create!(rating: 4, comment: 'Lugar espetacular!', booking: booking1)
    review2 = Review.create!(rating: 5, comment: 'Recomendo!', booking: booking2)

    average = guesthouse.reviews.average(:rating).to_f

    visit root_path
    click_on 'Pousada Serenidade - Maceió'  
    click_on 'Ver todas as avaliações'
    
    expect(page).to have_content "Avaliações de #{guesthouse.brand_name}"
    expect(page).to have_content "Nota média: #{average}"
    expect(page).to have_content "#{guest1.name}"
    expect(page).to have_content "Visitou a pousada em: #{booking1.start_date.strftime('%d/%m/%Y')}"
    expect(page).to have_content "Nota: #{review1.rating}"
    expect(page).to have_content "#{review1.comment}"
    expect(page).to have_content "#{guest2.name}"
    expect(page).to have_content "Visitou a pousada em: #{booking2.start_date.strftime('%d/%m/%Y')}"
    expect(page).to have_content "Nota: #{review2.rating}"
    expect(page).to have_content "#{review2.comment}"
  end
end

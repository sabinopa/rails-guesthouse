PaymentMethod.destroy_all
Host.destroy_all
Guesthouse.destroy_all
Room.destroy_all
CustomPrice.destroy_all
Guest.destroy_all
Booking.destroy_all

# Métodos de Pagamento
dinheiro = PaymentMethod.create(method: 'Dinheiro')
pix = PaymentMethod.create(method: 'PIX')
credito_a_vista = PaymentMethod.create(method: 'Crédito à vista')
credito_2x = PaymentMethod.create(method: 'Crédito 2x')
credito_3x = PaymentMethod.create(method: 'Crédito 3x')

p "Created #{PaymentMethod.count} payment methods"

# Anfitriões
priscila = Host.create(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
pedro = Host.create(name: 'Pedro', lastname: 'Araujo', email: 'pedro@email.com', password: 'senhasenha')
guilherme = Host.create(name: 'Guilherme', lastname: 'Alvares', email: 'guilherme@email.com', password: 'password')
isabel = Host.create(name: 'Isabel', lastname: 'Maria', email: 'isabel@lagoaserena.com', password: 'secret123')
livia = Host.create(name: 'Livia', lastname: 'Alves', email: 'livia@email.com', password: '09876543')

p "Created #{Host.count} hosts"

# Pousadas
guesthouse_one = Guesthouse.create(host_id: priscila.id, description: 'Um paraíso à beira-mar', brand_name: 'Pousada Marítima', 
                                  corporate_name: 'Marítima Hospedagens Ltda', registration_number: '25.135.246/0001-40', 
                                  phone_number: '42 98765-9876', email: 'contato@pousadamaritima.com', address: 'Rua das Ondas, 456', 
                                  neighborhood: 'Praia Tranquila', city: 'Florianópolis', state: 'SC', postal_code: '87654-321', 
                                  payment_method_id: dinheiro.id, pet_friendly: 'Aceita animais de estimação', 
                                  usage_policy: 'Área de piscina exclusiva para adultos.', checkin: '14:30', checkout: '12:00', status: 1)

guesthouse_two = Guesthouse.create(host_id: pedro.id, description: 'Aconchego nas Montanhas', brand_name: 'Chalé Serrano', 
                                  corporate_name: 'Chalé Serrano Hospedagens Eireli', registration_number: '35.987.654/0001-50', 
                                  phone_number: '42 99999-1111', email: 'reservas@chaleserrano.com', address: 'Estrada da Serra, Km 10', 
                                  neighborhood: 'Vale dos Pinheiros', city: 'Campos do Jordão', state: 'SP', postal_code: '12345-678', 
                                  payment_method_id: pix.id, pet_friendly: 'Aceita animais de estimação', 
                                  usage_policy: 'Lareira em todos os chalés.', checkin: '16:00', checkout: '11:00', status: 1)

guesthouse_three = Guesthouse.create(host_id: guilherme.id, description: 'Vivencie o Charme Colonial', brand_name: 'Colonial Palace Hotel', 
                                    corporate_name: 'Colonial Palace Empreendimentos Ltda', registration_number: '45.246.789/0001-60', 
                                    phone_number: '42 98765-5555', email: 'reservas@colonialpalace.com', address: 'Rua das Pedras, 789', 
                                    neighborhood: 'Centro Histórico', city: 'Ouro Preto', state: 'MG', postal_code: '56789-012', 
                                    payment_method_id: credito_a_vista.id, pet_friendly: 'Não aceita animais de estimação', 
                                    usage_policy: 'Restaurante exclusivo para hóspedes.', checkin: '13:00', checkout: '10:30', status: 1)

guesthouse_four = Guesthouse.create(host_id: isabel.id, description: 'Elegância à Beira do Lago', brand_name: 'Lagoa Serena Resort', 
                                    corporate_name: 'Lagoa Serena Empreendimentos S.A.', registration_number: '55.987.654/0001-70', 
                                    phone_number: '42 98765-2222', email: 'reservas@lagoaserena.com', address: 'Avenida Beira Lago, 321', 
                                    neighborhood: 'Lagoa Tranquila', city: 'Gramado', state: 'RS', postal_code: '87654-789', 
                                    payment_method_id: credito_2x.id, pet_friendly: 'Não aceita animais de estimação', 
                                    usage_policy: 'Spa exclusivo para hóspedes.', checkin: '15:30', checkout: '11:30', status: 1)

guesthouse_five = Guesthouse.create(host_id: livia.id, description: 'Estilo Rústico nas Montanhas', brand_name: 'Serra Rustique Lodge', 
                                    corporate_name: 'Serra Rustique Empreendimentos Eireli', registration_number: '65.987.654/0001-80', 
                                    phone_number: '42 98765-3333', email: 'reservas@serrarustique.com', address: 'Estrada da Serra, Km 15', 
                                    neighborhood: 'Vale dos Pinheiros', city: 'Gonçalves', state: 'MG', postal_code: '23456-789', 
                                    payment_method_id: credito_3x.id, pet_friendly: 'Aceita animais de estimação', 
                                    usage_policy: 'Trilhas ecológicas exclusivas para hóspedes.', checkin: '17:00', checkout: '12:30', status: 1)

p "Created #{Guesthouse.count} guesthouses"

# Quartos
room_a = Room.create(guesthouse_id: guesthouse_one.id, name: 'Harmonia', description: 'Um espaço sereno para relaxamento total.', size: 20, 
                    max_people: '3', price: '250.00', bathroom: true, balcony: true, air_conditioner: true, tv: false, wardrobe: true, 
                    safe: false, accessibility: false, status: 1)
room_b = Room.create(guesthouse_id: guesthouse_one.id, name: 'Elegância', description: 'Um quarto sofisticado para uma estadia luxuosa.', 
                    size: 25, max_people: '2', price: '350.00', bathroom: true, balcony: true, air_conditioner: true, tv: true, 
                    wardrobe: true, safe: true, accessibility: false, status: 1)
room_c = Room.create(guesthouse_id: guesthouse_two.id, name: 'Serenidade Suite', description: 'Acomodação espaçosa com vista panorâmica.', 
                    size: 30, max_people: '5', price: '400,00', bathroom: true, balcony: true, air_conditioner: false, tv: true, 
                    wardrobe: true, safe: true, accessibility: true, status: 1)
room_d = Room.create(guesthouse_id: guesthouse_two.id, name: 'Rústico Refúgio', description: 'Decoração rústica para uma experiência acolhedora.', 
                    size: 18, max_people: '2', price: '180,00', bathroom: true, balcony: false, air_conditioner: true, tv: true, 
                    wardrobe: true, safe: false, accessibility: true, status: 1)
room_e = Room.create(guesthouse_id: guesthouse_three.id, name: 'Vista Panorâmica', description: 'Deslumbrante vista de tirar o fôlego.', 
                    size: 22, max_people: '3', price: '280,00', bathroom: true, balcony: true, air_conditioner: true, tv: true, 
                    wardrobe: true, safe: false, accessibility: false, status: 1)
room_f = Room.create(guesthouse_id: guesthouse_three.id, name: 'Quarto Familiar', description: 'Espaço perfeito para a família.', 
                    size: 25, max_people: '6', price: '450,00', bathroom: true, balcony: false, air_conditioner: false, tv: true, 
                    wardrobe: true, safe: true, accessibility: true, status: 1)
room_g = Room.create(guesthouse_id: guesthouse_four.id, name: 'Aconchego Duplo', description: 'Conforto para dois em estilo contemporâneo.', 
                    size: 16, max_people: '2', price: '200,00', bathroom: true, balcony: false, air_conditioner: true, tv: true, 
                    wardrobe: true, safe: false, accessibility: false, status: 1)
room_h = Room.create(guesthouse_id: guesthouse_four.id, name: 'Luxo e Sofisticação', description: 'Elegância em cada detalhe para uma estadia inesquecível.', 
                    size: 28, max_people: '4', price: '380,00', bathroom: true, balcony: true, air_conditioner: false, tv: true, 
                    wardrobe: true, safe: true, accessibility: false, status: 1)
room_i = Room.create(guesthouse_id: guesthouse_five.id, name: 'Suíte Presidencial', description: 'O ápice do conforto e luxo.', 
                    size: 35, max_people: '2', price: '550,00', bathroom: true, balcony: true, air_conditioner: true, tv: true, 
                    wardrobe: true, safe: true, accessibility: true, status: 1)
room_j = Room.create(guesthouse_id: guesthouse_five.id, name: 'Tranquil Night', description: 'Experiência noturna única em um ambiente relaxante.', 
                    size: 20, max_people: '3', price: '300,00', bathroom: true, balcony: false, air_conditioner: true, tv: true, 
                    wardrobe: true, safe: false, accessibility: true, status: 1)

p "Created #{Room.count} rooms"

# Preços personalizados
custom_price_a = CustomPrice.create(room_id: room_a.id, start_date: 3.days.from_now, end_date: 5.days.from_now, price: 280.00)
custom_price_b = CustomPrice.create(room_id: room_a.id, start_date: 7.days.from_now, end_date: 10.days.from_now, price: 350.00)
custom_price_c = CustomPrice.create(room_id: room_b.id, start_date: 12.days.from_now, end_date: 18.days.from_now, price: 400.00)
custom_price_d = CustomPrice.create(room_id: room_b.id, start_date: 20.days.from_now, end_date: 25.days.from_now, price: 320.00)
custom_price_e = CustomPrice.create(room_id: room_c.id, start_date: 10.days.from_now, end_date: 15.days.from_now, price: 290.00)
custom_price_f = CustomPrice.create(room_id: room_c.id, start_date: 8.days.from_now, end_date: 16.days.from_now, price: 330.00)
custom_price_g = CustomPrice.create(room_id: room_d.id, start_date: 4.days.from_now, end_date: 8.days.from_now, price: 310.00)
custom_price_h = CustomPrice.create(room_id: room_d.id, start_date: 10.days.from_now, end_date: 20.days.from_now, price: 340.00)
custom_price_i = CustomPrice.create(room_id: room_e.id, start_date: 45.days.from_now, end_date: 47.days.from_now, price: 380.00)
custom_price_j = CustomPrice.create(room_id: room_e.id, start_date: 10.days.from_now, end_date: 14.days.from_now, price: 300.00)
custom_price_k = CustomPrice.create(room_id: room_f.id, start_date: 2.days.from_now, end_date: 6.days.from_now, price: 320.00)
custom_price_l = CustomPrice.create(room_id: room_f.id, start_date: 20.days.from_now, end_date: 25.days.from_now, price: 340.00)
custom_price_m = CustomPrice.create(room_id: room_g.id, start_date: 5.days.from_now, end_date: 9.days.from_now, price: 360.00)
custom_price_n = CustomPrice.create(room_id: room_g.id, start_date: 10.days.from_now, end_date: 12.days.from_now, price: 380.00)
custom_price_o = CustomPrice.create(room_id: room_h.id, start_date: 5.days.from_now, end_date: 10.days.from_now, price: 300.00)
custom_price_p = CustomPrice.create(room_id: room_h.id, start_date: 15.days.from_now, end_date: 20.days.from_now, price: 320.00)
custom_price_q = CustomPrice.create(room_id: room_i.id, start_date: 5.days.from_now, end_date: 6.days.from_now, price: 340.00)
custom_price_r = CustomPrice.create(room_id: room_i.id, start_date: 10.days.from_now, end_date: 20.days.from_now, price: 360.00)
custom_price_s = CustomPrice.create(room_id: room_j.id, start_date: 20.days.from_now, end_date: 25.days.from_now, price: 380.00)
custom_price_t = CustomPrice.create(room_id: room_j.id, start_date: 9.days.from_now, end_date: 13.days.from_now, price: 400.00)

p "Created #{CustomPrice.count} custom prices"

# Guests
guest1 = Guest.create(name: 'Carlos', lastname: 'Rodrigues', email: 'carlos@email.com', password: 'senha123', document_number: '123.456.789-00')
guest2 = Guest.create(name: 'Mariana', lastname: 'Ferreira', email: 'mariana@email.com', password: 'senha456', document_number: '987.654.321-11')
guest3 = Guest.create(name: 'Pedro', lastname: 'Almeida', email: 'pedro@email.com', password: 'senha789', document_number: '567.890.123-22')
guest4 = Guest.create(name: 'Juliana', lastname: 'Gonçalves', email: 'juliana@email.com', password: 'senha321', document_number: '345.678.912-33')
guest5 = Guest.create(name: 'Fernando', lastname: 'Santana', email: 'fernando@email.com', password: 'senha654', document_number: '789.012.345-44')
guest6 = Guest.create(name: 'Isabela', lastname: 'Silveira', email: 'isabela@email.com', password: 'senha987', document_number: '234.567.891-55')
guest7 = Guest.create(name: 'Lucas', lastname: 'Costa', email: 'lucas@email.com', password: 'senha246', document_number: '876.543.219-66')
guest8 = Guest.create(name: 'Camila', lastname: 'Melo', email: 'camila@email.com', password: 'senha135', document_number: '654.321.987-77')
guest9 = Guest.create(name: 'Rafael', lastname: 'Nunes', email: 'rafael@email.com', password: 'senha879', document_number: '321.654.798-88')
guest10 = Guest.create(name: 'Aline', lastname: 'Barbosa', email: 'aline@email.com', password: 'senha246', document_number: '987.654.321-99')

p "Created #{Guest.count} guests"

#Bookings
booking1 = Booking.create(guest: guest1, host: priscila, start_date: 2.day.ago, end_date: 1.day.from_now, number_guests: '1', room: room_a, prices: 750.0, status: 2, checkin_time: 40.hours.ago )
booking2 = Booking.create(guest: guest1, host: pedro, start_date: 25.days.ago, end_date: 20.days.ago, number_guests: '2', room: room_c, prices: 1200.0, status: 4, checkin_time: 25.days.ago, checkout_time: 20.days.ago)
booking3 = Booking.create(guest: guest2, host: guilherme, start_date: 10.days.from_now, end_date: 20.days.from_now, number_guests: '3', room: room_e, prices: 2880.0, status: 0)
booking4 = Booking.create(guest: guest2, host: isabel, start_date: 25.days.ago, end_date: 20.days.ago, number_guests: '1', room: room_g, prices: 800.0, status: 4, checkin_time: 25.days.ago, checkout_time: 20.days.ago)
booking5 = Booking.create(guest: guest3, host: livia, start_date: 1.day.ago, end_date: 2.days.from_now, number_guests: '2', room: room_i, prices: 1650.0, status: 2, checkin_time: 1.day.ago)
booking6 = Booking.create(guest: guest3, host: priscila, start_date: 7.days.from_now, end_date: 9.days.from_now, number_guests: '1', room: room_b, prices: 700.0, status: 0)
booking7 = Booking.create(guest: guest4, host: pedro, start_date: 8.days.ago, end_date: 4.days.ago, number_guests: '2', room: room_d, prices: 1240.0, status: 4, checkin_time: 8.days.ago, checkout_time: 4.days.ago)
booking8 = Booking.create(guest: guest4, host: guilherme, start_date: 3.days.from_now, end_date: 7.days.from_now, number_guests: '5', room: room_f, prices: 1410.0, status: 0)
booking9 = Booking.create(guest: guest5, host: isabel, start_date: 6.days.from_now, end_date: 7.days.from_now, number_guests: '3', room: room_h, prices: 300.0, status: 0)
booking10 = Booking.create(guest: guest5, host: livia, start_date: 20.days.from_now, end_date: 25.days.from_now, number_guests: '3', room: room_j, prices: 1520.0, status: 0)
booking11 = Booking.create(guest: guest6, host: priscila, start_date: 60.days.ago, end_date: 54.days.ago, number_guests: '2', room: room_a, prices: 1500.0, status: 4, checkin_time: 60.days.ago, checkout_time: 54.days.ago)
booking12 = Booking.create(guest: guest6, host: pedro, start_date: 10.days.from_now, end_date: 13.days.from_now, number_guests: '1', room: room_c, prices: 870.0, status: 0)
booking13 = Booking.create(guest: guest7, host: guilherme, start_date: 20.days.ago, end_date: 18.days.ago, number_guests: '2', room: room_e, prices: 560.0, status: 4, checkin_time: 20.days.ago, checkout_time: 18.days.ago)
booking14 = Booking.create(guest: guest7, host: isabel, start_date: 5.days.from_now, end_date: 10.days.from_now, number_guests: '2', room: room_g, prices: 1640.0, status: 0)
booking15 = Booking.create(guest: guest8, host: livia, start_date: 10.days.from_now, end_date: 12.days.from_now, number_guests: '1', room: room_i, prices: 720.0, status: 0)
booking16 = Booking.create(guest: guest8, host: priscila, start_date: 9.days.from_now, end_date: 14.days.from_now, number_guests: '2', room: room_b, prices: 1900.0, status: 0)
booking17 = Booking.create(guest: guest9, host: pedro, start_date: 30.days.from_now, end_date: 33.days.from_now, number_guests: '2', room: room_d, prices: 540.0, status: 0)
booking18 = Booking.create(guest: guest9, host: guilherme, start_date: 18.days.ago, end_date: 10.days.ago, number_guests: '6', room: room_f, prices: 3600.0, status: 4, checkin_time: 18.days.ago, checkout_time: 10.days.ago )
booking19 = Booking.create(guest: guest10, host: isabel, start_date: 15.days.from_now, end_date: 19.days.from_now, number_guests: '4', room: room_h, prices: 1280.0, status: 0)
booking20 = Booking.create(guest: guest10, host: livia, start_date: 45.days.from_now, end_date: 50.days.from_now, number_guests: '2', room: room_j, prices: 1500.0, status: 0)

p "Created #{Booking.count} bookings"

review1 = Review.create(rating: 5, comment: 'Lugar maravilhoso, recomendo muito!', booking: booking2)
review2 = Review.create(rating: 4, comment: 'Espaço aconchegante!', booking: booking4)
review3 = Review.create(rating: 2, comment: 'Vizinhos incomodaram!', booking: booking7)
review4 = Review.create(rating: 3, comment: 'Ótimo anfitrião, porém café da manhã mediano!', booking: booking11)
review5 = Review.create(rating: 5, comment: 'Quero voltar logo!', booking: booking13)

p "Created #{Review.count} reviews"

p "All done! :)"

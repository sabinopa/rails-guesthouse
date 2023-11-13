PaymentMethod.destroy_all
Host.destroy_all
Guesthouse.destroy_all
Room.destroy_all
CustomPrice.destroy_all
Guest.destroy_all

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
isabel = Host.create(name: 'Isabel', lastname: 'Maria', email: 'isabel@email.com', password: 'secret123')
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
                    max_people: '3', price: '250,00', bathroom: true, balcony: true, air_conditioner: true, tv: false, wardrobe: true, 
                    safe: false, accessibility: false, status: 1)
room_b = Room.create(guesthouse_id: guesthouse_one.id, name: 'Elegância', description: 'Um quarto sofisticado para uma estadia luxuosa.', 
                    size: 25, max_people: '2', price: '350,00', bathroom: true, balcony: true, air_conditioner: true, tv: true, 
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
custom_price_a = CustomPrice.create(room_id: room_a.id, start_date: '16/12/2023', end_date: '20/12/2023', price: 280.00)
custom_price_b = CustomPrice.create(room_id: room_a.id, start_date: '21/12/2023', end_date: '25/12/2023', price: 350.00)
custom_price_c = CustomPrice.create(room_id: room_b.id, start_date: '26/12/2023', end_date: '31/12/2023', price: 400.00)
custom_price_d = CustomPrice.create(room_id: room_b.id, start_date: '01/01/2024', end_date: '05/01/2024', price: 320.00)
custom_price_e = CustomPrice.create(room_id: room_c.id, start_date: '06/01/2024', end_date: '10/01/2024', price: 290.00)
custom_price_f = CustomPrice.create(room_id: room_c.id, start_date: '11/01/2024', end_date: '15/01/2024', price: 330.00)
custom_price_g = CustomPrice.create(room_id: room_d.id, start_date: '16/01/2024', end_date: '20/01/2024', price: 310.00)
custom_price_h = CustomPrice.create(room_id: room_d.id, start_date: '21/01/2024', end_date: '25/01/2024', price: 340.00)
custom_price_i = CustomPrice.create(room_id: room_e.id, start_date: '26/01/2024', end_date: '31/01/2024', price: 380.00)
custom_price_j = CustomPrice.create(room_id: room_e.id, start_date: '01/02/2024', end_date: '05/02/2024', price: 300.00)
custom_price_k = CustomPrice.create(room_id: room_f.id, start_date: '06/02/2024', end_date: '10/02/2024', price: 320.00)
custom_price_l = CustomPrice.create(room_id: room_f.id, start_date: '11/02/2024', end_date: '15/02/2024', price: 340.00)
custom_price_m = CustomPrice.create(room_id: room_g.id, start_date: '16/02/2024', end_date: '20/02/2024', price: 360.00)
custom_price_n = CustomPrice.create(room_id: room_g.id, start_date: '21/02/2024', end_date: '25/02/2024', price: 380.00)
custom_price_o = CustomPrice.create(room_id: room_h.id, start_date: '26/02/2024', end_date: '29/02/2024', price: 300.00)
custom_price_p = CustomPrice.create(room_id: room_h.id, start_date: '01/03/2024', end_date: '05/03/2024', price: 320.00)
custom_price_q = CustomPrice.create(room_id: room_i.id, start_date: '06/03/2024', end_date: '10/03/2024', price: 340.00)
custom_price_r = CustomPrice.create(room_id: room_i.id, start_date: '11/03/2024', end_date: '15/03/2024', price: 360.00)
custom_price_s = CustomPrice.create(room_id: room_j.id, start_date: '16/03/2024', end_date: '20/03/2024', price: 380.00)
custom_price_t = CustomPrice.create(room_id: room_j.id, start_date: '21/03/2024', end_date: '25/03/2024', price: 400.00)

p "Created #{CustomPrice.count} custom prices"
p "All done! :)"

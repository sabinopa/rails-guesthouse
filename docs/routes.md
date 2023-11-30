# Rotas disponíveis e seus retornos

# 📑 Sumário

  1. [Guesthouses]</br>
    * 1.1 - [GET ```/api/v1/guesthouses```]</br>
    * 1.2 - [GET ```/api/v1/guesthouses/:id```]</br>
    * 1.3 - [GET ```/api/v1/guesthouses?search=palavra_da_busca```]
    * 1.4 - [GET ```/api/v1/guesthouses/cities```]
    * 1.5 - [GET ```/api/v1/guesthouses/by_city```]
  2. [Availability]</br>
    * 2.1 [GET ```/api/v1/guesthouses/:id/rooms/:id/availability```]</br>

##  🏡 1. Guesthouses

  Retorna listas e/ou detalhes de pousadas cadastradas e ativas.
</br>
### 🏡🏡 1.1 GET ```/api/v1/guesthouses```

Retorna um hash com os nome de pousadas("brand_name") cadastras e ativas.

```json
{
  "guesthouses": [
    {"brand_name":"Chalé Serrano"},
    {"brand_name":"Colonial Palace Hotel"},
    {"brand_name":"Lagoa Serena Resort"},
    {"brand_name":"Pousada Marítima"},
    {"brand_name":"Serra Rustique Lodge"}
  ]
}
```

</br>

### 🏡⬅️  1.2 GET ```/api/v1/guesthouses/:id```

Retorna um hash com todos os detalhes da pousada [:id], exceto CNPJ e Razão Social. 
Na sequência, retorna uma hash com todos os quartos disponíveis nessa pousada. 
```json
{
  "guesthouse": {
    "id":1,
    "description":"Um paraíso à beira-mar",
    "brand_name":"Pousada Marítima",
    "phone_number":"42 98765-9876",
    "email":"contato@pousadamaritima.com",
    "address":"Rua das Ondas, 456",
    "neighborhood":"Praia Tranquila",
    "city":"Florianópolis",
    "state":"SC",
    "payment_method_id":1,
    "pet_friendly":true,
    "usage_policy":"Área de piscina exclusiva para adultos.",
    "checkin":"2000-01-01T14:30:00.000-02:00",
    "checkout":"2000-01-01T12:00:00.000-02:00",
    "status":"active",
    "postal_code":"87654-321",
    "host_id":1},
  "available_rooms":[{
    "id":1,
    "name":"Harmonia",
    "description":"Um espaço sereno para relaxamento total.",
    "size":20,
    "max_people":"3",
    "bathroom":true,
    "balcony":true,
    "air_conditioner":true,
    "tv":false,
    "guesthouse_id":1,
    "wardrobe":true,
    "safe":false,
    "accessibility":false,
    "status":"active",
    "price":"250.0"
    },
    {
    "id":2,
    "name":"Elegância",
    "description":"Um quarto sofisticado para uma estadia luxuosa.",
    "size":25,
    "max_people":"2",
    "bathroom":true,
    "balcony":true,
    "air_conditioner":true,
    "tv":true,
    "guesthouse_id":1,
    "wardrobe":true,
    "safe":true,
    "accessibility":false,
    "status":"active",
    "price":"350.0"}
    ]
  }
```
</br>

### 🏡🔍 1.3 - GET ```/api/v1/guesthouses?search=palavra_da_busca```

Query Params: search - Realiza busca por pousadas com base em seus nomes.
O resultado da busca é um hash contendo os nomes ('brand_name') das pousadas encontradas e ativas.

Exemplo: Buscar por "Marítima"

```json
  [{ "brand_name":"Pousada Marítima" }]
```

### 🏡🏙️ 1.4 - GET ```/api/v1/guesthouses/cities```
Retorna um hash com as cidades disponíveis onde há pousadas cadastradas e ativas.

```json
  { "cities":["Florianópolis", "Campos do Jordão", "Ouro Preto", "Gramado", "Gonçalves"] }
```

### 🏡🌆 1.5 - GET /api/v1/guesthouses/by_city (Novo)
Retorna as pousadas cadastradas e ativas de uma cidade específica.

Exemplo: ```/api/v1/guesthouses/by_city?city=Florianópolis```

```json
[
  {
    "id":1,
    "description":"Um paraíso à beira-mar",
    "brand_name":"Pousada Marítima",
    "phone_number":"42 98765-9876",
    "email":"contato@pousadamaritima.com",
    "address":"Rua das Ondas, 456",
    "neighborhood":"Praia Tranquila",
    "city":"Florianópolis",
    "state":"SC",
    "payment_method_id":1,
    "pet_friendly":true,
    "usage_policy":"Área de piscina exclusiva para adultos.",
    "checkin":"2000-01-01T14:30:00.000-02:00",
    "checkout":"2000-01-01T12:00:00.000-02:00",
    "status":"active",
    "postal_code":"87654-321",
    "host_id":1
    }
]
```

##  🛏️ 2. Availability

Retorna resposta sobre a disponibilidade de quartos de uma pousada para a data requisitada e a quantidade específica de hóspedes solicitados.

### 2.1 GET ```/api/v1/guesthouses/:id/rooms/:id/availability```

Parâmetros obrigatórios:

- Data de entrada [:start_date]
- Data de término [:end_date]
- Número de hóspedes [:number_guests]

Exemplos:```/api/v1/guesthouses/10/rooms/5/availability?start_date=YYYY-MM-DD&end_date=YYYY-MM-DD&number_guests=3``` | </br>
```api/v1/guesthouses/1/rooms/2/availability?start_date=11-12-2023&end_date=14-12-2023&number_guests=2```

```json
{"available":true,"total_price":990.0}
```




  

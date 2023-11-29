# Pousadaria - Plataforma de Reservas em Pousadas

O Pousadaria é uma aplicação web desenvolvida com Ruby on Rails, criada com o objetivo de oferecer uma plataforma para a busca, visualização e reserva de quartos em pousadas espalhadas por todo o país. 

## Funcionalidades

 - [x]  Criar perfis exclusivos para proprietários de pousadas, permitindo que eles adicionem detalhes sobre seu estabelecimento, políticas de uso e localização.
 - [x]  Permitir que os proprietários de pousadas especifiquem as comodidades oferecidas em cada quarto, assim como estabeleçam os preços para cada tipo de acomodação.
 - [x]  Permitir os donos de pousadas a personalizar os preços durante períodos de alta demanda ou de baixa demanda.
 - [x]  Oferecer aos proprietários de pousadas a opção de desativar temporariamente seus estabelecimentos.
 - [x]  Disponibilizar aos visitantes uma lista completa de pousadas cadastradas.
 - [x]  Destacar as pousadas mais recentes para os visitantes.
 - [x]  Facilitar aos visitantes a busca por pousadas através de um menu categorizado por cidades.
 - [x]  Permitir que os visitantes pesquisem pousadas por nome, cidade ou bairro.
 - [x]  Habilitar aos visitantes a pesquisa por atributos específicos do estabelecimento.
 - [x]  Apresentar aos visitantes os quartos disponíveis em cada pousada, juntamente com detalhes sobre cada tipo de acomodação.
 - [x]  Permitir que os visitantes verifiquem a disponibilidade de quartos em datas específicas.
 - [x]  Possibilitar que os hóspedes façam reservas diretamente.
 - [x]  Oferecer aos proprietários de pousadas a capacidade de realizar o check-in no início da reserva e o check-out no final.
 - [x]  Ajustar automaticamente os valores caso a reserva ocorra em datas diferentes das agendadas inicialmente.

### Gems utilizadas
- [Devise](https://github.com/heartcombo/devise)
- [Rspec](https://github.com/rspec/rspec-rails)
- [Capybara](https://github.com/teamcapybara/capybara)

### APIS
Acesse a documentação de APIS presentes no projeto [aqui](https://github.com/sabinopa/guesthouse-app/blob/main/docs/routes.md).

### Como executar o projeto 
Para executar esse projeto, você deve instalar a linguagem [Ruby v3.2.2](https://www.ruby-lang.org/pt/) e o framework [Rails v7.0.8](https://guides.rubyonrails.org/) em seu computador.

Em seguida, siga os passos abaixo: 

- Clone este repostório
```
git clone https://github.com/sabinopa/guesthouse-app
```

- Abra o diretório pelo terminal 
```
cd guesthouse-app
```

- Instale o Bundle pelo terminal 
```
bundle install
```

- Crie e popule o banco de dados 
```
rails db:migrate
rails db:seed
```

- Execute a aplicação 
```
rails server
```

- Acesse a aplicação no link http://localhost:3000/

### Navegação
Para acessar páginas que requerem autenticação, utilize as contas abaixo:

|   Usuário   |          E-mail         |    Senha    |
|-------------|-------------------------|-------------|
|   Hóspede   |     lucas@email.com     |   senha246  |
|  Anfitrião  |  isabel@lagoaserena.com |   secret123 |



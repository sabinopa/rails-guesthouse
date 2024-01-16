# Pousadaria - Plataforma de Reservas em Pousadas

<p>
  <img src="https://img.shields.io/badge/Ruby_3.1.2-CC342D?style=for-the-badge&logo=ruby&logoColor=white"/>
  <img src="https://img.shields.io/badge/Ruby_on_Rails_7.0.6-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white"/>
  <img src="http://img.shields.io/badge/v1?label=TESTES&message=%3E100&color=GREEN&style=for-the-badge"/>
  <img src="http://img.shields.io/static/v1?label=STATUS&message=EM%20DESENVOLVIMENTO&color=RED&style=for-the-badge"/> 
</p>

## Tópicos

:arrow_forward: [Descrição do projeto](#descrição-do-projeto)

:arrow_forward: [Funcionalidades](#funcionalidades)

:arrow_forward: [Gems utilizadas](#gems-utilizadas)

:arrow_forward: [APIs](#apis)

:arrow_forward: [Pré-requisitos](#pré-requisitos)

:arrow_forward: [Como executar a aplicação](#como-executar-a-aplicação)

:arrow_forward: [Como executar os testes](#como-executar-os-testes)

:arrow_forward: [Navegação](#navegação)

:arrow_forward: [Tarefas em aberto](#tarefas-em-aberto)

## Descrição do Projeto
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

### Pré-requisitos

:heavy_exclamation_mark: [Ruby v3.2.2](https://www.ruby-lang.org/pt/) 

:heavy_exclamation_mark: [Rails v7.0.8](https://guides.rubyonrails.org/)

### Como executar a aplicação
- Clone este repositório
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

### Como executar os testes

```
rspec
```

### Navegação
Para acessar páginas que requerem autenticação, utilize as contas abaixo:

|   Usuário   |          E-mail         |    Senha    |
|-------------|-------------------------|-------------|
|   Hóspede   |     lucas@email.com     |   senha246  |
|  Anfitrião  |  isabel@lagoaserena.com |   secret123 |

### Tarefas em aberto 

 :camera: **Galeria de Fotos** 

Um usuário autenticado como dono de uma pousada deve ser capaz de cadastrar fotos para sua pousada e também para os quartos de sua pousada. Deve ser possível fazer o upload de fotos em formatos PNG e JPEG. Deve ser possível remover uma foto anteriormente cadastrada.

Todas as fotos cadastradas devem ser listadas na página de detalhes da pousada ou do quarto.

:pizza: **Consumíveis** 

Um usuário autenticado como dono de uma pousada, pode acessar uma hospedagem ativa no momento e fazer lançamentos de itens consumidos pelos hóspedes. Cada item deve ter uma descrição e um valor, por exemplo: Suco de laranja - R$ 8; Hambúrguer com batata frita - R$ 30. Ao fazer o check-out, estes itens devem ser adicionados ao valor total da hospedagem.

:family: **Check in com cadastro de hóspedes** 

Ao fazer o check in de uma reserva, o dono da pousada deve informar o nome completo e RG ou CPF de cada uma das pessoas que está se hospedando. O formulário deve ser dinâmico e permitir a inserção de N pessoas, sendo N o número de pessoas informadas no momento da criação da reserva.
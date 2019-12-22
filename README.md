# README

Este projeto importa dados da API https://swapi.co/ e lista os registros utilizando para desenvolvimento do client-side VueJS e Ruby on Rails para server-side.

# Star Wars

### Dependências
------------

- Ruby version 2.5.0+
- Rails 6.0.0+
- PostgreSQL
- Redis 4.0+

### Instalação
------------

Instale as gems

`bundle install`


Crie o banco de dados e importe os dados

`bundle exec rake db:reset`


Se precisar apenas importar os dados

`bundle exec rake db:seed`


Instale as dependências do javascript

`yarn install`


Inicie o Sidekiq para executar os processos que o db:seed enfileirou, pois os dados estão sendo importados em background

`bundle exec sidekiq`


### Execução
------------

Inicie o servidor

`rails s`


### Teste
------------

Para executar os testes

`bundle exec rspec`

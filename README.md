# Beep Saúde Test

Este é um projeto , desenvolvido usando Vue.js no frontend e Ruby on Rails no backend.

## Funcionalidades

- Exibe as 15 top histórias do Hacker News;
- Permite busca por histórias e/ou comentários;
- Mostra detalhes das histórias, incluindo pontuação e comentários.

## Ferramentas usadas

- Node.js (versão 14 ou superior)
- Ruby (versão 3.2.2 ou superior)
- Rails (versão 7.x ou superior)
- MySQL (para o banco de dados)

## Instalação

1. Clone o repositório:
```
git clone https://github.com/seu-usuario/seu-repositorio.git
```

2. Navegue até a pasta do projeto:
```
cd ./seu-repositorio
```

3. Instale as dependências do frontend:
```
cd frontend/hacker-news-app
```

```
npm install
```

4. Instale as dependências do backend:
```
cd ../backend
```

```
bundle install
```

5. Configure o banco de dados:
```
rails db:create rails db:migrate
```

## Execução

1. Inicie o servidor Rails:
```
cd ./seu-repositorio
```

```
rails server
```

2. Inicie o servidor Vue.js:
```
cd frontend/hacker-news-app
```

```
npm run serve
```

3. Acesse o aplicativo em `http://localhost:3001`

## Uso

- A homepage é uma requisição para a rota index do controller onde busca as 15 principais histórias e seus comentários considerados relevantes.
- A busca é realizada por um termo onde o mesmo poderá ser encontrado tanto em uma história quanto em um comentário.

## Observações

- Durante o desenvolvimento foi observado uma demora para receber resposta da API Hacker News. Como exemplo, a index leva em torno de 1 até 2 minutos para conseguir receber a resposta.
- Como a rota de busca exigiria muitos resultados, optei por configurar um cronjob usando Sidekiq para que execute a cada 6 horas uma busca geral na API externa, com objetivo de enriquecer uma base de dados local. Essa base é usada para ser consultada na rota de busca, ganhando performance e celeridade.
- Já na rota index, aproveitei a funcionalidade de Cache que é oferecida pelo Ruby on Rails e optei por armazenar por 1h a primeira resposta recebida na requisição.

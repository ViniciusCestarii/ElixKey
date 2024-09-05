# Template para Desafio CLI

Este template tem o objetivo de servir como 
ponto de partida para a implementação de desafios
de contratação da Cumbuca que envolvam implementar
uma interface de linha de comando em Elixir.

## Pré-requisitos

Primeiro, será necessário [instalar o Elixir](https://elixir-lang.org/install.html)
em versão igual ou superior a 1.16.
Com o Elixir instalado, você terá a ferramenta de build `mix`.

Para buildar o projeto, use o comando `mix escript.build` nesta pasta.
Isso irá gerar um binário com o mesmo nome do projeto na pasta.
Executando o binário, sua CLI será executada.


## Running with Docker

Build the image:

```bash
docker build -t elixir-cli-desafio .
```

Run the container:

```bash
docker run -it elixir-cli-desafio
```

## Running tests with Docker
Build the image:

```bash
docker build -t elixir-cli-desafio .
```

```bash
docker run --rm elixir-cli-desafio mix test
```
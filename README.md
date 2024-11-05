# ElixKey: Cumbuca desafio Elixir DB e CLI

[![Build Status](https://github.com/ViniciusCestarii/cumbuca-desafio/actions/workflows/test.yml/badge.svg)](https://github.com/ViniciusCestarii/cumbuca-desafio/actions/workflows/test.yml)

Solução do [desafio proposto pela Cumbuca](https://github.com/appcumbuca/desafios/blob/master/desafio-back-end-pleno.md)

## Descrição

O desafio é desenvolver uma interface de linha de comando (CLI) e um banco de dados key-value utilizando exclusivamente a linguagem Elixir e suas bibliotecas nativas.

## Solução

A CLI foi implementada utilizando a biblioteca nativa IO do Elixir, onde o usuário pode interagir com o banco de dados key-value através de comandos como `SET`, `GET`, `BEGIN`, `ROLLBACK` e `COMMIT`.

O banco de dados key-value foi implementado com persistência, armazenando os dados em um arquivo binário. As transações e o estado da aplicação são mantidos em memória utilizando estruturas `Map`.

Adicionados novos comandos: `EXIT`, `EXISTS` e `DELETE`.

## Commands

### `SET <key> <value>`
Sets the value associated with the specified key.

returns: TRUE or FALSE if the key already exists and the value.

### `GET <key>`

Gets the value associated with the specified key.

returns: The value associated with the key or NIL if the key does not exist.

### `DELETE <key>`

Deletes the value associated with the specified key.

returns: TRUE or FALSE if the key exists.

### `EXISTS <key>`

Checks if the key exists.

returns: TRUE or FALSE if the key exists.

### `BEGIN`

Starts a new transaction.

returns: nesting level of transactions.

### `ROLLBACK`

Rolls back the current transaction.

returns: nesting level of transactions.

### `COMMIT`

Commits the current transaction.

returns: nesting level of transactions.

### `EXIT`

Exits the CLI.

returns: Goodbye message.

## Pré-requisitos

Primeiro, será necessário [instalar o Elixir](https://elixir-lang.org/install.html)
em versão igual ou superior a 1.16.
Com o Elixir instalado, você terá a ferramenta de build `mix`.

Para buildar o projeto, use o comando `mix escript.build` nesta pasta.
Isso irá gerar um binário com o mesmo nome do projeto na pasta.
Executando o binário, sua CLI será executada.

Executando binário no Linux:

```bash
./elix_key
```

Executando binário no Windows:

```bash
escript elix_key
```


## Running with Docker

Build the image:

```bash
docker build -t elix_key .
```

Run the container:

```bash
docker run -it --rm elix_key
```

## Running tests with Docker
Build the image:

```bash
docker build -t elix_key .
```

Run the tests:

```bash
docker run --rm elix_key mix test
```

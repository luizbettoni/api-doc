---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - shell
  - php

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='https://github.com/lord/slate'>Documentation Powered by Slate</a>

includes:
  - errors
  - nfe
  - nfce
  - backups
  - nfse
  - manifestacao
  - webhooks
  - revenda
  - limite-requisicoes

search: true
---

# Introdução

<aside class="warning">Esta é a API para a versão mais recente (v2) usando NFe 4.00. Para acessar a documentação da API v1 <a href='https://focusnfe.com.br/api/doc'>clique aqui</a>.</aside>

A API do Focus NFe permite que você emita ou consulte documentos fiscais (NFe, NFSe, NFCe) a partir do seu sistema, seja qual for a tecnologia que ele utilize através da geração de dados em um formato simplificado, sem a necessidade de gerara a assinatura digital destes documentos. A API ainda gerencia toda a comunicação com os servidores da SEFAZ de cada estado ou com os servidores da prefeitura, no caso de NFSe.

Através desta documentação deverá ser possível fazer a integração com a API do Focus NFe, caso alguma dúvida permaneça você pode entrar em contato com o suporte especializado através do e-mail suporte@acras.com.br.

## Como ler este documento?

Você deverá ler primeiramente a introdução, em seguida, a seção sobre o documento que você irá emitir ([NFe](#nfe), [NFCe](#nfce) ou [NFSe](#nfse)).

Caso você emita NFe ou NFCe, você deverá ler também sobre os [backups](#backups-nfe-e-nfce).

Caso você emita NFe ou NFSe, você poderá ler também sobre os [gatilhos](#gatilhos). O uso de gatilhos no sistema é opcional.

Caso você tenha interesse em obter as notas emitidas contra a sua empresa, leia a seção de [manifestação](#manifestacao).

Se sua empresa irá administrar vários clientes que emitem notas, pode ser interessante você ler sobre a seção de [revenda](#revenda).

## Qual documento fiscal você precisa emitir?

Dependendo da atividade da sua empresa você deverá emitir um ou mais destes documentos que irão representar frente ao governo qualquer operação com mercadoria ou serviços:

* NFe - Nota Fiscal Eletrônica. Utilizado para indústrias, distribuidores em geral ou empresas que vendem para clientes fora de seu estado. Neste caso é aceitável uma nota demorar vários minutos para ser autorizada. Existe um padrão nacional. O documento é de competência do estado.
* NFCe - Nota Fiscal ao Consumidor Eletrônica. Utilizado para empresas de varejo, que trabalham diretamente com o consumidor final. Neste caso há a preocupação da nota ser emitida em poucos segundos. Existe um padrão nacional. O documento é de competência do estado.
* NFSe - Nota Fiscal de Serviços Eletrônica. Utilizado para a maioria dos prestadores de serviços. É aceitável a nota demorar vários minutos para ser autorizada. Esta nota é de competência da prefeitura. Existe uma recomendação nacional que cada prefeitura implementa como bem entender.
* CTe - Conhecimento de Transporte Eletrônico. Usado para prestadores de serviços de transporte. Existe um padrão nacional. Documento de competência do estado.

Existe algumas exceções no país, por exemplo Brasília pode utilizar NFe para serviços e Manaus utiliza NFCe em alguns casos para notas de serviços. Na dúvida, consulte o contador da sua empresa.

## Visão geral do processo de emissão de um documento

## Autenticação

A autenticação é feita através de um token. Ao habilitar a API para sua empresa forneceremos uma string secreta e única que será usada para efetuar todas as operações. A autenticação poderá ser feita usando o método HTTP Basic Auth (saiba mais em [https://en.wikipedia.org/wiki/Basic_access_authentication](https://en.wikipedia.org/wiki/Basic_access_authentication)) fornecendo o token como nome de usuário e deixando a senha em branco.

Caso não seja possível utilizar método HTTP Basic Auth você pode também enviar sempre o parâmetro “token” informando o seu token de acesso. Porém nós recomendamos o uso de HTTP Basic Auth pois isto aumenta a segurança impedindo a gravação do token em históricos do navegador, logs de acesso, etc.


## Referência

A referência é a forma que utilizamos para identificar a sua emissão em nossa API, por isso, ela deve ser única para cada token de acesso que você receba. A referência pode ser alfanumérica, contudo, não são permitidos caracteres especiais. É comum a utilização do identificador da tabela em banco de dados que representa uma nota fiscal no seu sistema.

Uma referência pode ser reutilizada caso ocorra erro na autorização. Mas uma vez que a nota seja autorizada (mesmo que posteriormente cancelada), a referência usada não poderá mais ser usada em outro envio.

## Ambiente

A API do Focus NFe oferece dois ambientes para emissão de notas: homologação e produção.

**Homologação**

O ambiente de homologação serve para envio de notas fiscais com a finalidade de teste. As notas emitidas aqui não possuem validade fiscal/tributária.

**Produção**
Este é o ambiente com validade fiscal e tributária, pois isso, recomendamos que utilize este ambiente apenas quando for iniciar o processo de envio de notas válidas.

O endereço dos servidores são os seguintes:

Homologação: `http://homologacao.acrasnfe.acras.com.br` (note que não é utilizado SSL).

Produção: `https://api.focusnfe.com.br` (obrigatório o uso de SSL).

Ao longo desta documentação todas as URLs serão mostradas para ambiente de produção. Para usar o ambiente de homologação basta alterar o endereço do servidor.

## Padrão REST

A API utiliza o padrão de arquitetura REST [https://pt.wikipedia.org/wiki/REST](https://pt.wikipedia.org/wiki/REST). Neste padrão, são utilizados verbos ou métodos HTTP (GET, POST, DELETE) em conjunto com determinados recursos disponíveis através de uma URL para representar uma determinada ação. Por exemplo, o verbo GET é usado para representar algum tipo de visualização dos dados de um dado recurso, e o verbo POST é usado para criar um novo recurso e o verbo DELETE representa uma exclusão.

Abaixo alguns exemplos de requisições:

Método | URL (recurso) | Ação
------ | ------------- | --------------
POST |	/v2/nfe?ref=REFERENCIA | Cria uma nota fiscal e a envia para processamento.
GET	| /v2/nfe/REFERENCIA | Consulta a nota fiscal com a referência informada e o seu status de processamento
DELETE | /v2/nfe/REFERENCIA	| Cancela uma nota fiscal com a referência informada

A API utiliza o formato JSON para transferência de dados.

Sempre que é feita uma chamada HTTP é devolvido um código de retorno. Este código irá informar também se a requisição foi aceita ou se ocorreu algum erro, da seguinte forma:

* Códigos que iniciam com “2” representam ação que foi completada com sucesso, por exemplo: 200, 201.
* Códigos que inicial com “4” ou "5" representam algum erro na requisição, por exemplo: 404, 402, etc.


Abaixo listamos os códigos HTTP que nossa API pode devolver:

Código HTTP	| Significado	| Explicação
------ | ------------- | --------------
200	| Ok | Este código é devolvido quando uma consulta resulta em sucesso.
201	| Criado | Este código é devolvido quando uma requisição é aceita para processamento.
400	| Requisição inválida |	Este erro é devolvido quando falta alguma informação na requisição. Por exemplo quando falta algum parâmetro obrigatório.
403	| Permissão negada | Este erro é devolvido quando ocorre algum problema de permissão envolvendo o token de acesso.
404	| Não encontrado | Este erro é devolvido quando não é encontrado algum recurso que é pesquisado.
415	| Mídia inválida | Este erro é devolvido quando não é reconhecido o formato JSON enviado, devido a alguma falha de sintaxe.
429 | Muitas requisições | Você ultrapassou o limite de requisições por minuto. Veja o [limite de requisições](#limite-de-requisicoes)
429 | Muitas requisições | Você ultrapassou o limite de requisições por minuto. Veja o [limite de requisições](#limite-de-requisicoes)
500 | Erro interno do servidor | Ocorreu algum erro inesperado. Contate o suporte técnico.

Note que se o código HTTP devolvido for de sucesso não implica que uma nota tenha sido autorizada com sucesso. Por exemplo, você pode enviar uma nota fiscal para autorização, nossa API devolver o status 201 (criado) (pois não havia nenhum erro aparente na nota fiscal) porém ao ser processada pela SEFAZ ou prefeitura verificou-se que a data de emissão estava muito atrasada. Ou seja, os códigos HTTP são utilizados para verificar se a transação está ok no nível de comunicação da sua aplicação com a nossa API (e não com o SEFAZ).

# Authentication

> To authorize, use this code:

```ruby
require 'kittn'

api = Kittn::APIClient.authorize!('meowmeowmeow')
```

```python
import kittn

api = kittn.authorize('meowmeowmeow')
```

```shell
# With shell, you can just pass the correct header with each request
curl "api_endpoint_here"
  -H "Authorization: meowmeowmeow"
```

```javascript
const kittn = require('kittn');

let api = kittn.authorize('meowmeowmeow');
```

> Make sure to replace `meowmeowmeow` with your API key.

Kittn uses API keys to allow access to the API. You can register a new Kittn API key at our [developer portal](http://example.com/developers).

Kittn expects for the API key to be included in all API requests to the server in a header that looks like the following:

`Authorization: meowmeowmeow`

<aside class="notice">
You must replace <code>meowmeowmeow</code> with your personal API key.
</aside>

# Kittens

## Get All Kittens

```ruby
require 'kittn'

api = Kittn::APIClient.authorize!('meowmeowmeow')
api.kittens.get
```

```python
import kittn

api = kittn.authorize('meowmeowmeow')
api.kittens.get()
```

```shell
curl "http://example.com/api/kittens"
  -H "Authorization: meowmeowmeow"
```

```javascript
const kittn = require('kittn');

let api = kittn.authorize('meowmeowmeow');
let kittens = api.kittens.get();
```

> The above command returns JSON structured like this:

```json
[
  {
    "id": 1,
    "name": "Fluffums",
    "breed": "calico",
    "fluffiness": 6,
    "cuteness": 7
  },
  {
    "id": 2,
    "name": "Max",
    "breed": "unknown",
    "fluffiness": 5,
    "cuteness": 10
  }
]
```

This endpoint retrieves all kittens.

### HTTP Request

`GET http://example.com/api/kittens`

### Query Parameters

Parameter | Default | Description
--------- | ------- | -----------
include_cats | false | If set to true, the result will also include cats.
available | true | If set to false, the result will include kittens that have already been adopted.

<aside class="success">
Remember — a happy kitten is an authenticated kitten!
</aside>

## Get a Specific Kitten

```ruby
require 'kittn'

api = Kittn::APIClient.authorize!('meowmeowmeow')
api.kittens.get(2)
```

```python
import kittn

api = kittn.authorize('meowmeowmeow')
api.kittens.get(2)
```

```shell
curl "http://example.com/api/kittens/2"
  -H "Authorization: meowmeowmeow"
```

```javascript
const kittn = require('kittn');

let api = kittn.authorize('meowmeowmeow');
let max = api.kittens.get(2);
```

> The above command returns JSON structured like this:

```json
{
  "id": 2,
  "name": "Max",
  "breed": "unknown",
  "fluffiness": 5,
  "cuteness": 10
}
```

This endpoint retrieves a specific kitten.

<aside class="warning">Inside HTML code blocks like this one, you can't use Markdown, so use <code>&lt;code&gt;</code> blocks to denote code.</aside>

### HTTP Request

`GET http://example.com/kittens/<ID>`

### URL Parameters

Parameter | Description
--------- | -----------
ID | The ID of the kitten to retrieve

## Delete a Specific Kitten

```ruby
require 'kittn'

api = Kittn::APIClient.authorize!('meowmeowmeow')
api.kittens.delete(2)
```

```python
import kittn

api = kittn.authorize('meowmeowmeow')
api.kittens.delete(2)
```

```shell
curl "http://example.com/api/kittens/2"
  -X DELETE
  -H "Authorization: meowmeowmeow"
```

```javascript
const kittn = require('kittn');

let api = kittn.authorize('meowmeowmeow');
let max = api.kittens.delete(2);
```

> The above command returns JSON structured like this:

```json
{
  "id": 2,
  "deleted" : ":("
}
```

This endpoint deletes a specific kitten.

### HTTP Request

`DELETE http://example.com/kittens/<ID>`

### URL Parameters

Parameter | Description
--------- | -----------
ID | The ID of the kitten to delete

# Revenda

A API para revenda consiste em uma série de métodos para criar e habilitar automaticamente uma empresa para emissão de documentos fiscais (NFe, NFCe ou NFSe). São disponibilizados os métodos para criar uma empresa, buscar dados de uma empresa ou listar todas as empresas. Cada empresa possui um identificador único (campo id) que você deverá armazenar em sua base de dados para poder alterar ou buscar dados da empresa posteriormente.

**Ambientes**

Os dados das empresas de uma revenda são compartilhados nos ambientes de produção e homologação. Desta forma é possível criar uma empresa em produção para poder realizar testes em homologação. Não há um ambiente separado exclusivo para criação de empresas em ambiente de testes. Porém, quando aplicável, adicionamos o parâmetro opcional dry_run=1 que permite que a criação da empresa seja simulada sem que sefa efetivamente comitado no nosso banco de dados. Desta forma você poderá testar as chamadas antes de implementá-las em produção.

## URLs

Método | URL (recurso) | Ação
-------|---------------|------
POST|/v2/empresas | Cria uma nova empresa.
GET|/v2/empresas | Consulta todas as empresas.
GET|/v2/empresas/ID | Consulta uma a empresa a partir do seu identificador.
POST|/v2/empresa/ID | Altera os dados de uma empresa específica.

## Campos

O formato de envio dos campos é no formato JSON, que deverá ser enviado no formato:

 {empresa: {atributo1: valor1, atributo2: valor2, … } }

Abaixo são listados todos os campos de uma empresa.

>Exemplo de um arquivo JSON

```json
{
   "nome":"Nome da empresa Ltda",
   "nome_fantasia":"Nome Fantasia",
   "bairro":"Vila Isabel",
   "cep":80210000,
   "cnpj":"10964044000164",
   "complemento":"Loja 1",
   "discrimina_impostos":true,
   "email":"test@example.com",
   "enviar_email_destinatario":true,
   "inscricao_estadual":1234,
   "inscricao_municipal":46532,
   "logradouro":"Rua João da Silva",
   "numero":153,
   "regime_tributario":1,
   "telefone":"4130333333",
   "municipio":"Curitiba",
   "uf":"PR",
   "habilita_nfe":true,
   "habilita_nfce":true,
   "arquivo_certificado_base64":"MIIj4gIBAzCCI54GCSqGSIb3DQEHAaCC..apagado…ASD==",
   "senha_certificado":123456,
   "csc_nfce_producao":"ABCDEF",
   "id_token_nfce_producao":"00001"
}
```

| Campo                                                        | Tipo             | Obrig\. NFe | Obrig\. NFCe | Obrig\. NFSe | Descrição                                                                                                                                                                  |
|--------------------------------------------------------------|------------------|-------------|--------------|--------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| nome                                                         | texto            | Sim         | Sim          | Sim          | Razão social da empresa                                                                                                                                                    |
| nome\_fantasia                                               | texto            | Sim         | Sim          | Sim          | Nome fantasia                                                                                                                                                              |
| inscricao\_estadual                                          | numérico         | Sim         | Sim          |              | Inscrição estadual                                                                                                                                                         |
| inscricao\_municipal                                         | numérico         |             |              | Sim          | Inscrição municipal                                                                                                                                                        |
| cnpj                                                         | numérico         | Sim         | Sim          | Sim          | CNPJ                                                                                                                                                                       |
| regime\_tributario                                           | enumeração       | Sim         | Sim          | Sim          | "Regime tributário\. Valores possíveis: 1 - Simples Nacional; 2 - Simples Naciona - Excesso de sublimite de receita bruta; 3 - Regime Normal|
| email                                                        | email            | Sim         | Sim          | Sim          | Email de contato da empresa                                                                                                                                                |
| telefone                                                     | numérico         | Sim         | Sim          |              | Telefone da empresa                                                                                                                                                        |
| logradouro                                                   | texto            | Sim         | Sim          | Sim          | Endereço: logradouro                                                                                                                                                       |
| numero                                                       | numérico         | Sim         | Sim          | Sim          | Endereço: número                                                                                                                                                           |
| complemento                                                  | texto            |             |              |              | Endereço: complemento                                                                                                                                                      |
| bairro                                                       | texto            | Sim         | Sim          | Sim          | Endereço: bairro                                                                                                                                                           |
| cep                                                          | numérico         | Sim         | Sim          | Sim          | Endereço: CEP completo                                                                                                                                                     |
| municipio                                                    | texto            | Sim         | Sim          | Sim          | Endereço: nome do município sem abreviações                                                                                                                                |
| uf                                                           | texto            | Sim         | Sim          | Sim          | Endereço: UF com 2 caracteres                                                                                                                                              |
| enviar\_email\_destinatario                                  | booleano         |             |              |              | Habilita ou não envio de e\-mail ao destinatário/tomador do serviço após emissão do documento fiscal                                                                       |
| discrimina\_impostos                                         | booleano         |             |              | N/A          | Habilita ou não o cálculo automático de impostos totais aproximados de acordo com a Lei da Transparência\. Não é utilizado para NFSe\.                                     |
| cpf\_cnpj\_contabilidade                                     | numérico         |             |              | N/A          | CPF/CNPJ da contabilidade da empresa\. Alguns estados necessitam que esta informação seja adicionado \(no momento apenas BA obriga\)\.                                     |
| habilita\_nfe                                                | booleano         | Sim         | N/A          | N/A          | Informa se empresa será habilitada para emissão de NFe – Nota Fiscal Eletrônica modelo 55                                                                                  |
| habilita\_nfce                                               | booleano         | N/A         | Sim          | N/A          | Informa se empresa será habilitada para emissão de NFCe – Nota Fiscal ao Consumidor Eletrônica modelo 65                                                                   |
| habilita\_nfse                                               | booleano         | N/A         | N/A          | Sim          | Informa se empresa será habilitada para emissão de NFSe – Nota Fiscal de Serviço Eletrônica                                                                                |
| csc\_nfce\_producao                                          | texto            | N/A         | Sim          | N/A          | CSC para emissão de NFCe em ambiente de produção\. Sem este campo não será possível emitir NFCe em produção\. Veja com o SEFAZ do seu estado como gerar este código\.      |
| id\_token\_nfce\_producao                                    | numérico         | N/A         | Sim          | N/A          | Id do CSC para emissão de NFCe em ambiente de produção\. Sem este campo não será possível emitir NFCe em produção\.Veja com o SEFAZ do seu estado como gerar este número\. |
| csc\_nfce\_homologacao                                       | texto            | N/A         |              | N/A          | CSC para emissão de NFCe em ambiente de homologação\. Sem este campo não será possível emitir NFCe em homologação\.                                                        |
| id\_token\_nfce\_homologacao                                 | numérico         | N/A         |              |              | Id do CSC para emissão de NFCe em ambiente dehomologação\. Sem este campo não será possível emitir NFCe em homologação\.                                                   |
| proximo\_numero\_nfe\_producao                               | numérico         |             | N/A          | N/A          | Próximo número da NFe a ser emitida em produção\. Calculado automaticamente\.                                                                                              |
| proximo\_numero\_nfe\_homologacao                            | numérico         |             | N/A          | N/A          | Próximo número da NFe a ser emitida em homologação\. Calculado automaticamente\.                                                                                           |
| serie\_nfe\_producao                                         | numérico         |             | N/A          | N/A          | Série da NFe a ser emitida em produção\. Valor padrão: 1                                                                                                                   |
| serie\_nfe\_homologacao                                      | numérico         |             | N/A          | N/A          | Série da NFe a ser emitida em homologação\. Valor padrão: 1                                                                                                                |
| proximo\_numero\_nfse\_producao                              | numérico         | N/A         | N/A          |              | Próximo número do RPS da NFSe a ser emitida em produção\. Calculado automaticamente\.                                                                                      |
| proximo\_numero\_nfse\_homologacao                           | numérico         | N/A         | N/A          |              | Próximo número do RPS da NFSe a ser emitida em homologação\. Calculado automaticamente\.                                                                                   |
| serie\_nfse\_producao                                        | numérico         | N/A         | N/A          |              | Série do RPS para envio de NFSe em produção\. Algumas prefeituras não utilizam\.                                                                                           |
| serie\_nfse\_homologacao                                     | numérico         | N/A         | N/A          |              | Série do RPS em homologação\.                                                                                                                                              |
| arquivo\_certificado\_base64                                 | texto em base 64 | Sim         | Sim          | Sim\*        | "Arquivo do certificado digital, em formato PFX ou P12, codificado em base64\. Nem todas as prefeituras necessitam de certificado para emissão de NFSe\."                  |
| senha\_certificado                                           | texto            | Sim         | Sim          | Sim\*        | Senha do certificado digital\.                                                                                                                                             |
| arquivo\_logo\_base64                                        | texto em base 64 |             |              |              | Logomarca da empresa para ser usada na DANFE\. Nem todas as prefeituras aceitam o uso de logo\. Utilize uma imagem em formato PNG de no máximo 200×200 pixels              |

## Criação de empresa

```shell
curl -u "token obtido no cadastro da empresa:" \
  -T empresa.json
  https://api.focusnfe.com.br/v2/empresas
```

Uma empresa pode ser criada usando o seguinte endereço

`https://api.focusnfe.com.br/v2/empresas`

Caso queira apenas testar a criação de uma empresa, utilize o endereço abaixo:

`https://api.focusnfe.com.br/v2/empresas?dry_run=1`

Utilize o comando **HTTP POST**.
O conteúdo do POST deverá conter os dados da empresa. O resultado será os dados da empresa criados ou uma mensagem de erro de validação. É importante salvar o campo id gerado para posterior consulta ou alteração da empresa. Considere o campo "id" como sendo alfanumérico, pois no futuro o formato deverá ser alterado para permitir letras e números na identificação.


## Consulta de empresas

```shell
curl -u "token obtido no cadastro da empresa:" \
  https://api.focusnfe.com.br/v2/empresas/123
```

Uma empresa pode ser visualizada usando o seguinte endereço

`https://api.focusnfe.com.br/v2/empresas/ID`

Onde ID é o id da empresa fornecido no momento da criação. Utilize o comando **HTTP GET**. O resultado será todos os dados da empresa.

## Alteração de empresa

```shell
curl -X PUT -u "token obtido no cadastro da empresa:" \
  -T empresa.json
  https://api.focusnfe.com.br/v2/empresas/123
```

Uma empresa pode ser alterada usando o seguinte endereço.

`https://api.focusnfe.com.br/v2/empresas/ID`

Caso queira apenas testar a alteração de uma empresa, utilize o endereço abaixo:

`https://api.focusnfe.com.br/v2/empresas?dry_run=1`

Onde ID é o id da empresa fornecido no momento da criação Utilize o comando **HTTP PUT** para alterar a empresa. O conteúdo do PUT deverá conter os dados da empresa que serão alterados. Os demais dados permanecerão inalterados. O resultado será todos os dados da empresa criados ou uma mensagem de erro de validação. Os dados devem seguir o mesmo formato para criação da empresa.

Atributos que não serão modificados podem ser omitidos.

## Listagem de empresas

```shell
curl -u "token obtido no cadastro da empresa:" \
  https://api.focusnfe.com.br/v2/empresas
```

É possível listar todas as empresas criadas usando o seguinte método HTTP:

`https://api.focusnfe.com.br/v2/empresas`

Utilize o comando **HTTP GET**. O resultado será todos os dados de todas a empresas.


## Paginação

Ao fazer uma pesquisa, a API irá devolver o cabeçalho HTTP *X-Total-Count* que representa
o número total de ocorrências da pesquisa, porém a API devolve apenas 50 registros por vez.
Para buscar os demais registros, utilize o parâmetro **offset**. Exemplo:

Vamos supor que a chamada abaixo devolva 123 ocorrências:

`https://api.focusnfe.com.br/v2/empresas`

A segunda e terceira páginas da consulta poderão ser acessados desta forma:

Registros 51 a 100:
`https://api.focusnfe.com.br/v2/empresas?offset=50`

Registros 101 a 123:
`https://api.focusnfe.com.br/v2/empresas?offset=100`

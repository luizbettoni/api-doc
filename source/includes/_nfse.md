# NFSe
## Requisição_NFSe
## URLs_NFSe
A API utiliza o padrão de arquitetura REST (https://pt.wikipedia.org/wiki/REST). Neste padrão, são utilizados verbos ou métodos HTTP (GET, POST, DELETE) em conjunto com determinados recursos disponíveis através de uma URL para representar uma determinada ação. Por exemplo, o verbo GET é usado para representar algum tipo de visualização dos dados de um dado recurso, e o verbo POST é usado para criar um novo recurso e o verbo DELETE representa uma exclusão.

Abaixo listamos todas as ações disponíveis na API:

Método URL (recurso) | Ação
---------------------|------
POST /v2/nfse?ref=REFERENCIA | Cria uma nota fiscal e a envia para processamento.
GET	/v2/nfse/REFERENCIA | Consulta a nota fiscal com a referência informada e o seu status de processamento
DELETE	/v2/nfse/REFERENCIA | Cancela uma nota fiscal com a referência informada
POST	/v2/nfse/REFERENCIA/email | Envia um email com uma cópia da nota fiscal com a referência informada

A API utiliza o formato JSON para transferência de dados.

Sempre que é feita uma chamada HTTP é devolvido um código de retorno. Este código irá informar também se a requisição foi aceita ou se ocorreu algum erro, da seguinte forma:

Códigos que iniciam com “2” representam ação que foi completada com sucesso, por exemplo: 200, 201.
Códigos que inicial com “4” representam algum erro na requisição, por exemplo: 404, 402, etc.
Abaixo listamos os códigos HTTP que nossa API pode devolver:

Código HTTP | Significado | Explicação
------------|-------------|------------
200 | Ok | Este código é devolvido quando uma consulta resulta em sucesso.
201	| Criado | Este código é devolvido quando uma requisição é aceita para processamento.
400 | Requisição inválida | Este erro é devolvido quando falta alguma informação na requisição. Por exemplo quando falta algum parâmetro obrigatório.
403 | Permissão negada | Este erro é devolvido quando ocorre algum problema de permissão envolvendo o token de acesso.
404 | Não encontrado | Este erro é devolvido quando não é encontrado algum recurso que é pesquisado.
415 | Mídia inválida | Este erro é devolvido quando não é deconhecido o formato JSON enviado, devido a alguma falha de sintaxe.

## Envio_NFSe

Para enviar uma NFSe utilize a URL abaixo, alterando o ambiente de produção para homologação, caso esteja emitindo notas de teste.

Envia uma NFSe para autorização:

'https://api.focusnfe.com.br/v2/nfse.json?ref=REFERENCIA'

Utilize o comando HTTP POST para enviar a sua nota para nossa API.

## Consulta_NFSe

Para consultar uma NFSe utilize a URL abaixo, alterando o ambiente de produção para homologação, caso esteja emitindo notas de teste.

Recupera informações sobre a NFSe:

`https://api.focusnfe.com.br/v2/nfse/REFERENCIA.json`

Utilize o comando HTTP GET para consultar a sua nota para nossa API.

## Reenvio de email_NFSe

Para cada nota autorizada, cancelada ou que tenha sido emitida uma carta de correção o destinatário da nota é notificado via email. Porém eventualmente pode ser necessário enviar a nota fiscal para outras pessoas ou mesmo reenviar o email para o mesmo destinatário.

Para enviar um ou mais emails:

`https://api.focusnfe.com.br/v2/nfse/REFERENCIA/email`

Utilize o comando HTTP POST para enviar os emails. Esta operação aceita apenas um parâmetro:

* emails: Array com uma lista de emails que deverão receber uma cópia da nota. Limitado a 10 emails por vez.
A API imediatamente devolve a requisição com a confirmação dos emails. Os emails serão enviados em segundo plano, por isso pode levar alguns minutos até que eles cheguem à caixa postal.

## Cancelamento_NFSe

Para cancelar uma NFSe, basta fazer uma requisição à URL abaixo, alterando o ambiente de produção para homologação, caso esteja emitindo notas de teste.

Cancelar uma NFSe já autorizada:

`https://api.focusnfe.com.br/nfse/REFERENCIA.json`

Utilize o comando HTTP DELETE para cancelar a sua nota para nossa API. 
Este método é síncrono, ou seja, a comunicação com a prefeitura será feita imediatamente e devolvida a resposta na mesma requisição.

A API irá em seguida devolver os seguintes campos:

* status: cancelado, se a nota pode ser cancelada, ou erro_cancelamento, se houve algum erro ao cancelar a nota.
* erros: um array de mensagens de erro que impedem que a nota seja cancelada 

Prazo de cancelamento
A NFSe não possui um prazo padrão para cancelamento como vemos na NFCe, por exemplo. Outro detalhe importante é que como alguns municípios não possuem ambiente de homologação, é preciso emitir as notas de teste em produção. Sendo assim, recomendamos que sempre consulte o seu município antes de emitir uma NFSe.

## Formato dos dados_NFSe
## Envio_NFSe

> Exemplo de um arquivo JSON:

```json
{  
   "data_emissao":"2017-09-21T22:15:00",
   "prestador":{  
      "cnpj":"18765499000199",
      "inscricao_municipal":"12345",
      "codigo_municipio":"3516200"
   },
   "tomador":{  
      "cnpj":"07504505000132",
      "razao_social":"Acras Tecnologia da Informação LTDA",
      "email":"contato@acras.com.br",
      "endereco":{  
         "logradouro":"Rua Dias da Rocha Filho",
         "numero":"999",
         "complemento":"Prédio 04 - Sala 34C",
         "bairro":"Alto da XV",
         "codigo_municipio":"4106902",
         "uf":"PR",
         "cep":"80045165"
      }
   },
   "servico":{  
      "aliquota":3,
      "discriminacao":"Nota fiscal referente a serviços prestados",
      "iss_retido":"false",
      "item_lista_servico":"0107",
      "codigo_tributario_municipio": "620910000",
      "valor_servicos":1.0
   }
}
```

## Retorno_NFSe

>Exemplo de resposta da consulta de NFSe:

```json

{
  "cnpj_prestador":"19151707200188",
  "ref":"123",
  "status":"autorizado",
  "numero":"9999",
  "codigo_verificacao":"311299647",
  "data_emissao":"2017-09-09T10:20:00-03:00",
  "url":"http://visualizar.ginfes.com.br/report/consultarNota?__report=nfs_ver2&amp;cdVerificacao=311299647&amp;numNota=9999&amp;cnpjPrestador=19151707200188",
"caminho_xml_nota_fiscal":"/notas_fiscais_servico/NFSe191517072001883518800-1898781-9999-312276647.xml"
}

```

## Campos_NFSe
## Geral_NFSe

* **data_emissao**(*): Data/hora de emissão da NFSe. Alguns municípios como São Paulo não utilizam hora e ela será descartada caso seja fornecida. Formato padrão ISO, exemplo: “2016-12-25T12:00-0300”.
 -**status**: Status da NFS-e. (Valor padrão: 1). Informar:
   - Normal;
   - Cancelado; 
- **natureza_operacao**(*): Natureza da operação. Informar um dos códigos abaixo. Campo ignorado para o município de São Paulo. 
  - Tributação no município;
  - Tributação fora do município;
  - Isenção;
  - Imune;
  - Exigibilidade suspensa por decisão judicial;
  - Exigibilidade suspensa por procedimento administrativo (Valor padrão: 1).
- **regime_especial_tributacao**: Informar o código de identificação do regime especial de tributação conforme abaixo. Campo ignorado para o município de São Paulo. 
  - Microempresa municipal; 
  - Estimativa;
  - Sociedade de profissionais;
  - Cooperativa;
  - MEI (Simples Nacional);
  - ME EPP (Simples Nacional);
* **optante_simples_nacional**(*): Informar verdadeiro ou falso se a empresa for optante pelo Simples Nacional. Campo ignorado pelo município de São Paulo.
* **incentivador_cultural**: Informe verdadeiro ou falso. Valor padrão: falso. Campo ignorado para o município de São Paulo.
- **tributacao_rps**: Usado apenas pelo município de São Paulo. Informe o tipo de tributação: 
  - **T**: Operação normal (tributação conforme documento emitido); 
  - **I**: Operação isenta ou não tributável, executadas no Município de São Paulo; 
  - **F**: Operação isenta ou não tributável pelo Município de São Paulo, executada em outro Município;
  - **J**: ISS Suspenso por Decisão Judicial (neste caso, informar no campo Discriminação dos Serviços, o número do processo judicial na 1a. instância). (Valor padrão “T”).
* **codigo_obra**: Código da obra quando construção civil. Tamanho: 15 caracteres.
* **art**: Código ART quando construção civil. Este campo é ignorado pelo município de São Paulo. Tamanho: 15 caracteres.

## Prestador_NFSe

- **prestador**:
  - **cnpj**(*): CNPJ do prestador de serviços. Caracteres não numéricos são ignorados.
  - **codigo_municipio**(*): Código IBGE do município do prestador (consulte lista aqui)
  - **inscricao_municipal**(*): Inscrição municipal do prestador de serviços. Caracteres não numéricos são ignorados.

-

## Tomador_NFSe

- **tomador**:
  - **cpf**(*): CPF do tomador, se aplicável. Caracteres não numéricos são ignorados.
  - **cnpj**(*): CNPJ do tomador, se aplicável. Caracteres não numéricos são ignorados.
  - **inscricao_municipal**: Inscrição municipal do tomador. Caracteres não numéricos são ignorados.
  - **razao_social**: Razão social ou nome do tomador. Tamanho: 115 caracteres.
  - **telefone**: Telefone do tomador. Campo ignorado para o município de São Paulo. Tamanho: 11 caracteres.
  - **email**: Email do tomador. Tamanho: 80 caracteres.
  - **endereco**:
  	  - **logradouro**: Nome do logradouro. Tamanho: 125 caracteres.
  	  - **tipo_logradouro**: Tipo do logradouro. Usado apenas para o município de São Paulo. Valor padrão: os 3 primeiros caracteres do logradouro. Tamanho: 3 caracteres.
  	  - **numero**: Número do endereço. Tamanho: 10 caracteres.
  	  - **complemento**: Complemento do endereço. Tamanho: 60 caracteres.
  	  - **bairro**: Bairro. Tamanho: 60 caracteres.
  	  - **codigo_municipio**: código IBGE do município.
  	  - **uf**: UF do endereço. Tamanho: 2 caracteres.
  	  - **cep**: CEP do endereço. Caracteres não numéricos são ignorados.

## Serviço_NFSe

- **servico**:
	- **valor_servicos**(*): Valor dos serviços.
	- **valor_deducoes**: Valor das deduções.
	- **valor_pis**: Valor do PIS.
	- **valor_cofins**: Valor do COFINS.
	- **valor_inss**: Valor do INSS.
	- **valor_ir**: Valor do IS.
	- **valor_csll**: Valor do CSLL
	- **iss_retido**(*): Informar verdadeiro ou falso se o ISS foi retido.
	- **valor_iss**: Valor do ISS. Campo ignorado pelo município de São Paulo.
	- **valor_iss_retido**: Valor do ISS Retido. Campo ignorado pelo município de São Paulo.
	- **outras_retencoes**: Valor de outras retenções. Campo ignorado pelo município de São Paulo.
	- **base_calculo**: Base de cálculo do ISS, valor padrão igual ao valor_servicos. Campo ignorado pelo município de São Paulo.
	- **aliquota**: Aliquota do ISS.
	- **desconto_incondicionado**: Valor do desconto incondicionado. Campo ignorado pelo município de São Paulo.
	- **desconto_condicionado**: Valor do desconto incondicionado. Campo ignorado pelo município de São Paulo.
	- **item_lista_servico**(*): informar o código da lista de serviços, de acordo com a Lei Complementar 116/2003. Utilize outra tabela para o município de São Paulo.
	- **codigo_cnae**: Informar o código CNAE. Campo ignorado pelo município de São Paulo.
	- **codigo_tributario_municipio**: Informar o código tributário de acordo com a tabela de cada município (não há um padrão). Campo ignorado pelo município de São Paulo.
	- **discriminacao**(*): Discriminação dos serviços. Tamanho: 2000 caracteres.
	- **codigo_municipio**(*): Informar o código IBGE do município de prestação do serviço.
	- **percentual_total_tributos**: Percentual aproximado de todos os impostos, de acordo com a Lei da Transparência. No momento disponível apenas para São Paulo.
	- **fonte_total_tributos**: Fonte de onde foi retirada a informação de total de impostos, por exemplo, “IBPT”. No momento disponível apenas para São Paulo.


## intermediário_NFSe

- **intermediario** (esta seção é ignorada pelo município de São Paulo)
	- **razao_social**: Razão social do intermediário do serviço. Tamanho: 115 caracteres.
	- **cpf**: CPF do intermediário do serviço, se aplicável. Caracteres não numéricos são ignorados.
	- **cnpj**: CNPJ do intermediário do serviço, se aplicável. Caracteres não numéricos são ignorados.
	- **inscricao_municipal**: Inscrição municipal do intermediário do serviço, se aplicável. Caracteres não numéricos são ignorados.


## Exemplos de códigos

```php

> Envio de uma NFSe para autorização.
    
<?php
/* Você deve definir isso globalmente para sua aplicação.
Para ambiente de produção utilize e a variável abaixo:
$server = "https://api.focusnfe.com.br"; */
$server = "http://homologacao.acrasnfe.acras.com.br";
// Substituir a variável, ref, pela sua identificação interna de nota.
$ref = "12345";
$login = "token_enviado_pelo_suporte";
$password = "";
$nfse = array (
    "data_emissao" => "2017-12-27T17:43:14-3:00",
    "incentivador_cultural" => "false",
    "natureza_operacao" => "1",
    "optante_simples_nacional" => "false",
    "prestador" => array(
        "cnpj" => "51916585000125",
        "inscricao_municipal" => "12345",
        "codigo_municipio" => "4119905"
        ),
    "tomador" => array(
    	"cnpj" => "07504505000132",
        "razao_social" => "Acras Tecnologia da Informacao LTDA",
        "email" => "contato@acras.com.br",
        "endereco" => array(
          "bairro" => "Jardim America",
          "cep" => "81530900",
          "codigo_municipio" => "4119905",
          "logradouro" => "Rua ABC",
          "numero" => "16",
          "uf" => "PR"
         )
    ),
    "servico" => array(
           "discriminacao" => "Exemplo Servico",
           "iss_retido" => "false",
           "item_lista_servico" => "106",
           "codigo_cnae" => "6319400",
           "valor_servicos" => "1.00"
    ),
  );
// Inicia o processo de envio das informações usando o cURL
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $server."/v2/nfse?ref=" . $ref);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($nfse));
curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
curl_setopt($ch, CURLOPT_USERPWD, "$login:$password");
$body = curl_exec($ch);
$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
// As próximas três linhas são um exemplo de como imprimir as informações de retorno da API.
print($http_code."\n");
print($body."\n\n");
print("");
curl_close($ch);
?>

```
```php

<?php
/* Você deve definir isso globalmente para sua aplicação.
Para ambiente de produção utilize e a variável abaixo:
$server = "https://api.focusnfe.com.br"; */
$server = "http://homologacao.acrasnfe.acras.com.br";
// Substituir a variável, ref, pela sua identificação interna de nota.
$ref = "12345";
$login = "token_enviado_pelo_suporte";
$password = "";
// Inicia o processo de envio das informações usando o cURL.
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $server."/v2/nfse/" . $ref);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_HTTPHEADER, array());
curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
curl_setopt($ch, CURLOPT_USERPWD, "$login:$password");
$body = curl_exec($ch);
$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
 
// As próximas três linhas são um exemplo de como imprimir as informações de retorno da API.
print($http_code."\n");
print($body."\n\n");
print("");
curl_close($ch);
?>

```


```php
<?php
/* Você deve definir isso globalmente para sua aplicação.
Para ambiente de produção utilize e a variável abaixo:
$server = "https://api.focusnfe.com.br"; */
$server = "http://homologacao.acrasnfe.acras.com.br";
// Substituir a variável, ref, pela sua identificação interna de nota.
$ref = "12345";
$login = "token_enviado_pelo_suporte";
$password = "";
$justificativa = array ("justificativa" => "Teste de cancelamento de nota");
// Inicia o processo de envio das informações usando o cURL.
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $server . "/v2/nfse/" . $ref);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "DELETE");
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($justificativa));
curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
curl_setopt($ch, CURLOPT_USERPWD, "$login:$password");
$body = curl_exec($ch);
$result = curl_getinfo($ch, CURLINFO_HTTP_CODE);
// As próximas três linhas são um exemplo de como imprimir as informações de retorno da API.
print($http_code."\n");
print($body."\n\n");
print("");
curl_close($ch);
?> 

```

```php

<script src="https://gist.github.com/acras-sistemas/ca8e693c1c58ed6429772a5fe3c1a996.js"></script>

```
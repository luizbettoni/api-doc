
# NFe

Através da API NFe é possível:

* Emitir NFe utilizando dados simplificados.
* Cancelar NFe.
* Consultar o status de NFe emitidas.
* Encaminhar uma NFe por email
* Emitir Carta de Correção.
* Inutilizar uma faixa de numeração de NFe

## URLs


Método | URL (recurso) | Ação
-------|-------|-----
POST |	/v2/nfe?ref=REFERENCIA	| Cria uma nota fiscal e a envia para processamento.
GET	 | /v2/nfe/REFERENCIA	| Consulta a nota fiscal com a referência informada e o seu status de processamento
DELETE |	/v2/nfe/REFERENCIA	| Cancela uma nota fiscal com a referência informada
POST |	/v2/nfe/REFERENCIA/carta_correcao	| Cria uma carta de correção para a nota fiscal com a referência informada.
POST |	/v2/nfe/REFERENCIA/email	| Envia um email com uma cópia da nota fiscal com a referência informada
POST |	/v2/nfe/inutilizacao	| Inutiliza uma numeração da nota fiscal

## Envio

Para enviar uma NFe utilize a URL abaixo, alterando o ambiente de produção para homologação, caso esteja emitindo notas de teste.

Envia uma NFe para autorização:

`https://api.focusnfe.com.br/v2/nfe?ref=REFERENCIA`

Utilize o comando HTTP POST para enviar a sua nota para nossa API. Envie como corpo do POST os dados em formato JSON da nota fiscal.

>> Abaixo um exemplo de dados de uma nota (usando a versão 4.00 da NFe):

```json
{
  "natureza_operacao":"Remessa",
  "data_emissao":"2017-04-15",
  "data_entrada_saida":"2017-04-15",
  "tipo_documento":1,
  "finalidade_emissao":1,
  "cnpj_emitente":"SEU_CNPJ",
  "nome_emitente":"Sua Raz\u00e3o Social Ltda",
  "nome_fantasia_emitente":"Fantasia do Emitente",
  "logradouro_emitente":"Rua Quinze de Abril",
  "numero_emitente":999,
  "bairro_emitente":"Jd Paulistano",
  "municipio_emitente":"S\u00e3o Paulo",
  "uf_emitente":"SP",
  "cep_emitente":"01454-600",
  "inscricao_estadual_emitente":"SUA_INSCRICAO_ESTADUAL",
  "nome_destinatario":"NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL",
  "cpf_destinatario":"03055054911",
  "inscricao_estadual_destinatario":null,
  "telefone_destinatario":1196185555,
  "logradouro_destinatario":"Rua S\u00e3o Janu\u00e1rio",
  "numero_destinatario":99,
  "bairro_destinatario":"Crespo",
  "municipio_destinatario":"Manaus",
  "uf_destinatario":"AM",
  "pais_destinatario":"Brasil",
  "cep_destinatario":69073178,
  "valor_frete":0.0,
  "valor_seguro":0,
  "valor_total":47.23,
  "valor_produtos":47.23,
  "modalidade_frete":0,
  "items": [
    {
      "numero_item":1,
      "codigo_produto":1232,
      "descricao":"Cartu00f5es de Visita",
      "cfop":5923,
      "unidade_comercial":"un",
      "quantidade_comercial":100,
      "valor_unitario_comercial":0.4723,
      "valor_unitario_tributavel":0.4723,
      "unidade_tributavel":"un",
      "codigo_ncm":49111090,
      "quantidade_tributavel":100,
      "valor_bruto":47.23,
      "icms_situacao_tributaria":41,
      "icms_origem":0,
      "pis_situacao_tributaria":"07",
      "cofins_situacao_tributaria":"07"
    }
  ]
}
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
$nfe = array (
  "natureza_operacao" => "Remessa",
  "data_emissao" => "2017-11-30T12:00:00",
  "data_entrada_saida" => "2017-11-3012:00:00",
  "tipo_documento" => "1",
  "finalidade_emissao" => "1",
  "cnpj_emitente" => "51916585000125",
  "nome_emitente" => "ACME LTDA",
  "nome_fantasia_emitente" => "ACME LTDA",
  "logradouro_emitente" => "R. Padre Natal Pigato",
  "numero_emitente" => "100",
  "bairro_emitente" => "Santa Felicidade",
  "municipio_emitente" => "Curitiba",
  "uf_emitente" => "PR",
  "cep_emitente" => "82320030",
  "inscricao_estadual_emitente" => "101942171617",
  "nome_destinatario" => "NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL",
  "cpf_destinatario" => "51966818092",
  "telefone_destinatario" => "1196185555",
  "logradouro_destinatario" => "Rua S\u00e3o Janu\u00e1rio",
  "numero_destinatario" => "99",
  "bairro_destinatario" => "Crespo",
  "municipio_destinatario" => "Manaus",
  "uf_destinatario" => "AM",
  "pais_destinatario" => "Brasil",
  "cep_destinatario" => "69073178",
  "valor_frete" => "0.0",
  "valor_seguro" => "0",
  "valor_total" => "47.23",
  "valor_produtos" => "47.23",
  "modalidade_frete" => "0",
  "items" => array(
    array(
      "numero_item" => "1",
      "codigo_produto" => "1232",
      "descricao" => "Cartu00f5es de Visita",
      "cfop" => "6923",
      "unidade_comercial" => "un",
      "quantidade_comercial" => "100",
      "valor_unitario_comercial" => "0.4723",
      "valor_unitario_tributavel" => "0.4723",
      "unidade_tributavel" => "un",
      "codigo_ncm" => "49111090",
      "quantidade_tributavel" => "100",
      "valor_bruto" => "47.23",
      "icms_situacao_tributaria" => "400",
      "icms_origem" => "0",
      "pis_situacao_tributaria" => "07",
      "cofins_situacao_tributaria" => "07"
    )
  ),
);
// Inicia o processo de envio das informações usando o cURL.
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $server."/v2/nfe?ref=" . $ref);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($nfe));
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

### Reenvio automático em contingência

Caso nossa equipe de monitoramento detecte que o SEFAZ de algum estado esteja fora do ar as requisições são redirecionadas para o ambiente de contingência da SEFAZ do estado. É natural haver uma demora na SEFAZ em disponibilizar esse ambiente (eles realizam este processo manualmente) porém nossa API irá continuar tentando o reenvio até que seja possível, seja pela emissão normal ou em contingência. Isto é feito de forma transparente aos clientes da API.

Porém, pode ocorrer uma situação em que o SEFAZ do estado fique indisponível no meio do processo de emissão de uma NFe. Neste momento nós não temos como saber se a nota foi autorizada ou não, até que a SEFAZ volte a ficar disponível.

Quando isto ocorre nós não esperamos a SEFAZ do estado voltar e reenviamos assim que possível para o ambiente de contingência, autorizando a nota e evitando a espera para o cliente final. Isto tem como efeito colateral que pode ser que a nota original tenha sido autorizada. Nossa API irá automaticamente detectar esta situação e proceder com o cancelamento da tentativa anterior. Por consequência, será natural haver um “pulo” de numeração percebido pelo cliente final.

O sistema cliente da API pode acompanhar este processo de forma transparente, conforme descrito na seção “Consulta” deste manual.

## Consulta

Para consultar uma NFe utilize a URL abaixo, alterando o ambiente de produção para homologação, caso esteja emitindo notas de teste.

Consultar as informações de uma NFe:

`https://api.focusnfe.com.br/v2/nfe/REFERENCIA`

Utilize o comando HTTP GET para consultar a sua nota para nossa API.

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
curl_setopt($ch, CURLOPT_URL, $server."/v2/nfe/" . $ref);
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

>Exemplo de resposta da consulta de NFe:

```json
{
  "status":"autorizado",
  "status_sefaz":"100",
  "mensagem_sefaz":"Autorizado o uso da NF-e",
  "cnpj_emitente":"SEU_CNPJ",
  "ref":"REFERENCIA",
  "chave_nfe":"NFe41170777627353999172550010000003871980884091",
  "numero":"387",
  "serie":"1",
  "caminho_xml_nota_fiscal":"/arquivos/733530172/201704/XMLs/41170777627353999172550010000003871980884091-nfe.xml",
  "caminho_danfe":"/arquivos/733530172/201704/DANFEs/41170777627353999172550010000003871980884091.pdf",
  "caminho_xml_carta_correcao": "/arquivos/733530172/201704/XMLs/41170777627353999172550010000003871980884091-cce-01.xml",
  "caminho_pdf_carta_correcao": "/notas_fiscais/NFe41170777627353999172550010000003871980884091/cartas_correcao/1.pdf",
  "numero_carta_correcao": 1
}
```

Campos de retorno:

* **status**: A situação da NFe, podendo ser:
  - **processando_autorizacao**: A nota ainda está em processamento pela API. Você deverá aguardar o processamento pela SEFAZ.
  - **autorizado**: A nota foi autorizada, neste caso é fornecido os dados completos da nota como chave e arquivos para download
  - **cancelado**: O documento foi cancelado, neste caso é fornecido o caminho para download do XML de cancelamento (caminho_xml_cancelamento).
  - **erro_autorizacao**: Houve um erro de autorização por parte da SEFAZ. A mensagem de erro você encontrará nos campos status_sefaz e mensagem_sefaz. É possível fazer o reenvio da nota com a mesma referência se ela estiver neste estado.
  - **denegado**: O documento foi denegado. Uma SEFAZ pode denegar uma nota se houver algum erro cadastral nos dados do destinatário ou do emitente. A mensagem de erro você encontrará nos campos status_sefaz e mensagem_sefaz. Não é possível reenviar a nota caso este estado seja alcançado pois é gerado um número, série, chave de NFe e XML para esta nota. O XML deverá ser armazenado pelo mesmo período de uma nota autorizada ou cancelada.
* **status_sefaz**: O status da nota na SEFAZ.
* **mensagem_sefaz**: Mensagem descritiva da SEFAZ detalhando o status.
* **serie**: A série da nota fiscal, caso ela tenha sido autorizada.
* **numero**: O número da nota fiscal, caso ela tenha sido autorizada.
* **cnpj_emitente**: O CNPJ emitente da nota fiscal (o CNPJ de sua empresa).
* **ref**:A referência da emissão.
* **chave_nfe**: A chave da NFe, caso ela tenha sido autorizada.
* **caminho_xml_nota_fiscal**: caso a nota tenha sido autorizada, retorna o caminho para download do XML.
* **caminho_danfe**: caso a nota tenha sido autorizada retorna o caminho para download do DANFe.
* **caminho_xml_carta_correcao**: caso tenha sido emitida alguma carta de correção, aqui aparecerá o caminho para fazer o download do XML.
* **caminho_pdf_carta_correcao**: caso tenha sido emitida alguma carta de correção, aqui aparecerá o caminho para fazer o download do PDF da carta.
* **numero_carta_correcao**: o número da carta de correção, caso tenha sido emitida.
* **caminho_xml_cancelamento**: Caso a nota esteja cancelada, é fornecido o caminho para fazer o download do XML de cancelamento.

Caso na requisição seja passado o parâmetro `completa=1` será informado mais dois campos:

* **requisicao_nota_fiscal**: Inclui os dados completos da requisição da nota fiscal, da mesma forma que constam no XML da nota.
* **protocolo_nota_fiscal**: Inclui os dados completos do protocolo devolvido pela SEFAZ.

### Reenvio Automático em Contingência – algumas considerações

Quando houver uma tentativa anterior de emissão, conforme descrito na seção “Reenvio automático em contingência”. A API irá devolver a chave `tentativa_anterior` que irá conter os seguintes campos:

* status: autorizado, processando_autorizacao ou cancelado. A API irá automaticamente proceder com o cancelamento quando necessário
* serie
* numero
* chave_nfe
* caminho_xml_nota_fiscal
* caminho_xml_cancelamento

## Cancelamento

Para cancelar uma NFe, basta fazer uma requisição à URL abaixo, alterando o ambiente de produção para homologação, caso esteja emitindo notas de teste.

Cancelar uma NFe já autorizada:

`https://api.focusnfe.com.br/v2/nfe/REFERENCIA`

Utilize o comando HTTP DELETE para cancelar a sua nota para nossa API. Este método é síncrono, ou seja, a comunicação com a SEFAZ será feita imediatamente e devolvida a resposta na mesma requisição.

O parâmetros de cancelamento deverão ser enviados da seguinte forma:

* **justificativa**: Justificativa do cancelamento. Deverá conter de 15 a 255 caracteres.

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
curl_setopt($ch, CURLOPT_URL, $server . "/v2/nfe/" . $ref);
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

A API irá em seguida devolver os seguintes campos:

* **status**: cancelado, se a nota pode ser cancelada, ou erro_cancelamento, se houve algum erro ao cancelar a nota.
* **status_sefaz**: O status do cancelamento na SEFAZ.
* **mensagem_sefaz**: Mensagem descritiva da SEFAZ detalhando o status.
* **caminho_xml_cancelamento**: Caso a nota tenha sido cancelada, será informado aqui o caminho para download do XML de cancelamento.

### Prazo de cancelamento
A NFe poderá ser cancelada em até 24 horas após a emissão. No entanto, alguns estados podem permitir um prazo maior para o cancelamento.

## Carta de Correção Eletrônica

Uma Carta de Correção eletrônica (CCe) pode ser utilizada para corrigir eventuais erros na NFe. As seguintes informações **não podem ser corrigidas**:

* As variáveis que determinam o valor do imposto tais como: base de cálculo, alíquota, diferença de preço, quantidade, valor da operação ou da prestação;
* A correção de dados cadastrais que implique mudança do remetente ou do destinatário;
* A data de emissão ou de saída.

Não existe prazo especificado para emissão de cartas de correção. É possível enviar até 20 correções diferentes, sendo que será válido sempre a última correção enviada.

### Emissão de CCe

`https://api.focusnfe.com.br/v2/nfe/REFERENCIA/carta_correcao`

Utilize o comando HTTP POST para enviar a sua nota para nossa API. Este método é **síncrono**, ou seja, a comunicação com a SEFAZ será feita imediatamente e devolvida a resposta na mesma requisição.

O parâmetros da carta de correção deverão ser enviados da seguinte forma:

* **correcao**: Texto da carta de correção. Deverá conter de 15 a 255 caracteres.
* **data_evento**: Campo opcional. Data do evento da carta de correção. Se não informado será usado a data atual

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
$correcao = array (
  "correcao" => "Teste de carta de correcao",
);
// Inicia o processo de envio das informações usando o cURL.
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $server . "/v2/nfe/" . $ref  . "/carta_correcao");
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($correcao));
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

A API irá em seguida devolver os seguintes campos:

* **status**: autorizado, se a carta de correção foi aceita pela SEFAZ, ou erro_autorizacao, se houve algum erro ao cancelar a nota.
* **status_sefaz**: O status da carta de correção na SEFAZ.
* **mensagem_sefaz**: Mensagem descritiva da SEFAZ detalhando o status.
* **caminho_xml_carta_correcao**: Informa o caminho do XML da carta de correção, caso ela tenha sido autorizada.
* **caminho_pdf_carta_correcao**: Informa o caminho do PDF da carta de correção, caso ela tenha sido autorizada.
* **numero_carta_correcao**: Informa o número da carta de correção, caso ela tenha sido autorizada.

Para uma mesma nota fiscal é possível enviar mais de uma carta de correção, até o limite de 20 correções, sendo que a última sempre substitui a anterior.

## Reenvio de email


```php
<?php
/* Você deve definir isso globalmente para sua aplicação
Para ambiente de produção utilize e a variável abaixo:
$server = "https://api.focusnfe.com.br"; */
$server = "http://homologacao.acrasnfe.acras.com.br";
// Substituir a variável, ref, pela sua identificação interna de nota.
$ref = "12345";
$login = "token_enviado_pelo_suporte";
$password = "";
$email = array (
  "emails" => array(
    "email@email.com"
    )
  );
// Inicia o processo de envio das informações usando o cURL.
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $server."/v2/nfe/" . $ref . "/email");
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($email));
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

Para cada nota autorizada, cancelada ou que tenha sido emitida uma carta de correção o destinatário da nota é notificado via email. Porém eventualmente pode ser necessário enviar a nota fiscal para outras pessoas ou mesmo reenviar o email para o mesmo destinatário.

Para enviar um ou mais emails:

`https://api.focusnfe.com.br/v2/nfe/REFERENCIA/email`

Utilize o comando HTTP POST para enviar os emails. Esta operação aceita apenas um parâmetro:

* **emails**: Array com uma lista de emails que deverão receber uma cópia da nota. Limitado a 10 emails por vez.

A API imediatamente devolve a requisição com a confirmação dos emails. Os emails serão enviados em segundo plano, por isso pode levar alguns minutos até que eles cheguem à caixa postal.

## Inutilização

Em uma situação normal você não precisará informar ao SEFAZ a inutilização de um número da NFe, pois a API controla automaticamente a numeração das notas. Porém, se por alguma situação específica for necessário a inutilização de alguma faixa de números você poderá chamar as seguintes operações:

Envio de inutilização de faixa de numeração:

`https://api.focusnfe.com.br/v2/nfe/inutilizacao`

Utilize o comando HTTP POST para enviar a sua inutilização para nossa API. Este método é **síncrono**, ou seja, a comunicação com a SEFAZ será feita imediatamente e devolvida a resposta na mesma requisição.

A inutilização precisa dos seguintes parâmetros obrigatórios:

* **cnpj**: CNPJ da empresa emitente
* **serie**: Série da numeração da NFe que terá uma faixa de numeração inutilizada
* **numero_inicial**: Número inicial a ser inutilizado
* **numero_final**: Número final a ser inutilizado
* **justificativa**: Justificativa da inutilização (mínimo 15 caracteres)

```php
<?php
/* Você deve definir isso globalmente para sua aplicação.
Para ambiente de produção utilize e a variável abaixo:
$server = "https://api.focusnfe.com.br"; */
$server = "http://homologacao.acrasnfe.acras.com.br";
// Substituir a variável, ref, pela sua identificação interna de nota.
$login = "token_enviado_pelo_suporte";
$password = "";
$inutiliza = array (
  "cnpj" => "51916585000125",
  "serie" => "1",
  "numero_inicial" => "7",
  "numero_final" => "9",
  "justificativa" => "Teste de inutilizacao denota"  
);
// Inicia o processo de envio das informações usando o cURL.
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $server."/v2/nfe/inutilizacao");
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($inutiliza));
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

A API irá enviar uma resposta com os seguintes campos:

* **status**: autorizado, se a inutilização foi aceita pela SEFAZ, ou erro_autorizacao, se houve algum erro ao inutilizar os números.
* **status_sefaz**: O status da carta de correção na SEFAZ.
* **mensagem_sefaz**: Mensagem descritiva da SEFAZ detalhando o status.
* **serie**: Série da numeração da NFe que terá uma faixa de numeração inutilizada
* **numero_inicial**: Número inicial a ser inutilizado
* **numero_final**: Número final a ser inutilizado
* **caminho_xml**: Caminho do XML para download caso a inutilização tenha sido autorizada pela SEFAZ.

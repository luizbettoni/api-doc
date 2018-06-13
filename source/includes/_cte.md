
# CTe e CTe OS (beta)


Através da API CTe é possível:

* Emitir CTe (Conhecimento de Transporte Eletrônico) utilizando dados simplificados. Este processo é **assíncrono**. Ou seja, após a emissão a nota será enfileirada para processamento.
* Emitir CTe OS (outros serviços) utilizando dados simplificados. Este processo é **síncrono**. Ou seja, na mesma requisição é feito processamento da CTe.
* Cancelar uma CTe de qualquer modelo.
* Consultar o status de CTe emitidas.
* Emitir os eventos: carta de correção, prestação em desacordo, registro multimodal e informações GTV (apenas CTe OS)
* Inutilizar uma faixa de numeração de CTe de qualquer modelo

## URLs


Método | URL (recurso) | Ação
-------|-------|-----
POST |	/v2/cte?ref=REFERENCIA	| Cria uma CTe a envia para processamento.
POST |	/v2/cte_os?ref=REFERENCIA	| Emite uma CTe OS.
GET	 | /v2/cfe/REFERENCIA	| Consulta a CTe com a referência informada e o seu status de processamento
DELETE |	/v2/cfe/REFERENCIA	| Cancela uma CTe com a referência informada
POST |	/v2/cte/REFERENCIA/carta_correcao	| Cria uma carta de correção para a CTe com a referência informada.
POST |	/v2/cte/inutilizacao	| Inutiliza uma numeração da CTe

## Campos de uma CTe

>> Abaixo um exemplo de dados de uma CTe:

```json

{
  "modal_aereo": {
    "numero_minuta": "000001234",
    "numero_operacional": "12345678901",
    "data_prevista_entrega": "2018-01-01",
    "dimensao_carga": "1234X1234X1234",
    "informacoes_manuseio": "03",
    "classe_tarifa": "G",
    "codigo_tarifa": "123",
    "valor_tarifa": "123.00"
  },
  "cfop": "5353",
  "natureza_operacao": "PREST. DE SERV. TRANSPORTE A ESTAB. COMERCIAL",
  "data_emissao": "2018-05-17T11:13:04-03:00",
  "tipo_documento": 0,
  "codigo_municipio_envio": "2927408",
  "municipio_envio": "Salvador",
  "uf_envio": "BA",
  "codigo_municipio_inicio": 2927408,
  "tipo_servico": 0,
  "municipio_inicio": "Salvador",
  "uf_inicio": "BA",
  "codigo_municipio_fim": "2927408",
  "municipio_fim": "Salvador",
  "uf_fim": "BA",
  "retirar_mercadoria": "0",
  "detalhes_retirar": "Teste detalhes retirar",
  "indicador_inscricao_estadual_tomador": "9",
  "tomador": "3",
  "caracterisca_adicional_transporte": "c.adic.transp.",
  "caracterisca_adicional_servico": "Teste caract add servico",
  "funcionario_emissor": "func.emiss",
  "codigo_interno_origem": "Teste codigo interno origem",
  "codigo_interno_passagem": "codIntPass",
  "codigo_interno_destino": "Teste codigo interno destino",
  "codigo_rota": "cod rota",
  "tipo_programacao_entrega": "0",
  "sem_hora_tipo_hora_programada": "0",
  "cnpj_emitente": "11111451000111",
  "cpf_remetente": "08111727908",
  "nome_remetente": "CT-E EMITIDO EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL",
  "telefone_remetente": "7734629600",
  "logradouro_remetente": "R. XYZ",
  "numero_remetente": "1205",
  "bairro_remetente": "Vila Perneta",
  "codigo_municipio_remetente": "4119152",
  "municipio_remetente": "Pinhais",
  "uf_remetente": "PR",
  "cep_remetente": "83124310",
  "codigo_pais_remetente": "1058",
  "pais_remetente": "Brasil",
  "cnpj_destinatario": "00112222000149",
  "inscricao_estadual_destinatario": "02220020926081",
  "nome_destinatario": "CT-E EMITIDO EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL",
  "telefone_destinatario": "7333332600",
  "logradouro_destinatario": "R. Alto Parana",
  "numero_destinatario": "190",
  "bairro_destinatario": "Sao Cristovao",
  "codigo_municipio_destinatario": "2927408",
  "municipio_destinatario": "Salvador",
  "uf_destinatario": "BA",
  "cep_destinatario": "83222380",
  "codigo_pais_destinatario": "1058",
  "pais_destinatario": "Brasil",
  "email_destinatario": "fiscal@example.com",
  "valor_total": "1500.00",
  "valor_receber": "750.00",
  "icms_situacao_tributaria": "00",
  "icms_base_calculo": "50635.27",
  "icms_aliquota": "17.00",
  "icms_valor": "8608.00",
  "valor_total_carga": "200000.00",
  "produto_predominante": "teste produto carga",
  "outras_caracteristicas_carga": "teste caracteristicas carga",
  "cargas": [
    {
      "codigo_unidade_medida": "01",
      "tipo_medida": "PESO BRUTO",
      "quantidade": "1.0000"
    },
    {
      "codigo_unidade_medida": "02",
      "tipo_medida": "PESO BRUTO",
      "quantidade": "2.0000"
    }
  ],
  "valor_carga_averbacao": "200000.00",
  "nfes": [
    {
      "chave_nfe": "35122225222278000855550010000002821510931504",
      "pin_suframa": "1234",
      "data_prevista": "2018-05-07"
    }
  ],
  "valor_original_fatura": "12000.00",
  "valor_desconto_fatura": "1000.00",
  "valor_liquido_fatura": "11000.00",
  "duplicatas": [
    {
      "data_vencimento": "2018-05-07",
      "valor_duplicata": "13000.00"
    }
  ]
}
```


A CTe possui vários campos para os mais variados tipos e formas de operações, por isso, criamos uma página exclusiva que mostra todos os campos da nossa API para o envio de CTe. Nela, você pode buscar os campos pela TAG XML ou pela nossa tradução para API.

[Documentação completa dos campos CTe](https://focusnfe.com.br/dsl/3.0/ConhecimentoTransporteXML.html)

[Documentação completa dos campos CTe OS](https://focusnfe.com.br/dsl/3.0/ConhecimentoTransporteOsXML.html)

Além dos campos descritos acima, cada CTe deverá obrigatoriamente informar um **modal**, que é a forma de transporte da carga. Você deverá informar uma das seguintes chaves nos dados, clique em cada link para visualizar os campos completos:

* modal_rodoviario para transporte rodoviário. [Consulte campos para CTe](https://focusnfe.com.br/dsl/3.0/TransporteRodoviarioXML.html) e [Consulte campos para CTe OS](https://focusnfe.com.br/dsl/3.0/TransporteRodoviarioOsXML.html)
* modal_aereo [para transporte aéreo.] (https://focusnfe.com.br/dsl/3.0/TransporteAereoXML.html)
* modal_aquaviario [para transporte aquaviário.] (https://focusnfe.com.br/dsl/3.0/TransporteAquaviarioXML.html)
* modal_ferroviario [para transporte ferroviário.] (https://focusnfe.com.br/dsl/3.0/TransporteFerroviarioXML.html)
* modal_dutoviario [para transporte dutoviário.] (https://focusnfe.com.br/dsl/3.0/TransporteDutoviarioXML.html)
* modal_multimodal [para transporte que utilize mais de um modal.] (https://focusnfe.com.br/dsl/3.0/TransporteMultimodalXML.html)

Para CTe-OS é necessário informar dados adicionais do modal **apenas quando este for rodoviário**. Nos outros casos não é necessário.


## Envio

```shell
# arquivo.json deve conter os dados da CTe
curl -u token_enviado_pelo_suporte: \
  -X POST -T cte.json http://homologacao.acrasnfe.acras.com.br/v2/cte?ref=12345
curl -u token_enviado_pelo_suporte: \
  -X POST -T cte_os.json http://homologacao.acrasnfe.acras.com.br/v2/cte_os?ref=12345
```

Para enviar uma CTe utilize a URL abaixo, alterando o ambiente de produção para homologação, caso esteja emitindo notas de teste.

Envia uma CTe para autorização:

`https://api.focusnfe.com.br/v2/cte?ref=REFERENCIA`

Utilize o comando HTTP POST para enviar a sua nota para nossa API. Envie como corpo do POST os dados em formato JSON da CTe.

Nesta etapa, é feita uma primeira validação dos dados da nota. Caso ocorra algum problema, por exemplo, algum campo faltante, formato incorreto
ou algum problema com o emitente a nota **não será aceita para processamento** e será devolvida a mensagem de erro apropriada. Veja a seção [erros](#introducao_erros).

Caso a nota seja validada corretamente, a nota será **aceita para processamento**. Isto significa que a nota irá para uma fila de processamento
onde eventualmente será processada (processamento assíncrono). Com isto, a nota poderá ser autorizada ou ocorrer um erro na autorização, de acordo com a validação da SEFAZ.

Para verificar se a nota já foi autorizada, você terá que efetuar uma [consulta](#cte_consulta).

Envia uma CTe OS para autorização:

`https://api.focusnfe.com.br/v2/cte_os?ref=REFERENCIA`

Utilize o comando HTTP POST para enviar a sua nota para nossa API. Ao contrátio da CTe convencional, a CTe OS é processada de forma **síncrona**, na mesma requição em que os dados são enviadas.


## Consulta

Para consultar uma CTe utilize a URL abaixo, alterando o ambiente de produção para homologação, caso esteja emitindo notas de teste.

Consultar as informações de uma CTe:

`https://api.focusnfe.com.br/v2/cte/REFERENCIA?completo=(0|1)`

Utilize o comando HTTP GET para consultar a sua nota para nossa API.

Parâmetro Opcional | Ação
-------|-------|-----
completo = 0 ou 1 | Habilita a API há mostrar campos adicionais na requisição de consulta.


```shell
curl -u token_enviado_pelo_suporte: \
  http://homologacao.acrasnfe.acras.com.br/v2/cte/12345
```

```
> Exemplo de resposta da consulta de CTe:

```json
{
    "cnpj_emitente": "11111151000119",
    "ref": "ref123",
    "status": "autorizado",
    "status_sefaz": "100",
    "mensagem_sefaz": "Autorizado o uso do CT-e",
    "chave": "CTe21111114611151000119570010000000111973476363",
    "numero": "11",
    "serie": "1",
    "modelo": "57",
    "caminho_xml": "https://focusnfe.s3-sa-east-1.amazonaws.com/arquivos_development/11111151000119/201805/XMLs/311110000007009_v03.00-protCTe.xml",
    "caminho_xml_carta_correcao": "https://focusnfe.s3-sa-east-1.amazonaws.com/arquivos_development/11111151000119/201805/XMLs/311110000007012_v03.00-eventoCTe.xml"
}
```

Campos de retorno:

* **cnpj_emitente**: O CNPJ emitente da CTe (o CNPJ de sua empresa).
* **ref**:A referência da emissão.
* **status**: A situação da CTe, podendo ser:
  - **processando_autorizacao**: A nota ainda está em processamento pela API. Você deverá aguardar o processamento pela SEFAZ.
  - **autorizado**: A nota foi autorizada, neste caso é fornecido os dados completos da nota como chave e arquivos para download
  - **cancelado**: O documento foi cancelado, neste caso é fornecido o caminho para download do XML de cancelamento (caminho_xml_cancelamento).
  - **erro_autorizacao**: Houve um erro de autorização por parte da SEFAZ. A mensagem de erro você encontrará nos campos status_sefaz e mensagem_sefaz. É possível fazer o reenvio da nota com a mesma referência se ela estiver neste estado.
  - **denegado**: O documento foi denegado. Uma SEFAZ pode denegar uma nota se houver algum erro cadastral nos dados do destinatário ou do emitente. A mensagem de erro você encontrará nos campos status_sefaz e mensagem_sefaz. Não é possível reenviar a nota caso este estado seja alcançado pois é gerado um número, série, chave de CTe e XML para esta nota. O XML deverá ser armazenado pelo mesmo período de uma nota autorizada ou cancelada.
* **status_sefaz**: O status da nota na SEFAZ.
* **mensagem_sefaz**: Mensagem descritiva da SEFAZ detalhando o status.
* **serie**: A série da CTe, caso ela tenha sido autorizada.
* **numero**: O número da CTe, caso ela tenha sido autorizada.
* **modelo**: O modelo da CTe, caso ela tenha sido autorizada.
* **chave_cte**: A chave da CTe, caso ela tenha sido autorizada.
* **caminho_xml_nota_fiscal**: caso a nota tenha sido autorizada, retorna o caminho para download do XML.
* **caminho_danfe**: caso a nota tenha sido autorizada retorna o caminho para download do DACTe.
* **caminho_xml**: caso tenha sido emitida alguma carta de correção, aqui aparecerá o caminho para fazer o download do XML.
* **caminho_xml_carta_correcao**: caso tenha sido emitida alguma carta de correção, aqui aparecerá o caminho para fazer o download do XML da carta.
* **caminho_xml_cancelamento**: Caso a nota esteja cancelada, é fornecido o caminho para fazer o download do XML de cancelamento.

Caso na requisição seja passado o parâmetro `completo=1` será adicionado mais 6 campos:

* **requisicao**: Inclui os dados completos da requisição da CTe, da mesma forma que constam no XML da nota.
* **protocolo**: Inclui os dados completos do protocolo devolvido pela SEFAZ.
* **requisicao_cancelamento**: Inclui os dados completos da requisição de cancelamento da CTe.
* **protocolo_cancelamento**: Inclui os dados completos do protocolo devolvido pela SEFAZ.
* **requisicao_carta_correcao**: Inclui os dados completos da requisição de Carta de Correção Eletrônica da CTe.
* **protocolo_carta_correcao**: Inclui os dados completos do protocolo devolvido pela SEFAZ.

> Exemplo de campos extras na consulta completa

```json
{

  "cnpj_emitente": "11111151000119",
  "ref": "ref123",
  "status": "autorizado",
  "status_sefaz": "100",
  "mensagem_sefaz": "Autorizado o uso do CT-e",
  "chave": "CTe21111114611151000119570010000000111973476363",
  "numero": "11",
  "serie": "1",
  "modelo": "57",
  "caminho_xml": "https://focusnfe.s3-sa-east-1.amazonaws.com/arquivos_development/11111151000119/201805/XMLs/311110000007009_v03.00-protCTe.xml",
  "caminho_xml_carta_correcao": "https://focusnfe.s3-sa-east-1.amazonaws.com/arquivos_development/11111151000119/201805/XMLs/311110000007012_v03.00-eventoCTe.xml"
  "requisicao": {
    /* campos da CTe aqui omitida */
  }
  "protocolo": {
    "versao": "3.00",
    "id_tag": "CTe329180000007009",
    "ambiente": "2",
    "versao_aplicativo": "RS20180430143216",
    "chave": "21111114611151000119570010000000111973476363",
    "data_recimento": "2018-05-10T15:23:36-03:00",
    "protocolo": "329180000007009",
    "digest_value": "PsPzcf7bCOwvNW+v2F+ZAzJPXJE=",
    "status": "100",
    "motivo": "Autorizado o uso do CT-e"
  },
  "requisicao_carta_correcao": {
    "versao": "3.00",
    "id_tag": "ID21111114611151000119570010000000111973476363",
    "codigo_orgao": "29",
    "ambiente": "2",
    "cnpj": "14674451000119",
    "chave_cte": "21111114611151000119570010000000111973476363",
    "data_evento": "2018-05-10T16:25:42-03:00",
    "tipo_evento": "110110",
    "numero_sequencial_evento": "1",
    "versao_evento": "3.00"
  },
  "protocolo_carta_correcao": {
    "versao": "3.00",
    "id_tag": "ID329180000007012",
    "ambiente": "2",
    "versao_aplicativo": "RS20171205135830",
    "codigo_orgao": "29",
    "status": "135",
    "motivo": "Evento registrado e vinculado a CT-e",
    "chave_cte": "21111114611151000119570010000000111973476363",
    "tipo_evento": "110110",
    "descricao_evento": "Carta Correção Registrada",
    "numero_sequencial_evento": "1",
    "data_evento": "2018-05-10T16:25:43-03:00",
    "protocolo": "329180000007012"
  }
}
```


## Cancelamento

```shell
curl -u token_enviado_pelo_suporte: \
  -X DELETE -d '{"justificativa":"Teste de cancelamento de nota"}' \
  http://homologacao.acrasnfe.acras.com.br/v2/cte/12345
```


> Resposta da API para a requisição de cancelamento:

```json
{
  "status_sefaz": "135",
  "mensagem_sefaz": "Evento registrado e vinculado a CT-e",
  "status": "cancelado",
  "caminho_xml": "https://focusnfe.s3-sa-east-1.amazonaws.com/arquivos_development/14674451000119/201805/XMLs/329180000006929_v03.00-eventoCTe.xml"
}
```

Para cancelar uma CTe, basta fazer uma requisição à URL abaixo, alterando o ambiente de produção para homologação, caso esteja emitindo notas de teste.

Cancelar uma CTe já autorizada:

`https://api.focusnfe.com.br/v2/cte/REFERENCIA`

Utilize o comando HTTP DELETE para cancelar a sua nota para nossa API. Este método é síncrono, ou seja, a comunicação com a SEFAZ será feita imediatamente e devolvida a resposta na mesma requisição.

O parâmetros de cancelamento deverão ser enviados da seguinte forma:

* **justificativa**: Justificativa do cancelamento. Deverá conter de 15 a 255 caracteres.


A API irá em seguida devolver os seguintes campos:

* **status**: cancelado, se a nota pode ser cancelada, ou erro_cancelamento, se houve algum erro ao cancelar a nota.
* **status_sefaz**: O status do cancelamento na SEFAZ.
* **mensagem_sefaz**: Mensagem descritiva da SEFAZ detalhando o status.
* **caminho_xml**: Caso a nota tenha sido cancelada, será informado aqui o caminho para download do XML de cancelamento.

### Prazo de cancelamento
A CTe poderá ser cancelada em até 7 dias após a emissão, na maioria dos Estados.

## Carta de Correção Eletrônica

Uma Carta de Correção eletrônica (CCe) pode ser utilizada para corrigir eventuais erros na CTe. As seguintes informações **não podem ser corrigidas**:

* As variáveis que determinam o valor do imposto tais como: base de cálculo, alíquota, diferença de preço, quantidade, valor da operação ou da prestação;
* A correção de dados cadastrais que implique mudança do remetente ou do destinatário;
* A data de emissão ou de saída.

Não existe prazo especificado para emissão de cartas de correção. É possível enviar até 20 correções diferentes, sendo que será válido sempre a última correção enviada.

### Emissão de CCe

```shell
curl -u token_enviado_pelo_suporte: \
  -X POST -d '{"campo_corrigido":"observacoes","valor_corrigido":"Nova observação"}' \
  http://homologacao.acrasnfe.acras.com.br/v2/cte/12345/carta_correcao
```

> Resposta da API para a requisição de CCe:

```json

{
  "status_sefaz": "135",
  "mensagem_sefaz": "Evento registrado e vinculado a CT-e",
  "status": "autorizado",
  "caminho_xml": "https://focusnfe.s3-sa-east-1.amazonaws.com/arquivos_development/11111151000119/201805/XMLs/321110000006913_v03.00-eventoCTe.xml",
  "numero_carta_correcao": 2
}

```

`https://api.focusnfe.com.br/v2/cte/REFERENCIA/carta_correcao`

Utilize o comando HTTP POST para enviar a sua correção para nossa API. Este método é **síncrono**, ou seja, a comunicação com a SEFAZ será feita imediatamente e devolvida a resposta na mesma requisição.

Ao contrário da NFe, na CTe é obrigatório informar especificamente o campo que será alterado. Você poderá usar os próprios nomes
dos campos da API.

O parâmetros da carta de correção deverão ser enviados da seguinte forma:

* **grupo_corrigido**: Opcional. Indica o grupo onde se encontra o campo, por exemplo "cargas". Pode ser omitido se não houver grupo relacionado.
* **campo_corrigido**: Indica o campo a ser corrigido.
* **valor_corrigido**: Indica o novo valor do campo.
* **numero_item_grupo_corrigido**: Opcional. Caso o campo pertença a uma lista de itens, o número do item a ser corrigido é informado aqui. O primeiro número começa em 1.
* **campo_api**: Opcional. Se igual a 1 será usado o nome do campo da API nos campos 'grupo_corrigido' e 'campo_corrigido'. Se igual a 0 você deverá informar a tag XML. Valor default é 1.


A API irá em seguida devolver os seguintes campos:

* **status**: autorizado, se a carta de correção foi aceita pela SEFAZ, ou erro_autorizacao, se houve algum erro ao cancelar a nota.
* **status_sefaz**: O status da carta de correção na SEFAZ.
* **mensagem_sefaz**: Mensagem descritiva da SEFAZ detalhando o status.
* **caminho_xml**: Informa o caminho do XML da carta de correção, caso ela tenha sido autorizada.
* **numero_carta_correcao**: Informa o número da carta de correção, caso ela tenha sido autorizada.

Para uma mesma CTe é possível enviar mais de uma carta de correção, sendo que a última sempre substitui a anterior.

## Inutilização

> Resposta da API para a requisição de inutilização:

```json
 {
  "status_sefaz": "102",
  "mensagem_sefaz": "Inutilizacao de numero homologado",
  "serie": "3",
  "numero_inicial": "800",
  "numero_final": "801",
  "status": "autorizado",
  "caminho_xml": "https://focusnfe.s3-sa-east-1.amazonaws.com/arquivos_development/11111353000900/207701/XMLs/999992335309999955003000000800000000801-inu.xml"
}
```


Em uma situação normal você não precisará informar ao SEFAZ a inutilização de um número da CTe, pois a API controla automaticamente a numeração das notas. Porém, se por alguma situação específica for necessário a inutilização de alguma faixa de números você poderá chamar as seguintes operações:

Envio de inutilização de faixa de numeração:

`https://api.focusnfe.com.br/v2/cte/inutilizacao`

Utilize o comando HTTP POST para enviar a sua inutilização para nossa API. Este método é **síncrono**, ou seja, a comunicação com a SEFAZ será feita imediatamente e devolvida a resposta na mesma requisição.

A inutilização precisa dos seguintes parâmetros obrigatórios:

* **cnpj**: CNPJ da empresa emitente
* **serie**: Série da numeração da CTe que terá uma faixa de numeração inutilizada
* **numero_inicial**: Número inicial a ser inutilizado
* **numero_final**: Número final a ser inutilizado
* **justificativa**: Justificativa da inutilização (mínimo 15 caracteres)
* **modelo**: Informe o modelo da CTe. Se igual a 57 será a CTe normal, se igual a 67 será a CTe OS. Valor default é 57.


A API irá enviar uma resposta com os seguintes campos:

* **status**: autorizado, se a inutilização foi aceita pela SEFAZ, ou erro_autorizacao, se houve algum erro ao inutilizar os números.
* **status_sefaz**: O status da carta de correção na SEFAZ.
* **mensagem_sefaz**: Mensagem descritiva da SEFAZ detalhando o status.
* **serie**: Série da numeração da CTe que terá uma faixa de numeração inutilizada
* **numero_inicial**: Número inicial a ser inutilizado
* **numero_final**: Número final a ser inutilizado
* **caminho_xml**: Caminho do XML para download caso a inutilização tenha sido autorizada pela SEFAZ.


# NFe


Através da API NFe é possível:

* Emitir NFe utilizando dados simplificados. Este processo é **assíncrono**. Ou seja, após a emissão a nota será enfileirada para processamento.
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

## Campos obrigatórios de uma NFe

Atualmente, a NFe possui centenas de campos para os mais variados tipos e formas de operações, por isso, criamos uma página exclusiva que mostra todos os campos da nossa API para o envio de NFe. Nela, você pode buscar os campos pela TAG XML ou pela nossa tradução para API.

[Documentação completa dos campos (versão 4.00 da NFe)](https://focusnfe.com.br/nfe/4.0/NotaFiscalXML.html)

[Documentação completa dos campos – versão 3.10 da NFe – Disponível até 2/abril/2018](https://focusnfe.com.br/nfe/lang/NotaFiscalXML.html)

Abaixo, iremos mostrar os campos de uso obrigatório para emissão de uma Nota Fiscal Eletrônica.

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

### Geral

* <strong>natureza_operacao</strong>: Descrição da natureza da operação a ser realizada pela nota fiscal.
* <strong>forma_pagamento</strong>: Forma de pagamento utilizado no operação. Valores possíveis:

0 – à vista;

1 – à prazo;

2 – outros.

* <strong>data_emissao</strong>: Data da emissão da NFe. Formato padrão ISO, exemplo: “2016-12-25T12:00-0300”.
* <strong>tipo_documento</strong>: Tipo da NFe. Valores possíveis:

0 – Nota Fiscal de Entrada;

1 – Nota Fiscal de Saída.

* <strong>local_destino</strong>: Local onde a operação irá acontecer. Valores possíveis:

0 – Operação interna;

1 – Operação interestadual;

2 – Operação com exterior.

* <strong>finalidade_emissao</strong>: Indicar qual a finalidade da emissão da nota. Valores possíveis:

1 – Normal;

2 – Complementar;

3 – Nota de ajuste;

4 – Devolução.

* <strong>consumidor_final</strong>: Indicar se a operação é com consumidor final. Valores possíveis:

0 – Normal;

1 – Consumidor final.

* <strong>presenca_comprador</strong>: Informar como foi a presença do comprador. Valores possíveis:

0 – Não se aplica (por exemplo, para a Nota Fiscal complementar ou de ajuste);

1 – Operação presencial;

2 – Operação não presencial, pela Internet;

3 – Operação não presencial, Teleatendimento;

4 – NFC-e em operação com entrega em domicílio;

9 – Operação não presencial, outros.

### Emitente

* <strong>cnpj_emitente</strong>: CNPJ do emitente da nota.
* <strong>inscricao_estadual_emitente</strong>: Informar a Inscrição Estadual do emitente.
* <strong>logradouro_emitente</strong>: Logradouro do emitente.
* <strong>numero_emitente</strong>: Número do logradouro do emitente.
* <strong>bairro_emitente</strong>: Bairro do emitente.
* <strong>municipio_emitente</strong>: Município do emitente.
* <strong>uf_emitente</strong>: UF do emitente.
* <strong>regime_tributario_emitente</strong>: Informar qual o regime tributário do emitente. Valores possíveis:

1 – Simples Nacional;

2 – Simples Nacional – excesso de sublimite de receita bruta;

3 – Regime Normal.

### Destinatário
* <strong>nome_destinatario</strong>: Nome completo do destinatário.
* <strong>cnpj_destinatario</strong>: CNPJ da empresa destinatária.
* <strong>cpf_destinatario</strong>: CPF do destinatário. Caso utilize este campo, não enviar o campo “cnpf_destinatario”.
* <strong>inscricao_estadual_destinatario</strong>: Informar a Inscrição Estadual do destinatário.
* <strong>logradouro_destinatario</strong>: Logradouro do destinatário.
* <strong>numero_destinatario</strong>: Número do logradouro do destinatário.
* <strong>bairro_destinatario</strong>: Bairro do destinatário.
* <strong>municipio_destinatario</strong>: Município do destinatário.
* <strong>uf_destinatario</strong>: UF do destinatário.
* <strong>indicador_inscricao_estadual_destinatario</strong>: Indicador da Inscrição Estadual do destinatário. Valores possíveis:

1 – Contribuinte ICMS (informar a IE do destinatário);

2 – Contribuinte isento de Inscrição no cadastro de Contribuintes do ICMS;

9 – Não Contribuinte, que pode ou não possuir Inscrição Estadual no Cadastro de Contribuintes do ICMS.

### Itens
Uma NFe irá conter um ou mais itens no campo “items” que poderão conter os campos abaixo:

* <strong>numero_item</strong>: Numeração que indica qual a posição do item na nota, deve ser usado numeração sequencial a partir do número “1”.
* <strong>codigo_produto</strong>: Código do produto.
* <strong>descricao</strong>: Descrição do produto.
* <strong>cfop</strong>: Código Fiscal da Operação, CFOP da operação válido para NFe.
* <strong>quantidade_comercial</strong>: Quantidade da mercadoria.
* <strong>quantidade_tributavel</strong>: Quantidade tributavel da mercadoria. Caso não se aplique, utilize o mesmo valor do campo quantidade_comercial.
* <strong>valor_unitario_comercial</strong>: Valor unitário da mercadoria.
* <strong>valor_unitario_tributavel</strong>: Valor unitário tributável da mercadoria. Caso não se aplique, utilize o mesmo valor do campo valor_unitario_comercial.
* <strong>unidade_comercial</strong>: Unidade comercial do produto. Você pode utilizar valores como “KG”, “L”, “UN” entre outros. * Caso não se aplique, use “UN”.
* <strong>unidade_tributavel</strong>: Unidade tributável do produto. Caso não se aplique, utilize o mesmo valor do campo unidade_comercial.
* <strong>valor_bruto</strong>: Valor bruto do produto.
* <strong>código_ncm</strong>: Código NCM do produto. Este código possui 8 dígitos.
* <strong>inclui_no_total</strong>: Valor do item (valor_bruto) compõe valor total da NFe (valor_produtos)?. Valores possíveis:

0 – Não;

1 – Sim.

* <strong>icms_origem</strong>: Informar a origem do ICMS. Valores possíveis:

0 – Nacional;

1 – Estrangeira (importação direta);

2 – Estrangeira (adquirida no mercado interno);

3 – Nacional com mais de 40% de conteúdo estrangeiro;

4 – Nacional produzida através de processos produtivos básicos;

5 – Nacional com menos de 40% de conteúdo estrangeiro;

6 – Estrangeira (importação direta) sem produto nacional similar;

7 – Estrangeira (adquirida no mercado interno) sem produto nacional similar;

* <strong>icms_situacao_tributaria</strong>: Informar qual a situação do ICMS para a operação. Valores possíveis:

00 – Tributada integralmente;

10 – Tributada e com cobrança do ICMS por substituição tributária;

20 – Tributada com redução de base de cálculo;

30 – Isenta ou não tributada e com cobrança do ICMS por substituição tributária;

40 – Isenta;

41 – Não tributada;

50 – Suspensão;

51 – Diferimento (a exigência do preenchimento das informações do ICMS diferido fica a critério de cada UF);

60 – Cobrado anteriormente por substituição tributária;

70 – Tributada com redução de base de cálculo e com cobrança do ICMS por substituição tributária;
90 – Outras (regime Normal);

101 – Ttributada pelo Simples Nacional com permissão de crédito;

102 – Tributada pelo Simples Nacional sem permissão de crédito;

103 – Isenção do ICMS no Simples Nacional para faixa de receita bruta;

201 – Tributada pelo Simples Nacional com permissão de crédito e com cobrança do ICMS por substituição tributária;

202 – Tributada pelo Simples Nacional sem permissão de crédito e com cobrança do ICMS por substituição tributária;

203 – Isenção do ICMS nos Simples Nacional para faixa de receita bruta e com cobrança do ICMS por substituição tributária;

300 – Imune;

400 – Não tributada pelo Simples Nacional;

500 – ICMS cobrado anteriormente por substituição tributária (substituído) ou por antecipação;

900 – Outras (regime Simples Nacional);

pis_situacao_tributaria: Informar qual a situação do PIS para a operação. Valores possíveis:
01 – Operação tributável: base de cálculo = valor da operação (alíquota normal – cumulativo/não cumulativo);

02 – Operação tributável: base de cálculo = valor da operação (alíquota diferenciada);

03 – Operação tributável: base de cálculo = quantidade vendida × alíquota por unidade de produto;

04 – Operação tributável: tributação monofásica (alíquota zero);

05 – Operação tributável: substituição tributária;

06 – Operação tributável: alíquota zero;

07 – Operação isenta da contribuição;

08 – Operação sem incidência da contribuição;

09 – Operação com suspensão da contribuição;

49 – Outras operações de saída;

50 – Operação com direito a crédito: vinculada exclusivamente a receita tributada no mercado interno;

51 – Operação com direito a crédito: vinculada exclusivamente a receita não tributada no mercado interno;

52 – Operação com direito a crédito: vinculada exclusivamente a receita de exportação;

53 – Operação com direito a crédito: vinculada a receitas tributadas e não-tributadas no mercado interno;

54 – Operação com direito a crédito: vinculada a receitas tributadas no mercado interno e de exportação;

55 – Operação com direito a crédito: vinculada a receitas não-tributadas no mercado interno e de exprtação;

56 – Operação com direito a crédito: vinculada a receitas tributadas e não-tributadas no mercado interno e de exportação;

60 – Crédito presumido: operação de aquisição vinculada exclusivamente a receita tributada no mercado interno;

61 – Crédito presumido: operação de aquisição vinculada exclusivamente a receita não-tributada no mercado interno;

62 – Crédito presumido: operação de aquisição vinculada exclusivamente a receita de exportação;

63 – Crédito presumido: operação de aquisição vinculada a receitas tributadas e não-tributadas no mercado interno;

64 – Crédito presumido: operação de aquisição vinculada a receitas tributadas no mercado interno e de exportação;

65 – Crédito presumido: operação de aquisição vinculada a receitas não-tributadas no mercado interno e de exportação;

66 – Crédito presumido: operação de aquisição vinculada a receitas tributadas e não-tributadas no mercado interno e de exportação;

67 – Crédito presumido: outras operações;

70 – Operação de aquisição sem direito a crédito;

71 – Operação de aquisição com isenção;

72 – Operação de aquisição com suspensão;

73 – Operação de aquisição a alíquota zero;

74 – Operação de aquisição sem incidência da contribuição;

75 – Operação de aquisição por substituição tributária;

98 – Outras operações de entrada;

99 – Outras operações;

* <strong>cofins_situacao_tributaria</strong>: Informar qual a situação do CONFINS para a operação. Valores possíveis:

01 – Operação tributável: base de cálculo = valor da operação (alíquota normal – cumulativo/não cumulativo);

02 – Operação tributável: base de cálculo = valor da operação (alíquota diferenciada);

03 – Operação tributável: base de cálculo = quantidade vendida × alíquota por unidade de produto;

04 – Operação tributável: tributação monofásica (alíquota zero);

05 – Operação tributável: substituição tributária;

06 – Operação tributável: alíquota zero;

07 – Operação isenta da contribuição;

08 – Operação sem incidência da contribuição;

09 – Operação com suspensão da contribuição;

49 – Outras operações de saída;

50 – Operação com direito a crédito: vinculada exclusivamente a receita tributada no mercado interno;

51 – Operação com direito a crédito: vinculada exclusivamente a receita não tributada no mercado

interno;

52 – Operação com direito a crédito: vinculada exclusivamente a receita de exportação;

53 – Operação com direito a crédito: vinculada a receitas tributadas e não-tributadas no mercado interno;

54 – Operação com direito a crédito: vinculada a receitas tributadas no mercado interno e de exportação;

55 – Operação com direito a crédito: vinculada a receitas não-tributadas no mercado interno e de exportação;

56 – Operação com direito a crédito: vinculada a receitas tributadas e não-tributadas no mercado interno e de exportação;

60 – Crédito presumido: operação de aquisição vinculada exclusivamente a receita tributada no mercado interno;

61 – Crédito presumido: operação de aquisição vinculada exclusivamente a receita não-tributada no mercado interno;

62 – Crédito presumido: operação de aquisição vinculada exclusivamente a receita de exportação;

63 – Crédito presumido: operação de aquisição vinculada a receitas tributadas e não-tributadas no mercado interno;

64 – Crédito presumido: operação de aquisição vinculada a receitas tributadas no mercado interno e de exportação;

65 – Crédito presumido: operação de aquisição vinculada a receitas não-tributadas no mercado interno e de exportação;

66 – Crédito presumido: operação de aquisição vinculada a receitas tributadas e não-tributadas no mercado interno e de exportação;

67 – Crédito presumido: outras operações;

70 – Operação de aquisição sem direito a crédito;

71 – Operação de aquisição com isenção;

72 – Operação de aquisição com suspensão;

73 – Operação de aquisição a alíquota zero;

74 – Operação de aquisição sem incidência da contribuição;

75 – Operação de aquisição por substituição tributária;

98 – Outras operações de entrada;

99 – Outras operações;

* <strong>icms_base_calculo</strong>: Valor total da base de cálculo do ICMS. Assume zero se não informado.
* <strong>icms_valor_total</strong>: Valor total do ICMS. Assume zero se não informado.
* <strong>icms_base_calculo_st</strong>: Valor total da base de cálculo do ICMS do substituto tributário. Assume zero se não informado.
* <strong>icms_valor_total_st</strong>: Valor total do ICMS do substituto tributário. Assume zero se não informado.
* <strong>valor_produtos</strong>: Valor total dos produtos. Assume zero se não informado.
* <strong>valor_frete</strong>: Valor total do frete. Assume zero se não informado.
* <strong>valor_seguro</strong>: Valor total do seguro. Assume zero se não informado.
* <strong>valor_desconto</strong>: Valor total do desconto. Assume zero se não informado.
* <strong>valor_ipi</strong>: Valor total do IPI. Assume zero se não informado.
* <strong>valor_pis</strong>: Valor do PIS. Assume zero se não informado.
* <strong>valor_cofins</strong>: Valor do COFINS. Assume zero se não informado.
* <strong>valor_outras_despesas</strong>: Valor das despesas acessórias. Assume zero se não informado.
* <strong>valor_total</strong>: Valor total da nota fiscal.
* <strong>modalidade_frete</strong>: Indica a modalidade do frete da operação. Valores possíveis:

0 – Por conta do emitente;

1 – Por conta do destinatário;

2 – Por conta de terceiros;

9 – Sem frete;

## Envio


```shell
# arquivo.json deve conter os dados da NFe
curl -u token_enviado_pelo_suporte: \
  -X POST -T arquivo.json http://homologacao.acrasnfe.acras.com.br/v2/nfe
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

```java

import java.util.HashMap;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;

public class NFe_autorizar {

	public static void main(String[] args) throws JSONException{

		String login = "Token_enviado_pelo_suporte";

		/* Substituir pela sua identificação interna da nota. */
		String ref = "12345";

		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
 		String server = "http://homologacao.acrasnfe.acras.com.br/";

 		String url = server.concat("v2/nfe?ref="+ref);

		/* Configuração para realizar o HTTP BasicAuth. */
		Object config = new DefaultClientConfig();
		Client client = Client.create((ClientConfig) config);
		client.addFilter(new HTTPBasicAuthFilter(login, ""));

		/* Aqui são criados as hash's que receberão os dados da nota. */
		HashMap<String, String> nfe = new HashMap<String, String>();
		HashMap<String, String> itens = new HashMap<String, String>();

		nfe.put("data_emissao", "2018-01-16T09:38:00");
		nfe.put("natureza_operacao", "Remessa de Produtos");
		nfe.put("forma_pagamento", "0");
		nfe.put("tipo_documento", "1");
		nfe.put("finalidade_emissao", "1");
		nfe.put("cnpj_emitente", "51916585000125");
		nfe.put("nome_emitente", "ACME LTDA");
		nfe.put("nome_fantasia_emitente", "ACME TESTES");
		nfe.put("logradouro_emitente", "Rua Interventor Manoel Ribas");
		nfe.put("numero_emitente", "1355 ");
		nfe.put("bairro_emitente", "Santa Felicidade");
		nfe.put("municipio_emitente", "Curitiba");
		nfe.put("uf_emitente", "PR");
		nfe.put("cep_emitente", "82320030");
		nfe.put("telefone_emitente", "44912345678");
		nfe.put("inscricao_estadual_emitente", "1234567");
		nfe.put("nome_destinatario", "NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL");
		nfe.put("cpf_destinatario", "51966818092");
		nfe.put("inscricao_estadual_destinatario", "ISENTO");
		nfe.put("telefone_destinatario", "19912345678");
		nfe.put("logradouro_destinatario", "Rua Leonor Campos");
		nfe.put("numero_destinatario", "29");
		nfe.put("bairro_destinatario", "Swiss Park");
		nfe.put("municipio_destinatario", "Campinas");
		nfe.put("uf_destinatario", "SP");
		nfe.put("pais_destinatario", "Brasil");
		nfe.put("cep_destinatario", "13049555");
		nfe.put("icms_base_calculo", "0");
		nfe.put("icms_valor_total", "0");
		nfe.put("icms_base_calculo_st", "0");
		nfe.put("icms_valor_total_st", "0");
		nfe.put("icms_modalidade_base_calculo", "0");
		nfe.put("icms_valor", "0");
		nfe.put("valor_frete", "0");
		nfe.put("valor_seguro", "0");
		nfe.put("valor_total", "1");
		nfe.put("valor_produtos", "1");
		nfe.put("valor_desconto", "0.00");
		nfe.put("valor_ipi", "0");
		nfe.put("modalidade_frete", "1");
		itens.put("numero_item","128");
		itens.put("codigo_produto","1007");
		itens.put("descricao","Multi Mist 500g");
		itens.put("cfop","6102");
		itens.put("unidade_comercial","un");
		itens.put("quantidade_comercial","1");
		itens.put("valor_unitario_comercial","1");
		itens.put("valor_unitario_tributavel","1");
		itens.put("unidade_tributavel","un");
		itens.put("codigo_ncm","11041900");
		itens.put("valor_frete","0");
		itens.put("valor_desconto","0.00");
		itens.put("quantidade_tributavel","1");
		itens.put("valor_bruto","1");
		itens.put("icms_situacao_tributaria","103");
		itens.put("icms_origem","0");
		itens.put("pis_situacao_tributaria","07");
		itens.put("cofins_situacao_tributaria","07");
		itens.put("ipi_situacao_tributaria","53");
		itens.put("ipi_codigo_enquadramento_legal","999");

		/* Depois de fazer o input dos dados, são criados os objetos JSON já com os valores das hash's. */
		JSONObject json = new JSONObject (nfe);
		JSONObject JsonItens = new JSONObject (itens);

		/* Aqui adicionamos os objetos JSON nos campos da API como array no JSON principal. */
		json.append("items", JsonItens);

		/* É recomendado verificar como os dados foram gerados em JSON e se ele está seguindo a estrutura especificada em nossa documentação.
		System.out.print(json); */

		WebResource request = client.resource(url);

		ClientResponse resposta = request.post(ClientResponse.class, json);

		int HttpCode = resposta.getStatus();

		String body = resposta.getEntity(String.class);

		/* As três linhas a seguir exibem as informações retornadas pela nossa API.
		 * Aqui o seu sistema deverá interpretar e lidar com o retorno. */
		System.out.print("HTTP Code: ");
		System.out.print(HttpCode);
		System.out.printf(body);
	}
}

```

Para enviar uma NFe utilize a URL abaixo, alterando o ambiente de produção para homologação, caso esteja emitindo notas de teste.

Envia uma NFe para autorização:

`https://api.focusnfe.com.br/v2/nfe?ref=REFERENCIA`

Utilize o comando HTTP POST para enviar a sua nota para nossa API. Envie como corpo do POST os dados em formato JSON da nota fiscal.

Nesta etapa, é feita uma primeira validação dos dados da nota. Caso ocorra algum problema, por exemplo, algum campo faltante, formato incorreto
ou algum problema com o emitente a nota **não será aceita para processamento** e será devolvida a mensagem de erro apropriada. Veja a seção [erros](#introducao_erros).

Caso a nota seja validada corretamente, a nota será **aceita para processamento**. Isto significa que a nota irá para uma fila de processamento
onde eventualmente será processada (processamento assíncrono). Com isto, a nota poderá ser autorizada ou ocorrer um erro na autorização, de acordo com a validação da SEFAZ.

Para verificar se a nota já foi autorizada, você terá que efetuar uma [consulta](#nfe_consulta) ou se utilizar de [gatilhos](#gatilhos_gatilhos).


### Reenvio automático em contingência

Caso nossa equipe de monitoramento detecte que o SEFAZ de algum estado esteja fora do ar as requisições são redirecionadas para o ambiente de contingência da SEFAZ do estado. É natural haver uma demora na SEFAZ em disponibilizar esse ambiente (eles realizam este processo manualmente) porém nossa API irá continuar tentando o reenvio até que seja possível, seja pela emissão normal ou em contingência. Isto é feito de forma transparente aos clientes da API.

Porém, pode ocorrer uma situação em que o SEFAZ do estado fique indisponível no meio do processo de emissão de uma NFe. Neste momento nós não temos como saber se a nota foi autorizada ou não, até que a SEFAZ volte a ficar disponível.

Quando isto ocorre nós não esperamos a SEFAZ do estado voltar e reenviamos assim que possível para o ambiente de contingência, autorizando a nota e evitando a espera para o cliente final. Isto tem como efeito colateral que pode ser que a nota original tenha sido autorizada. Nossa API irá automaticamente detectar esta situação e proceder com o cancelamento da tentativa anterior. Por consequência, será natural haver um “pulo” de numeração percebido pelo cliente final.

O sistema cliente da API pode acompanhar este processo de forma transparente, conforme descrito na seção “Consulta” deste manual.

## Consulta

Para consultar uma NFe utilize a URL abaixo, alterando o ambiente de produção para homologação, caso esteja emitindo notas de teste.

Consultar as informações de uma NFe:

https://api.focusnfe.com.br/v2/nfe/REFERENCIA?completa=(0|1)

Utilize o comando HTTP GET para consultar a sua nota para nossa API.

```shell
curl -u token_enviado_pelo_suporte: \
  http://homologacao.acrasnfe.acras.com.br/v2/nfe/12345
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
```java
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;

public class NFe_consulta {

	public static void main(String[] args){

		String login = "Token_enviado_pelo_suporte";

		/* Substituir pela sua identificação interna da nota. */
		String ref = "12345";

		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
 		String server = "http://homologacao.acrasnfe.acras.com.br/";

		String url = server.concat("v2/nfe/"+ref+"?completa=1");

		/* Configuração para realizar o HTTP BasicAuth. */
		Object config = new DefaultClientConfig();
		Client client = Client.create((ClientConfig) config);
		client.addFilter(new HTTPBasicAuthFilter(login, ""));

		WebResource request = client.resource(url);

		ClientResponse resposta = request.get(ClientResponse.class);

		int HttpCode = resposta.getStatus();

		String body = resposta.getEntity(String.class);

		/* As três linhas abaixo imprimem as informações retornadas pela API.
		 * Aqui o seu sistema deverá interpretar e lidar com o retorno. */
		System.out.print("HTTP Code: ");
		System.out.print(HttpCode);
		System.out.printf(body);
	}
}

Após emitir uma nota, você poderá usar a operação de consulta para verificar se a nota já foi aceita para processamento, se está
ainda em processamento ou se a nota já foi processada.

Para consultar uma NFe utilize a URL abaixo, alterando o ambiente de produção para homologação, caso esteja emitindo notas de teste.

Consultar as informações de uma NFe:

`https://api.focusnfe.com.br/v2/nfe/REFERENCIA`

Utilize o comando HTTP GET para consultar a sua nota para nossa API.

```

>Exemplo de resposta da consulta de NFe:

```json
{
  "cnpj_emitente": "CNPJ_DO_EMITENTE",
  "ref": "REFERENCIA",
  "status": "cancelado",
  "status_sefaz": "135",
  "mensagem_sefaz": "Evento registrado e vinculado a NF-e",
  "numero": "25",
  "serie": "3",
  "chave_nfe": "NFe91180177643353000172550030000000251381549464",
  "caminho_xml_nota_fiscal": "/arquivos_development/77623353000000/201201/XMLs/91180177643353000172550030000000251381549464-nfe.xml",
  "caminho_xml_cancelamento": "/arquivos_development/77623353000000/201201/XMLs/91180177643353000172550030000000251381549464-can.xml",
  "caminho_xml_carta_correcao": "/arquivos_development/77623353000000/201201/XMLs/91180177643353000172550030000000251381549464-cce-01.xml",
  "caminho_pdf_carta_correcao": "/notas_fiscais/NFe91180177643353000172550030000000251381549464/cartas_correcao/1.pdf",
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

Caso na requisição seja passado o parâmetro `completa=1` será adicionado mais 6 campos:

* **requisicao_nota_fiscal**: Inclui os dados completos da requisição da nota fiscal, da mesma forma que constam no XML da nota.
* **protocolo_nota_fiscal**: Inclui os dados completos do protocolo devolvido pela SEFAZ.
* **requisicao_cancelamento**: Inclui os dados completos da requisição de cancelamento da nota fiscal.
* **protocolo_cancelamento**: Inclui os dados completos do protocolo devolvido pela SEFAZ.
* **requisicao_carta_correcao**: Inclui os dados completos da requisição de Carta de Correção Eletrônica da NFe.
* **protocolo_carta_correcao**: Inclui os dados completos do protocolo devolvido pela SEFAZ.

> Exemplo de campos extras na consulta completa

```json
{
    "requisicao_cancelamento": {
    "versao": "1.00",
    "id_tag": "ID1101119118017764335300017255003000000025138154946401",
    "codigo_orgao": "41",
    "ambiente": "2",
    "cnpj": "CNPJ_DO_EMITENTE",
    "chave_nfe": "91180177643353000172550030000000251381549464",
    "data_evento": "2012-01-17T16:00:28-02:00",
    "tipo_evento": "110111",
    "numero_sequencial_evento": "1",
    "versao_evento": "1.00",
    "descricao_evento": "Cancelamento",
    "protocolo": "141180000026777",
    "justificativa": "Informe aqui a sua justificativa para realizar o cancelamento da NFe."
  },
  "protocolo_cancelamento": {
    "versao": "1.00",
    "ambiente": "2",
    "versao_aplicativo": "PR-v3_8_7",
    "codigo_orgao": "41",
    "status": "135",
    "motivo": "Evento registrado e vinculado a NF-e",
    "chave_nfe": "91180177643353000172550030000000251381549464",
    "tipo_evento": "110111",
    "descricao_evento": "Cancelamento",
    "data_evento": "2012-01-17T16:00:31-02:00",
    "numero_protocolo": "141180000026777"
  },
   "requisicao_carta_correcao": {
    "versao": "1.00",
    "id_tag": "ID1101109118017764335300017255003000000025138154946401",
    "codigo_orgao": "41",
    "ambiente": "2",
    "cnpj": "CNPJ_DO_EMITENTE",
    "chave_nfe": "91180177643353000172550030000000251381549464",
    "data_evento": "2012-01-17T15:59:34-02:00",
    "tipo_evento": "110110",
    "numero_sequencial_evento": "1",
    "versao_evento": "1.00",
    "descricao_evento": "Carta de Correcao",
    "correcao": "Informe aqui os campos que foram corrigidos na NFe.",
    "condicoes_uso": "A Carta de Correcao e disciplinada pelo paragrafo 1o-A do art. 7o do Convenio S/N, de 15 de dezembro de 1970 e pode ser utilizada para regularizacao de erro ocorrido na emissao de documento fiscal, desde que o erro nao esteja relacionado com: I - as variaveis que determinam o valor do imposto tais como: base de calculo, aliquota, diferenca de preco, quantidade, valor da operacao ou da prestacao; II - a correcao de dados cadastrais que implique mudanca do remetente ou do destinatario; III - a data de emissao ou de saida."
  },
  "protocolo_carta_correcao": {
    "versao": "1.00",
    "ambiente": "2",
    "versao_aplicativo": "PR-v3_8_7",
    "codigo_orgao": "41",
    "status": "135",
    "motivo": "Evento registrado e vinculado a NF-e",
    "chave_nfe": "91180177643353000172550030000000251381549464",
    "tipo_evento": "110110",
    "descricao_evento": "Carta de Correção",
    "data_evento": "2012-01-17T15:59:37-02:00",
    "numero_protocolo": "141180000026777"
  }
}
```

### Reenvio Automático em Contingência – algumas considerações

Quando houver uma tentativa anterior de emissão, conforme descrito na seção “Reenvio automático em contingência”. A API irá devolver a chave `tentativa_anterior` que irá conter os seguintes campos:

* status: autorizado, processando_autorizacao ou cancelado. A API irá automaticamente proceder com o cancelamento quando necessário
* serie
* numero
* chave_nfe
* caminho_xml_nota_fiscal
* caminho_xml_cancelamento

## Cancelamento

```shell
curl -u token_enviado_pelo_suporte: \
  -X DELETE -d '{"justificativa":"Teste de cancelamento de nota"}' \
  http://homologacao.acrasnfe.acras.com.br/v2/nfe/12345
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
```java
import java.util.HashMap;
import org.codehaus.jettison.json.JSONObject;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;

public class NFe_cancelamento {

	public static void main(String[] args){

		String login = "Token_enviado_pelo_suporte";

		/* Substituir pela sua identificação interna da nota. */
		String ref = "12345";

		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
 		String server = "http://homologacao.acrasnfe.acras.com.br/";

 		String url = server.concat("v2/nfe/"+ref);
 		/* Aqui criamos um hashmap para receber a chave "justificativa" e o valor desejado. */
		HashMap<String, String> justificativa = new HashMap<String, String>();
		justificativa.put("justificativa", "Informe aqui a sua justificativa para realizar o cancelamento da NFe.");

		/* Criamos um objeto JSON para receber a hash com os dados esperado pela API. */
		JSONObject json = new JSONObject(justificativa);

		/* Configuração para realizar o HTTP BasicAuth. */
		Object config = new DefaultClientConfig();
		Client client = Client.create((ClientConfig) config);
		client.addFilter(new HTTPBasicAuthFilter(login, ""));

		WebResource request = client.resource(url);

		ClientResponse resposta = request.delete(ClientResponse.class, json);

		int HttpCode = resposta.getStatus();

		String body = resposta.getEntity(String.class);

	   /* As três linhas abaixo imprimem as informações retornadas pela API.
        * Aqui o seu sistema deverá interpretar e lidar com o retorno. */
		System.out.print("HTTP Code: ");
		System.out.print(HttpCode);
		System.out.printf(body);
	}
}
```

> Resposta da API para a requisição de cancelamento:

```json
{
  "status_sefaz": "135",
  "mensagem_sefaz": "Evento registrado e vinculado a NF-e",
  "status": "cancelado",
  "caminho_xml_cancelamento": "/arquivos_development/77993353000000/204703/XMLs/41180377993353000000000030000000885414063742-can.xml"
}
```

Para cancelar uma NFe, basta fazer uma requisição à URL abaixo, alterando o ambiente de produção para homologação, caso esteja emitindo notas de teste.

Cancelar uma NFe já autorizada:

`https://api.focusnfe.com.br/v2/nfe/REFERENCIA`

Utilize o comando HTTP DELETE para cancelar a sua nota para nossa API. Este método é síncrono, ou seja, a comunicação com a SEFAZ será feita imediatamente e devolvida a resposta na mesma requisição.

O parâmetros de cancelamento deverão ser enviados da seguinte forma:

* **justificativa**: Justificativa do cancelamento. Deverá conter de 15 a 255 caracteres.


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

```shell
curl -u token_enviado_pelo_suporte: \
  -X POST -d '{"correcao":"Teste de carta de correcao"}' \
  http://homologacao.acrasnfe.acras.com.br/v2/nfe/12345/carta_correcao
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
```java
import java.util.HashMap;
import org.codehaus.jettison.json.JSONObject;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;

public class NFe_CCe {

	public static void main(String[] args){

		String login = "Token_enviado_pelo_suporte";

		/* Substituir pela sua identificação interna da nota. */
		String ref = "12345";

		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
		String server = "http://homologacao.acrasnfe.acras.com.br/";

		String url = server.concat("v2/nfe/"+ref+"/carta_correcao");

		/* Aqui criamos um hashmap para receber a chave "correcao" e o valor desejado. */
		HashMap<String, String> correcao = new HashMap<String, String>();
		correcao.put("correcao", "Informe aqui os campos que foram corrigidos na NFe.");

		/* Criamos um objeto JSON para receber a hash com os dados esperado pela API. */
		JSONObject json = new JSONObject(correcao);

		/* Configuração para realizar o HTTP BasicAuth. */
		Object config = new DefaultClientConfig();
		Client client = Client.create((ClientConfig) config);
		client.addFilter(new HTTPBasicAuthFilter(login, ""));

		WebResource request = client.resource(url);

		ClientResponse resposta = request.post(ClientResponse.class, json);

		int HttpCode = resposta.getStatus();

		String body = resposta.getEntity(String.class);

	   /* As três linhas abaixo imprimem as informações retornadas pela API.
		* Aqui o seu sistema deverá interpretar e lidar com o retorno. */
		System.out.print("HTTP Code: ");
		System.out.print(HttpCode);
		System.out.printf(body);
	}
}
```

> Resposta da API para a requisição de CCe:

```json
{
  "status_sefaz": "135",
  "mensagem_sefaz": "Evento registrado e vinculado a NF-e",
  "status": "autorizado",
  "caminho_xml_carta_correcao": "/arquivos_development/77793353000000/201803/XMLs/99180377993353000000550030000000271021711350-cce-01.xml",
  "caminho_pdf_carta_correcao": "/notas_fiscais/NFe411803777933530000002550030000000277771711350/cartas_correcao/1.pdf",
  "numero_carta_correcao": 1
}
```

`https://api.focusnfe.com.br/v2/nfe/REFERENCIA/carta_correcao`

Utilize o comando HTTP POST para enviar a sua nota para nossa API. Este método é **síncrono**, ou seja, a comunicação com a SEFAZ será feita imediatamente e devolvida a resposta na mesma requisição.

O parâmetros da carta de correção deverão ser enviados da seguinte forma:

* **correcao**: Texto da carta de correção. Deverá conter de 15 a 255 caracteres.
* **data_evento**: Campo opcional. Data do evento da carta de correção. Se não informado será usado a data atual


A API irá em seguida devolver os seguintes campos:

* **status**: autorizado, se a carta de correção foi aceita pela SEFAZ, ou erro_autorizacao, se houve algum erro ao cancelar a nota.
* **status_sefaz**: O status da carta de correção na SEFAZ.
* **mensagem_sefaz**: Mensagem descritiva da SEFAZ detalhando o status.
* **caminho_xml_carta_correcao**: Informa o caminho do XML da carta de correção, caso ela tenha sido autorizada.
* **caminho_pdf_carta_correcao**: Informa o caminho do PDF da carta de correção, caso ela tenha sido autorizada.
* **numero_carta_correcao**: Informa o número da carta de correção, caso ela tenha sido autorizada.

Para uma mesma nota fiscal é possível enviar mais de uma carta de correção, até o limite de 20 correções, sendo que a última sempre substitui a anterior.

## Reenvio de e-mail

```shell
curl -u token_enviado_pelo_suporte: \
  -X POST -d '{"emails":["alguem@example.org"]}' \
  http://homologacao.acrasnfe.acras.com.br/v2/nfe/12345/email
```

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

```java
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;

public class NFe_envia_email {

	public static void main(String[] args) throws JSONException{

		String login = "Token_enviado_pelo_suporte";

		/* Substituir pela sua identificação interna da nota. */
		String ref = "12345";

		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
 		String server = "http://homologacao.acrasnfe.acras.com.br/";

		String url = server.concat("v2/nfe/"+ref+"/email");

		/* Criamos o um objeto JSON que receberá um JSON Array com a lista de e-mails. */
		JSONObject json = new JSONObject ();
		JSONArray ListaEmails = new JSONArray();
		ListaEmails.put("email_01@acras.com.br");
		ListaEmails.put("email_02@acras.com.br");
		ListaEmails.put("email_03@acras.com.br");
		json.put("emails", ListaEmails);

		/* Testar se o JSON gerado está dentro do formato esperado.
		System.out.print(json); */

		/* Configuração para realizar o HTTP BasicAuth. */
		Object config = new DefaultClientConfig();
		Client client = Client.create((ClientConfig) config);
		client.addFilter(new HTTPBasicAuthFilter(login, ""));

		WebResource request = client.resource(url);

		ClientResponse resposta = request.post(ClientResponse.class, json);

		int HttpCode = resposta.getStatus();

		String body = resposta.getEntity(String.class);

		/* As três linhas abaixo imprimem as informações retornadas pela API.
		 * Aqui o seu sistema deverá interpretar e lidar com o retorno. */
		System.out.print("HTTP Code: ");
		System.out.print(HttpCode);
		System.out.printf(body);
	}
}
```

Para cada nota autorizada, cancelada ou que tenha sido emitida uma carta de correção o destinatário da nota é notificado via email. Porém eventualmente pode ser necessário enviar a nota fiscal para outras pessoas ou mesmo reenviar o email para o mesmo destinatário.

Para enviar um ou mais emails:

`https://api.focusnfe.com.br/v2/nfe/REFERENCIA/email`

Utilize o comando HTTP POST para enviar os emails. Esta operação aceita apenas um parâmetro:

* **emails**: Array com uma lista de emails que deverão receber uma cópia da nota. Limitado a 10 emails por vez.

A API imediatamente devolve a requisição com a confirmação dos emails. Os emails serão enviados em segundo plano, por isso pode levar alguns minutos até que eles cheguem à caixa postal.

## Inutilização

```shell
curl -u token_enviado_pelo_suporte: \
  -X POST -d '{"cnpj":"51916585000125","serie":"1","numero_inicial":"7","numero_final":"9","justificativa":"Teste de inutilizacao de nota"}' \
  http://homologacao.acrasnfe.acras.com.br/v2/nfe/inutilizacao
```

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
```java
import java.util.HashMap;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;

public class NFe_inutilizacao {

	public static void main(String[] args) throws JSONException{

		String login = "Token_enviado_pelo_suporte";

		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
 		String server = "http://homologacao.acrasnfe.acras.com.br/";

 		String url = server.concat("v2/nfe/inutilizacao");

 		/* Aqui criamos um hash que irá receber as chaves e valores esperados para gerar a inutilização. */
		HashMap<String, String> DadosInutilizacao = new HashMap<String, String>();
		DadosInutilizacao.put("cnpj", "51916585009999");
		DadosInutilizacao.put("serie", "9");
		DadosInutilizacao.put("numero_inicial", "7730");
		DadosInutilizacao.put("numero_final", "7732");
		DadosInutilizacao.put("justificativa", "Informe aqui a justificativa para realizar a inutilizacao da numeracao.");

		/* Criamos um objeto JSON que irá receber o input dos dados, para então enviar a requisição. */
		JSONObject json = new JSONObject (DadosInutilizacao);

		/* Testar se o JSON gerado está dentro do formato esperado.
		System.out.print(json); */

		/* Configuração para realizar o HTTP BasicAuth. */
		Object config = new DefaultClientConfig();
		Client client = Client.create((ClientConfig) config);
		client.addFilter(new HTTPBasicAuthFilter(login, ""));

		WebResource request = client.resource(url);

		ClientResponse resposta = request.post(ClientResponse.class, json);

		int HttpCode = resposta.getStatus();

		String body = resposta.getEntity(String.class);

		 /* As três linhas abaixo imprimem as informações retornadas pela API.
		  * Aqui o seu sistema deverá interpretar e lidar com o retorno. */
		System.out.print("HTTP Code: ");
		System.out.print(HttpCode);
		System.out.printf(body);
	}
}
```

> Resposta da API para a requisição de inutilização:

```json
 {
  "status_sefaz": "102",
  "mensagem_sefaz": "Inutilizacao de numero homologado",
  "serie": "3",
  "numero_inicial": "800",
  "numero_final": "801",
  "status": "autorizado",
  "caminho_xml": "/arquivos_development/71113353000900/207701/XMLs/999992335309999955003000000800000000801-inu.xml"
}
```

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


A API irá enviar uma resposta com os seguintes campos:

* **status**: autorizado, se a inutilização foi aceita pela SEFAZ, ou erro_autorizacao, se houve algum erro ao inutilizar os números.
* **status_sefaz**: O status da carta de correção na SEFAZ.
* **mensagem_sefaz**: Mensagem descritiva da SEFAZ detalhando o status.
* **serie**: Série da numeração da NFe que terá uma faixa de numeração inutilizada
* **numero_inicial**: Número inicial a ser inutilizado
* **numero_final**: Número final a ser inutilizado
* **caminho_xml**: Caminho do XML para download caso a inutilização tenha sido autorizada pela SEFAZ.

## Outras documentações
### Enviador de Arquivos

Uma das formas de se comunicar com o Focus NFe é gerando um arquivo texto no formato especificado.

Para sistemas desktop que não desejam implementar uma comunicação direta com nossos web services criamos um agente de comunicação que lê os arquivos gerados em uma pasta e envia para o Focus NFe. Em um segundo momento o próprio agente consulta o status da nota e faz o download dos arquivos do DANFe e XML da nota.

**Como Funciona**

Sempre que o comunicador é chamado ele irá seguir os passos abaixo:

1.  **Enviar os arquivos de NFe** que estão no diretório de envio e criar uma pendência de retorno para esta nota.
2.  **Enviar os arquivos de cancelamento** que estão no diretório de envio e criar uma pendência de retorno para este cancelamento.
3.  **Consultando os retornos pendentes**.
    1.  **Havendo retorno** o comunicador irá **gravar o arquivo de retorno** com o nome do identificador e a extensão (.ret). Por exemplo, para uma NFe com identificador único 99887766 será gravado o arquivo 99887766.ret no diretório de retorno.
    2. Se o retorno é referente a uma **emissão de NFe e esta nota foi autorizada**, o comunicador já irá fazer o download do **DANFe e do XML** gravando os dois arquivos em um subdiretório do diretório de retorno. Para o DANFe o nome do subdiretório será DANFEs e para o XML será XMLs.


**Envio do arquivo para emissão da NFe**

A aplicação do cliente deverá gravar um arquivo contendo o conteúdo da NFe e cujo nome é composto de um identificador único e com extensão NFe. Por exemplo, se o identificador único da nota no sistema cliente é 99887766 deverá ser gravado no diretório de envio com a extensão nfe, ou seja 99887766.nfe.

**Envio do arquivo para cancelamento de NFe**

A aplicação cliente deverá gravar um arquivo contendo um texto de justificativa de cancelamento. O arquivo deverá ser nomeado com o identificador único da nota e com extensão (.can). Em nosso exemplo acima o nome do arquivo seria 99887766.can. Este arquivo deverá ser gravado no diretório de envio de dados.

**Envio do carta de correção eletrônica (CCe)**

A aplicação cliente deverá gravar um arquivo contendo um texto da correção a ser aplicada. O arquivo deverá ser nomeado com o identificador único da nota e com extensão (.cce) e gravar no diretório de envio de dados.

O PDF e XML da carta de correção serão gravados no diretório de retorno, subdiretório CCes.

**Reconsulta de nfe**

O comunicador faz adiciona pendências de consulta automaticamente para todo envio e cancelamento comandado. Se por algum motivo houver a necessidade de comandar novamente uma consulta, basta acionar o comunicador com o parâmetro ref e o valor sendo o id único da nota. Por exemplo, para comandar a reconsulta da nota com id único 99887766 basta chamar o comunicador como na linha de comando a seguir:

`$ focusNFeFileCommunicator ref=99887766`

**Importante**

O comunicador possui uma execução linear e ao final é desativado. Isto quer dizer que ele não repete as consultas até que as notas estejam em estado final. É de responsabilidade da aplicação do cliente chamar o comunicador de tempos em tempos até que tenha as respostas para seus envios.

**Configuração**

Após rodar o comunicador pela primeira vez ele irá gerar um arquivo de configuração com informações padrão, como no exemplo ao lado.

<pre>
[Diretorios]
envio =P:envios
retorno =P:retornos
logs=P:logs
[Conexao]
url =http://producao.acrasnfe.acras.com.br/
token={token-enviado-pelo-suporte-focusnfe}
</pre>

Na seção **Diretorios** são configurados os diretórios de comunicação (envio e retorno) onde a aplicação do cliente irá salvar e ler arquivos respectivamente. Também é configurado o diretório de logs, onde o comunicador irá gravar os logs das operações realizadas por ele.

A seção **Conexão** possui duas configurações cruciais para a correta comunicação com o Focus NFe. A url determina o endereço de comunicação que pode ser o de homologação (http://homologacao.acrasnfe.acras.com.br) e produção (http://producao.acrasnfe.acras.com.br).

O token é a chave de acesso, fornecida pelo suporte, que irá garantir que a aplicação do cliente tem acesso ao Focus NFe.

**Download**

O comunicador foi desenvolvido para uso em sistema operacional Windows, para fazer o download do comunicador [clique aqui](http://www.focusnfe.com.br/downloads/focusNfeFileCommunicator.exe) .

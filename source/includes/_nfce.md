# NFCe
Através da API NFCe é possível:

* Emitir uma Nota Fiscal de Consumidor Eletrônica (NFCe) para qualquer Estado que aceita o uso deste documento.
* Cancelar NFCe.
* Consultar NFCe emitidas.
* Reenviar uma NFCe por email.
* Inutilizar o número de alguma série de NFCe.

Todos os processos envolvendo NFCe são **síncronos**. Ou seja, a emissão não é feita em segundo plano, ao contrário da NFe
e NFSe.

## URLs

Método | URL (recurso) | Ação
-------|-------|-----
POST | / v2/nfce?ref=REFERENCIA |  Cria uma nota fiscal e a envia para processamento.
GET |  /v2/nfce/REFERENCIA | Consulta a nota fiscal com a referência informada e o seu status de processamento.
DELETE  | /v2/nfce/REFERENCIA |  Cancela uma nota fiscal com a referência informada
POST | /v2/nfce/REFERENCIA/email |  Envia um email com uma cópia da nota fiscal com a referência informada
POST | /v2/nfce/inutilizacao | Inutiliza uma numeração da nota fiscal


## Campos obrigatórios de uma NFCe

Atualmente, a NFe possui centenas de campos para os mais variados tipos e formas de operações, por isso, criamos uma página exclusiva que mostra todos os campos da nossa API para o envio de NFe. Nela, você pode buscar os campos pela TAG XML ou pela nossa tradução para API.

[Documentação completa dos campos (versão 4.00 da NFe)] (https://focusnfe.com.br/dsl/4.0/NotaFiscalXML.html)

[Documentação completa dos campos – versão 3.10 da NFe – Disponível até 2/julho/2018] (https://focusnfe.com.br/dsl/lang/NotaFiscalXML.html)

Abaixo, iremos mostrar todos os campos de uso mais comum para emissão de uma NFCe.

> Abaixo um exemplo de dados de uma nota (usando a versão 4.00 da NFCe):

```json
{
   "cnpj_emitente":"05953016000132",
   "data_emissao":"2017-12-06 14:45:10",
   "indicador_inscricao_estadual_destinatario":"9",
   "modalidade_frete":"9",
   "local_destino":"1",
   "presenca_comprador":"1",
   "natureza_operacao":"VENDA AO CONSUMIDOR",
   "items":[
      {
         "numero_item":"1",
         "codigo_ncm":"62044200",
         "quantidade_comercial":"1.00",
         "quantidade_tributavel":"1.00",
         "cfop":"5102",
         "valor_unitario_tributavel":"79.00",
         "valor_unitario_comercial":"79.00",
         "valor_desconto":"0.00",
         "descricao":"NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL",
         "codigo_produto":"251887",
         "icms_origem":"0",
         "icms_situacao_tributaria":"102",
         "unidade_comercial":"un",
         "unidade_tributavel":"un",
         "valor_total_tributos":"24.29"
      }
   ],
   "formas_pagamento":[
      {
         "forma_pagamento":"03",
         "valor_pagamento":"79.00",
         "nome_credenciadora":"Cielo",
         "bandeira_operadora":"02",
         "numero_autorizacao":"R07242"
      }
   ]
}
```

### Geral

| Campo                               	| Tipo        	| Obrigatório 	| Descrição                                                                                	| Validação                                                                                                           	|
|-------------------------------------	|-------------	|-------------	|------------------------------------------------------------------------------------------	|---------------------------------------------------------------------------------------------------------------------	|
| natureza_operacao                   	| texto       	| sim         	| Descrição da natureza de operação.                                                       	| Caso não informado, será utilizado o texto “VENDA AO CONSUMIDOR”.                                                   	|
| data_emissao                        	| data e hora 	| sim         	| Data e hora de emissão com timezone.                                                     	| Utilize o formato ISO, exemplo 2015-11-19T13:54:31-02:00. Diferença máxima permitida de 5 minutos do horário atual. 	|
| presenca_comprador                  	| numérico    	| sim         	| Presença do comprador.Valores possíveis:1 – Operação presencial.4 – Entrega a domicílio. 	|                                                                                                                     	|
| informacoes_adicionais _contribuinte 	| texto       	| não         	| Informações adicionais.                                                                  	|                                                                                                                     	|
| cnpj_emitente                       	| texto       	| sim         	| CNPJ da empresa que está emitindo a NFCe.                                                	| CNPJ válido.                                                                                                        	|


### Destinatário


| Campo                   | Tipo  | Obrigatório | Descrição                         | Validação                             |
|-------------------------|-------|-------------|-----------------------------------|---------------------------------------|
| nome_destinatario       | texto | não         | Nome do consumidor.               |                                       |
| cnpj_destinatario       | texto | não         | CNPJ do consumidor.               | Enviar em branco ou documento válido. |
| cpf_destinatario        | texto | não         | CPF do consumidor.                | Enviar em branco ou documento válido. |
| telefone_destinatario   | texto | não         | Telefone do consumidor.           |                                       |
| logradouro_destinatario | texto | não         | Logradouro do consumidor.         |                                       |
| numero_destinatario     | texto | não         | Número do endereço do consumidor. |                                       |
| bairro_destinatario     | texto | não         | Bairro do consumidor.             |                                       |
| municipio_destinatario  | texto | não         | Município do consumidor.          |                                       |
| uf_destinatario         | texto | não         | Sigla da UF do consumidor.        |                                       |
| cep_destinatario        | texto | não         | CEP do consumidor.                |                                       |


### Itens

Os dados dos itens da NFCe devem ser enviados dentro de um Array JSON. O nome que este array deve ter é **“itens“**.

| Campo                        | Tipo           | Obrigatório                                  | Descrição                                                                                                                                                                                                                                                                                                                                                                                                                         |
|------------------------------|----------------|----------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| numero_item                  | numérico       | sim                                          | Número do item. Comece com 1 e aumente sequencialmente para cada item da NFCe.                          |
| codigo_ncm                   | texto          | sim                                          | Código NCM do produto (8 dígitos).
| codigo_produto               | texto          | sim                                          | Código do produto.
| descricao                    | texto          | sim                                          | Descrição do produto.                                                                                         |
| quantidade_comercial         | numérico       | sim                                          | Quantidade do item.
| quantidade_tributavel        | numérico       | sim                                          | Quantidade tributável do item.  Caso não se aplique utilize o mesmo valor de quantidade_comercial.                      |
| cfop                         | texto          | sim                                          | Código Fiscal da operação. Utilize algum CFOP da operação válido para Nota ao Consumidor.                                        |
| valor_unitario_comercial     | numérico       | sim                                          | Valor unitário do item. |
| valor_unitario_tributavel    | numérico       | sim                                          | Valor unitário tributável do item. Caso não se aplique utilize o mesmo valor que valor_unitario_comercial.                 |
| valor_bruto                  | numérico       | sim                                          | Valor bruto do item. Calculado como valor_unitario_comercial * quantidade_comercial                          |
| unidade_comercial            | texto          | sim                                          | Unidade comercial do produto. Você pode utilizar valores como “KG”, “L”, “UN”, etc. Caso não se aplique utilize “UN”. |
| unidade_tributavel           | texto          | sim                                          | Unidade tributável do produto. Caso não se aplique utilize o mesmo valor do campo unidade_comercial.                   |
| icms_origem                  | valor da lista | sim                                          | Valores Possíveis: **0**: nacional. **1**: estrangeira (importação direta). **2**: estrangeira (adquirida no mercado interno). **3**: nacional com mais de 40% de conteúdo estrangeiro. **4**: nacional produzida através de processos produtivos básicos. **5**: nacional com menos de 40% de conteúdo estrangeiro. **6**: estrangeira (importação direta) sem produto nacional similar. **7**: estrangeira (adquirida no mercado interno) sem produto nacional similar. |
| icms_situacao_tributaria     | valor da lista | sim                                          | Valores possíveis: Para empresas optantes do SIMPLES: **102** – Tributada pelo Simples Nacional sem permissão de crédito, **300** - Imune, **500** - CMS cobrado anteriormente por substituição tributária (substituído) ou por antecipação. Para empresas não optantes do SIMPLES: **00** – tributada integralmente, **40** – Isenta, **41** - Não tributada, **60** - ICMS cobrado anteriormente por substituição tributária|
| icms_aliquota                | numérico       | Obrigatório se icms_situacao_tributaria = 00 | Alíquota do ICMS.  Deve estar entre 0 e 100.                                                               |
| icms_base_calculo            | numérico       | Obrigatório se icms_situacao_tributaria = 00 | Base de cálculo do ICMS. Normalmente é igual ao valor_bruto.                                                     |
| icms_modalidade_base _calculo | valor da lista | Obrigatório se icms_situacao_tributaria = 00 | Modalidade da base de cálculo do ICMS.Valores possíveis:0 – margem de valor agregado (%).1 – pauta (valor).2 – preço tabelado máximo (valor).3 – valor da operação.|
| valor_desconto               | numérico       |                                              | Valor do desconto do item. |
| valor_frete                  | numérico       |                                              | Valor do frete do item.  Usado apenas se entrega a domicílio. O frete deve ser “rateado” entre todos os itens.   |

### Transportador

| Campo                            | Tipo   | Obrigatório                   | Descrição|
|----------------------------------|--------|-------------------------------|--------------------------------------------------------------------------|
| cnpj_transportador               | string | sim se presenca_comprador = 4 | CNPJ do transportador. Se este campo for informado não deverá ser informado cpf_transportador.  |
| cpf_transportador                | string | sim se presenca_comprador = 4 | CPF do transportador. Se este campo for informado não deverá ser informado cnpj_transportador. |
| nome_transportador               | string | sim se presenca_comprador = 4 | Nome ou razão social do transportador.|
| inscricao_estadual_transportador | string | sim se presenca_comprador = 4 | Inscrição Estadual do transportador.|
| endereco_transportador           | string | sim se presenca_comprador = 4 | Endereço (logradouro, número, complemento e bairro) do transportador. |
| municipio_transportador          | string | sim se presenca_comprador = 4 | Município do transportador. |
| uf_transportador                 | string | sim se presenca_comprador = 4 | UF do transportador.|


### Pagamento

Os dados abaixo devem ser enviados dentro de um Array JSON. O nome que este array deve ter é **“formas_pagamento“**.

| Campo              | Tipo           | Obrigatório                                                     | Descrição  |
|--------------------|----------------|-----------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| forma_pagamento    | valor da lista | sim                                                             | Forma do recebimento. Valores possíveis:01: Dinheiro.02: Cheque.03: Cartão de Crédito.04: Cartão de Débito.05: Crédito Loja.10: Vale Alimentação.11: Vale Refeição.12: Vale Presente.13: Vale Combustível.99: Outros   |
| valor_pagamento    | numérico       | sim                                                             | Valor do recebimento.   |
| tipo_integracao    | valor da lista | não                                                             | Tipo de Integração para pagamento. Valores possíveis:1: Pagamento integrado com o sistema de automação da empresa (Ex.: equipamento TEF, Comércio Eletrônico) – Obrigatório informar cnpj_credenciadora e numero_autorizacao.2: Pagamento não integrado com o sistema de automação da empresa (valor padrão).  Informar apenas se forma_pagamento for 03 ou 04. |
| cnpj_credenciadora | numérico       | Obrigatório se tipo_integracao for 1                            | CNPJ da credenciadora do cartão de crédito. Somente CNPJ válido.                             |
| numero_autorizacao | string         | Obrigatório se tipo_integracao for 1                            | |
| bandeira_operadora | string         | Obrigatório se forma_pagamento = 03 ou 04 (pagamento em cartão) | Bandeira da operadora de cartão de crédito e/ou débito. Valores possíveis:01: Visa.02: Mastercard.03: American Express.04: Sorocred.99: Outros.|

### Totalizadores

| Campos            | Tipo     | Obrigatório                                          | Descrição  |
|-------------------|----------|------------------------------------------------------|------------------------------------------------------|
| valor_produtos    | numérico | não                                                  | Valor total dos produtos.  Calculado automaticamente se não informado.                                                                                            |
| valor_desconto    | numérico | não                                                  | Valor total dos descontos. Calculado automaticamente se não informado.                                                                                            |
| valor_total       | numérico | não                                                  | Valor líquido dos produtos. Deve ser igual a valor_produtos – valor_desconto. Calculado automaticamente se não informado.                                          |
| valor_frete       | numérico | não                                                  | Valor total do frete. Deve conter o somatório do valor do frete dos itens (usado apenas em entrega a domicílio). Calculado automaticamente se não informado. |
| icms_valor_total  | numérico | não                                                  | Valor total de ICMS dos produtos.  Deve ser o somatório dos valores contidos em icms_valor nos items. Calculado automaticamente se não informado.                         |
| icms_base_calculo | numérico | sim, se algum item tem icms_situacao_tributaria = 00 | Valor total da base de cálculo do ICMS dos produtos. Deve ser o somatório dos valores contidos em icms_base_calculo nos items. Calculado automaticamente se não informado.                  |

### Campos calculados automaticamente

Para simplificar o envio da nota fiscal, alguns campos são calculados automaticamente a partir da versão 4.00 da NFCe. Os campos calculados são somatórios de campos fornecidos nos itens da nota fiscal. Os campos serão calculados apenas se eles não forem informados na API.

A lista de campos calculados automaticamente segue abaixo:

| Campo                                     | Somatório de campo dos itens        | Observação                                                  |
|-------------------------------------------|-------------------------------------|-------------------------------------------------------------|
| icms_base_calculo                         | icms_base_calculo                   |                                                             |   
| valor_ipi                                 | ipi_valor                           |                                                             |   
| icms_valor_total_st                       | icms_valor_st                       |                                                             |   
| issqn_base_calculo                        | issqn_base_calculo                  |                                                             |   
| issqn_valor_total                         | issqn_valor                         |                                                             |   
| issqn_valor_total_deducao                 | issqn_valor_deducao                 |                                                             |   
| issqn_valor_total_outras_retencoes        | issqn_valor_outras_retencoes        |                                                             |   
| issqn_valor_total_desconto_incondicionado | issqn_valor_desconto_incondicionado |                                                             |   
| issqn_valor_total_desconto_condicionado   | issqn_valor_desconto_condicionado   |                                                             |   
| issqn_valor_total_retencao                | issqn_valor_retencao                |                                                             |   
| issqn_base_calculo                        | issqn_base_calculo                  |                                                             |   
| valor_total_ii                            | ii_valor                            |                                                             |   
| fcp_valor_total                           | fcp_valor                           |                                                             |   
| fcp_valor_total_uf_destino                | fcp_valor_uf_destino                |                                                             |   
| fcp_valor_total_st                        | fcp_valor_st                        |                                                             |   
| fcp_valor_total_retido_st                 | fcp_valor_retido_st                 |                                                             |   
| icms_valor_total_uf_destino               | icms_valor_uf_destino               |                                                             |   
| icms_valor_total_uf_remetente             | icms_valor_uf_remetente             |                                                             |   
| icms_base_calculo                         | icms_base_calculo                   |                                                             |   
| icms_valor_total                          | icms_valor                          |                                                             |   
| icms_valor_total_desonerado               | icms_valor_desonerado               |                                                             |   
| icms_base_calculo_st                      | icms_base_calculo_st                |                                                             |   
| icms_valor_total_st                       | icms_valor_st                       |                                                             |   
| valor_frete                               | valor_frete                         |                                                             |   
| valor_seguro                              | valor_seguro                        |                                                             |   
| valor_outras_despesas                     | valor_outras_despesas               |                                                             |   
| valor_desconto                            | valor_desconto                      |                                                             |   
| valor_ipi_devolvido                       | valor_ipi_devolvido                 |                                                             |   
| valor_total_tributos                      | valor_total_tributos                |                                                             |   
| valor_produtos                            | valor_bruto                         | Apenas se inclui_no_total=1                                 |   
| valor_total_servicos                      | valor_bruto                         | Apenas se inclui_no_total=1 e item de serviço               |   
| icms_valor_total                          | icms_valor                          | Apenas se icms_situacao_tributaria diferente de40, 41 e 50. |   
| valor_pis_servicos                        | pis_valor                           | Apenas se item de serviço                                   |   
| valor_cofins_servicos                     | cofins_valor                        | Apenas se item de serviço                                   |   
| valor_pis                                 | pis_valor                           | Apenas se não for item de serviço                           |   
| valor_cofins                              | cofins_valor                        | Apenas se não for item de serviço

Além disso, caso não seja fornecido, será calculado também o valor total da NFCe (valor_total), calculado da seguinte forma:

valor_produtos – valor_desconto – icms_valor_total_desonerado + icms_valor_total_st + valor_frete + valor_seguro + valor_outras_despesas + valor_total_ii + valor_ipi + valor_total_servicos

Além dos campos acima, os campos abaixo são preenchidos automaticament para NFCe, pois tem apenas um conteúdo válido possível:

* **tipo_documento** = 1, significando “Nota de saída”
* **consumidor_final** = 1, significando “Nota para consumidor final”
* **finalidade_emissao** = 1, significando “Nota normal”

## Envio
```python
# Faça o download e instalação da biblioteca requests, através do python-pip.
import json
import requests

'''
Para ambiente de produção use a variável abaixo:
url = "https://api.focusnfe.com.br"
'''
url = "http://homologacao.acrasnfe.acras.com.br/v2/nfce"

# Substituir pela sua identificação interna da nota
ref = {"ref":"1234"}

token="token_enviado_pelo_suporte"

'''
Usamos dicionarios para armazenar os campos e valores que em seguida,
serao convertidos em JSON e enviados para nossa API
'''
nfce = {}
items = {}
formas_pagamento={}

nfce["cnpj_emitente"] = "99999999999999"
nfce["nome_emitente"] = "Acme ink"
nfce["nome_fantasia_emitente"] = "Acme ink"
nfce["logradouro_emitente"] = "Rua Tupiniquim"
nfce["numero_emitente"] = "4000"
nfce["bairro_emitente"] = "Brás"
nfce["municipio_emitente"] = "São Paulo"
nfce["uf_emitente"] = "SP"
nfce["cep_emitente"] = "99997-000"
nfce["inscricao_estadual_emitente"] = "111111111"
nfce["data_emissao"] = "2018-03-06T17:11:00.939-03:00"
nfce["natureza_operacao"] = "Venda ao Consumidor"
nfce["tipo_documento"] = "1"
nfce["presenca_comprador"] = "1"
nfce["finalidade_emissao"] = "1"
nfce["modalidade_frete"] = "9"
nfce["forma_pagamento"] = "0"
nfce["nome_destinatario"] = "NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL"
nfce["cpf_destinatario"] = "99999999999"
nfce["informacoes_adicionais_contribuinte"] = "Informacoes adicionais do contribuinte"
nfce["valor_produtos"] = "15.0"
nfce["valor_desconto"] = "0.00"
nfce["valor_total"] = "15.0"
formas_pagamento["forma_pagamento"] = "4"
formas_pagamento["valor_pagamento"] = "15.00"
formas_pagamento["bandeira_operadora"] = "7"
formas_pagamento["troco"] = "0"
itens["numero_item"] = "1"
itens["codigo_produto"] = "353"
itens["descricao"] = "NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL"
itens["codigo_ncm"] = "48024090"
itens["cfop"] = "5102"
itens["valor_desconto"] = "0.00"
itens["icms_origem"] = "0"
itens["icms_situacao_tributaria"] = "400"
itens["unidade_comercial"] = "UN"
itens["unidade_tributavel"] = "UN"
itens["quantidade_comercial"] = "10"
itens["quantidade_tributavel"] = "10"
itens["valor_unitario_comercial"] = "1.5"
itens["valor_unitario_tributavel"] = "1.5"
itens["valor_bruto"] = "15.00"

# Adicionamos os dados das variaveis itens e formas_pagamento como listas ao dicionario principal.
nfce["items"] = [itens]
nfce["formas_pagamento"] = [formas_pagamento]

r = requests.post(url, params=ref, data=json.dumps(nfce), auth=(token,""))

# Mostra na tela o codigo HTTP da requisicao e a mensagem de retorno da API
print(r.status_code, r.text)

```

```shell
# arquivo.json deve conter os dados da NFCe
curl -u token_enviado_pelo_suporte: \
  -X POST -T arquivo.json http://homologacao.acrasnfe.acras.com.br/v2/nfce
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

public class NFCe_autorizar {

	public static void main(String[] args) throws JSONException{

		String login = "Token_enviado_pelo_suporte";

		/* Substituir pela sua identificação interna da nota. */
		String ref = "12345";

		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
 		String server = "http://homologacao.acrasnfe.acras.com.br/";

		String url = server.concat("v2/nfce?ref="+ ref+"&completa=1");

	    /* Configuração para realizar o HTTP BasicAuth. */
		Object config = new DefaultClientConfig();
		Client client = Client.create((ClientConfig) config);
		client.addFilter(new HTTPBasicAuthFilter(login, ""));

		/* Aqui são criados as hash's que receberão os dados da nota. */
		HashMap<String, String> nfce = new HashMap<String, String>();
		HashMap<String, String> itens = new HashMap<String, String>();
		HashMap<String, String> formasPagamento = new HashMap<String, String>();

		nfce.put("data_emissao", "2018-01-15T16:25:00");
		nfce.put("consumidor_final", "1");
		nfce.put("modalidade_frete", "9");
		nfce.put("natureza_operacao", "Venda ao Consumidor");
		nfce.put("tipo_documento", "1");
		nfce.put("finalidade_emissao", "1");
		nfce.put("presenca_comprador", "1");
		nfce.put("indicador_inscricao_estadual_destinatario", "9");
		nfce.put("cnpj_emitente", "51916585000125");
		nfce.put("cpf_destinatario", "");
		nfce.put("id_estrangeiro_destinatario", "1234567");
		nfce.put("nome_destinatario", "NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL");
		nfce.put("informacoes_adicionais_contribuinte", "Documento emitido por ME ou EPP optante pelo Simples Nacional nao gera direito a credito fiscal de ICMS lei 123/2006.");
		nfce.put("valor_produtos", "1.0000");
		nfce.put("valor_desconto", "0.0000");
		nfce.put("valor_total", "1.0000");
		nfce.put("forma_pagamento", "0");
		nfce.put("icms_base_calculo", "0.0000");
		nfce.put("icms_valor_total", "0.0000");
		nfce.put("icms_base_calculo_st", "0.0000");
		nfce.put("icms_valor_total_st", "0.0");
		nfce.put("icms_modalidade_base_calculo", "3");
		nfce.put("valor_frete", "0.0");
		itens.put("numero_item", "1");
		itens.put("unidade_comercial", "PC");
		itens.put("unidade_tributavel", "PC");
		itens.put("codigo_ncm", "94019090");
		itens.put("codigo_produto", "Div.13350000");
		itens.put("descricao", "NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL");
		itens.put("cfop", "5102");
		itens.put("valor_unitario_comercial", "1.0000000000");
		itens.put("valor_unitario_tributavel", "1.0000000000");
		itens.put("valor_bruto", "1.0000");
		itens.put("quantidade_comercial", "1.0000");
		itens.put("quantidade_tributavel", "1.0000");
		itens.put("quantidade", "1.0000");
		itens.put("icms_origem", "0");
		itens.put("icms_base_calculo", "1.00");
		itens.put("icms_modalidade_base_calculo", "3");
		itens.put("valor_frete", "0.0");
		itens.put("valor_outras_despesas", "0.0");
		itens.put("icms_situacao_tributaria", "102");
		formasPagamento.put("forma_pagamento", "99");
		formasPagamento.put("valor_pagamento", "1.0000");

		/* Depois de fazer o input dos dados, são criados os objetos JSON já com os valores das hash's. */
		JSONObject json = new JSONObject (nfce);
		JSONObject JsonItens = new JSONObject (itens);
		JSONObject JsonPagamento = new JSONObject (formasPagamento);

		/* Aqui adicionamos os objetos JSON nos campos da API como array no JSON principal. */
		json.append("items", JsonItens);
		json.append("formas_pagamento", JsonPagamento);

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
   "cnpj_emitente" => "51916585000125",
   "data_emissao" => "2017-12-07T12:40:10",
   "indicador_inscricao_estadual_destinatario" => "9",
   "modalidade_frete" => "9",
   "local_destino" => "1",
   "presenca_comprador" => "1",
   "natureza_operacao" => "VENDA AO CONSUMIDOR",
  "itens" => array(
    array(
      "numero_item" => "1",
         "codigo_ncm" => "62044200",
         "quantidade_comercial" => "1.00",
         "quantidade_tributavel" => "1.00",
         "cfop" => "5102",
         "valor_unitario_tributavel" => "1.00",
         "valor_unitario_comercial" => "1.00",
         "valor_desconto" => "0.00",
         "descricao" => "NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL",
         "codigo_produto" => "251887",
         "icms_origem" => "0",
         "icms_situacao_tributaria" => "102",
         "unidade_comercial" => "un",
         "unidade_tributavel" => "un",
         "valor_total_tributos" => "1.00"
    )
  ),
  "formas_pagamento" => array(
    array(
         "forma_pagamento" => "03",
         "valor_pagamento" => "1.00",
         "nome_credenciadora" => "Cielo",
         "bandeira_operadora" => "02",
         "numero_autorizacao" => "R07242"
     )
  ),
);
// Inicia o processo de envio das informações usando o cURL.
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $server."/v2/nfce?ref=" . $ref);
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

```javascript

/*
As orientacoes a seguir foram extraidas do site do NPMJS: https://www.npmjs.com/package/xmlhttprequest
Here's how to include the module in your project and use as the browser-based XHR object.
Note: use the lowercase string "xmlhttprequest" in your require(). On case-sensitive systems (eg Linux) using uppercase letters won't work.
*/
var XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;

var request = new XMLHttpRequest();

var token = "Token_enviado_pelo_suporte";

// Substituir pela sua identificação interna da nota
var ref = "12345";

/*
Para ambiente de producao use a URL abaixo:
"https://api.focusnfe.com.br"
*/
var url = "http://homologacao.acrasnfe.acras.com.br/v2/nfce?ref=" + ref;

/*
Use o valor 'false', como terceiro parametro para que a requisicao aguarde a resposta da API
Passamos o token como quarto parametro deste metodo, como autenticador do HTTP Basic Authentication.
*/
request.open('POST', url, false, token);

var nfce = {
"natureza_operacao":"VENDA AO CONSUMIDOR",
"data_emissao":"2018-03-21T11:52:00-03:00",
"tipo_documento":"1",
"presenca_comprador":"1",
"consumidor_final":"1",
"finalidade_emissao":"1",
"cnpj_emitente":"51916585000125",
"nome_destinatario":"",
"cpf_destinatario":"",
"informacoes_adicionais_contribuinte":"RETIRADA POR CONTA DO DESTINATÁRIO",
"valor_produtos":"1.00",
"valor_desconto":"0.00",
"valor_total":"1.00",
"forma_pagamento":"0",
"icms_valor_total":"0",
"modalidade_frete": "9",
"items":[
    {"numero_item":"1",
     "codigo_ncm":"84713012",
     "codigo_produto":"999",
     "descricao":"NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL",
     "quantidade_comercial":"1.00",
     "quantidade_tributavel":"1.00",
     "cfop":"5102",
     "valor_unitario_comercial":"1.00",
     "valor_unitario_tributavel":"1.00",
     "valor_bruto":"1.00",
     "unidade_comercial":"un",
     "unidade_tributavel":"un",
     "icms_origem":"2",
     "icms_situacao_tributaria":"102",
     "icms_aliquota":"0",
     "icms_base_calculo":"0",
     "icms_modalidade_base_calculo":"3"
    }        
  ],
    "formas_pagamento":[
        {"forma_pagamento":"1",
         "valor_pagamento":"1.00"
        }
    ]
};

// Aqui fazermos a serializacao do JSON com os dados da nota e enviamos atraves do metodo usado.
request.send(JSON.stringify(nfce));

// Sua aplicacao tera que ser capaz de tratar as respostas da API.
console.log("HTTP code: " + request.status);
console.log("Corpo: " + request.responseText);

```


Para enviar uma NFCe utilize a URL abaixo, alterando o ambiente de produção para homologação, caso esteja emitindo notas de teste.

Envia uma NFCe para autorização:

`https://api.focusnfe.com.br/v2/nfce?ref=REFERENCIA&completa=(0|1)`

Utilize o comando HTTP POST para enviar a sua nota para nossa API. A URL recebe como parâmetro a referência no campo “ref” e pode ser informado opcionalmente o campo “completa” com o valor 1 (verdadeiro) ou 0 (falso). Este parâmetro indica se será exibida a nota completa caso ela seja autorizada. Esta operação é detalhada na próxima seção.

Envie como corpo do POST os dados em formato JSON da nota fiscal.

A numeração da nota (número e série) pode ser definido automaticamente pela API, nós recomendamos que deixe a sua numeração sob nossa responsabilidade, por questões de simplicidade. Entretanto, você pode controlar o envio destas informações pela sua aplicação, basta informar os campos **“numero”** e **“serie”** nos dados de envio.

O envio de uma NFCe é um processo **síncrono**, ou seja, diferente da NFe a nota é autorizada ou rejeitada na mesma requisição. A resposta da requisição irá conter o mesmo resultado que a operação da consulta, descrita a seguir.

## Consulta
```python
# Faça o download e instalação da biblioteca requests, através do python-pip.
import requests

'''
Para ambiente de produção use a variável abaixo:
url = "https://api.focusnfe.com.br"
'''
url = "http://homologacao.acrasnfe.acras.com.br/v2/nfce/"

# Substituir pela sua identificação interna da nota
ref = "1234"

token="token_enviado_pelo_suporte"

# Use este parametro para obter mais informacoes em suas consultas
completa = "completa=1"

r = requests.get(url+ref, params=completa, auth=(token,""))

# Mostra na tela o codigo HTTP da requisicao e a mensagem de retorno da API
print(r.status_code, r.text)l

```

```shell
curl -u token_enviado_pelo_suporte: \
  http://homologacao.acrasnfe.acras.com.br/v2/nfce/12345
```

```java
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;

public class NFCe_consulta {

	public static void main(String[] args) {

		String login = "Token_enviado_pelo_suporte";

		/* Substituir pela sua identificação interna da nota. */
		String ref = "12345";

		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
 		String server = "http://homologacao.acrasnfe.acras.com.br/";

 		String url = server.concat("v2/nfce/"+ref+"?completa=1");

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
curl_setopt($ch, CURLOPT_URL, $server."/v2/nfce/" . $ref);
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

```javascript

/*
As orientacoes a seguir foram extraidas do site do NPMJS: https://www.npmjs.com/package/xmlhttprequest
Here's how to include the module in your project and use as the browser-based XHR object.
Note: use the lowercase string "xmlhttprequest" in your require(). On case-sensitive systems (eg Linux) using uppercase letters won't work.
*/
var XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;

var request = new XMLHttpRequest();

var token = "Token_enviado_pelo_suporte";

// Substituir pela sua identificação interna da nota
var ref = "12345";

/*
Para ambiente de producao use a URL abaixo:
"https://api.focusnfe.com.br"
*/
var url = "http://homologacao.acrasnfe.acras.com.br/v2/nfce/" + ref + "?completa=1";

/*
Use o valor 'false', como terceiro parametro para que a requisicao aguarde a resposta da API
Passamos o token como quarto parametro deste metodo, como autenticador do HTTP Basic Authentication.
*/
request.open('GET', url, false, token);

request.send();

// Sua aplicacao tera que ser capaz de tratar as respostas da API.
console.log("HTTP code: " + request.status);
console.log("Corpo: " + request.responseText);

```


Para consultar uma NFCe utilize a URL abaixo, alterando o ambiente de produção para homologação, caso esteja emitindo notas de teste.

Consultar as informações de uma NFCe:

`https://api.focusnfe.com.br/v2/nfce/REFERENCIA?completa=(0|1)`

Utilize o comando **HTTP GET** para consultar a sua nota para nossa API.

Parâmetro Opcional | Ação
-------|-------|-----
completo = 0 ou 1 | Habilita a API há mostrar campos adicionais na requisição de consulta.


> Exemplo de resposta da consulta de NFCe (completa=0):

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
"caminho_danfe":"/arquivos/733530172/201704/DANFEs/41170777627353999172550010000003871980884091.pdf"
}
```

Campos de retorno:

* **status:** A situação da NFCe, podendo ser:
   * **autorizado:** A nota foi autorizada, neste caso é fornecido os dados completos da nota como chave e arquivos para download
   * **cancelado:** O documento foi cancelado, neste caso é fornecido o caminho para download do XML de cancelamento (caminho_xml_cancelamento).
   * **erro_autorizacao:** Houve um erro de autorização por parte da SEFAZ. A mensagem de erro você encontrará nos campos status_sefaz e mensagem_sefaz. É possível fazer o reenvio da nota com a mesma referência se ela estiver neste estado.
   * **denegado:** O documento foi denegado. Uma SEFAZ pode denegar uma nota se houver algum erro cadastral nos dados do destinatário ou do emitente. A mensagem de erro você encontrará nos campos status_sefaz e mensagem_sefaz. Não é possível reenviar a nota caso este estado seja alcançado pois é gerado um número, série, chave de NFe e XML para esta nota. O XML deverá ser armazenado pelo mesmo período de uma nota autorizada ou cancelada.
* **status_sefaz:** O status da nota na SEFAZ.
* **mensagem_sefaz:** Mensagem descritiva da SEFAZ detalhando o status.
* **serie:** A série da nota fiscal, caso ela tenha sido autorizada.
* **numero:** O número da nota fiscal, caso ela tenha sido autorizada.
* **cnpj_emitente:** O CNPJ emitente da nota fiscal (o CNPJ de sua empresa).
* **ref:** A referência da emissão.
* **chave_nfe:** A chave da NFe, caso ela tenha sido autorizada.
* **caminho_xml_nota_fiscal:** caso a nota tenha sido autorizada, retorna o caminho para download do XML.
* **caminho_danfe:** caso a nota tenha sido autorizada retorna o caminho para download do DANFe.
* **caminho_xml_cancelamento:** Caso a nota esteja cancelada, é fornecido o caminho para fazer o download do XML de cancelamento.

Caso na requisição seja passado o parâmetro `completa=1` será adicionado mais 6 campos:

* **requisicao_nota_fiscal**: Inclui os dados completos da requisição da nota fiscal, da mesma forma que constam no XML da nota.
* **protocolo_nota_fiscal**: Inclui os dados completos do protocolo devolvido pela SEFAZ.
* **requisicao_cancelamento**: Inclui os dados completos da requisição de cancelamento da nota fiscal.
* **protocolo_cancelamento**: Inclui os dados completos do protocolo devolvido pela SEFAZ.
* **requisicao_carta_correcao**: Inclui os dados completos da requisição de Carta de Correção Eletrônica da NFe.
* **protocolo_carta_correcao**: Inclui os dados completos do protocolo devolvido pela SEFAZ.

> Exemplo de campos extras na consulta completa (completa=1):

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

## Cancelamento
```python
# Faça o download e instalação da biblioteca requests, através do python-pip.
import json
import requests

'''
Para ambiente de produção use a variável abaixo:
url = "https://api.focusnfe.com.br"
'''
url = "http://homologacao.acrasnfe.acras.com.br/v2/nfce/"

# Substituir pela sua identificação interna da nota
ref = "12345"

token="token_enviado_pelo_suporte"

'''
Usamos um dicionario para armazenar os campos e valores que em seguida,
serao convertidos a JSON e enviados para nossa API
'''
justificativa={}
justificativa["justificativa"] = "Sua justificativa aqui!"

r = requests.delete(url+ref, data=json.dumps(justificativa), auth=(token,""))

# Mostra na tela o codigo HTTP da requisicao e a mensagem de retorno da API
print(r.status_code, r.text)


```

```shell
curl -u token_enviado_pelo_suporte: \
  -X DELETE -d '{"justificativa":"Teste de cancelamento de nota"}' \
  http://homologacao.acrasnfe.acras.com.br/v2/nfce/12345
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

public class NFCe_cancelamento {

	public static void main(String[] args){

		String login = "Token_enviado_pelo_suporte";

		/* Substituir pela sua identificação interna da nota. */
		String ref = "12345";

		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
 		String server = "http://homologacao.acrasnfe.acras.com.br/";

		String url = server.concat("v2/nfce/"+ref);

		/* Aqui criamos um hashmap para receber a chave "justificativa" e o valor desejado. */		
		HashMap<String, String> justificativa = new HashMap<String, String>();
		justificativa.put("justificativa", "Informe aqui a sua justificativa para realizar o cancelamento da NFCe.");

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
curl_setopt($ch, CURLOPT_URL, $server . "/v2/nfce/" . $ref);
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

```javascript

/*
As orientacoes a seguir foram extraidas do site do NPMJS: https://www.npmjs.com/package/xmlhttprequest
Here's how to include the module in your project and use as the browser-based XHR object.
Note: use the lowercase string "xmlhttprequest" in your require(). On case-sensitive systems (eg Linux) using uppercase letters won't work.
*/
var XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;

var request = new XMLHttpRequest();

var token = "Token_enviado_pelo_suporte";

// Substituir pela sua identificação interna da nota.
var ref = "12345";

/*
Para ambiente de producao use a URL abaixo:
"https://api.focusnfe.com.br"
*/
var url = "http://homologacao.acrasnfe.acras.com.br/v2/nfe/"+ ref;

/*
Use o valor 'false', como terceiro parametro para que a requisicao aguarde a resposta da API
Passamos o token como quarto parametro deste metodo, como autenticador do HTTP Basic Authentication.
*/
request.open('DELETE', url, false, token);

var cancelar = {

	"justificativa": "Sua justificativa aqui!"
};

// Aqui fazermos a serializacao do JSON com os dados da nota e enviamos atraves do metodo usado.
request.send(JSON.stringify(cancelar));

// Sua aplicacao tera que ser capaz de tratar as respostas da API.
console.log("HTTP code: " + request.status);
console.log("Corpo: " + request.responseText);

```


Para cancelar uma NFCe, basta fazer uma requisição à URL abaixo, alterando o ambiente de produção para homologação, caso esteja emitindo notas de teste.

Cancelar uma NFCe já autorizada:

`https://api.focusnfe.com.br/v2/nfce/REFERENCIA`

Utilize o comando HTTP **DELETE** para cancelar a sua nota para nossa API. Este método é síncrono, ou seja, a comunicação com a SEFAZ será feita imediatamente e devolvida a resposta na mesma requisição.

O parâmetros de cancelamento deverão ser enviados da seguinte forma:

* **justificativa:** Justificativa do cancelamento. Deverá conter de 15 a 255 caracteres.

A API irá em seguida devolver os seguintes campos:

* **status:** cancelado, se a nota pode ser cancelada, ou erro_cancelamento, se houve algum erro ao cancelar a nota.
* **status_sefaz:** O status do cancelamento na SEFAZ.
* **mensagem_sefaz:** Mensagem descritiva da SEFAZ detalhando o status.
* **caminho_xml_cancelamento:** Caso a nota tenha sido cancelada, será informado aqui o caminho para download do XML de cancelamento.

**Prazo de cancelamento**

A NFCe poderá ser cancelada em até 24 horas após a emissão.

## Inutilização
```python
# Faça o download e instalação da biblioteca requests, através do python-pip.
import json
import requests

'''
Para ambiente de produção use a variável abaixo:
url = "https://api.focusnfe.com.br"
'''
url = "http://homologacao.acrasnfe.acras.com.br/v2/nfce/inutilizacao"

token="token_enviado_pelo_suporte"

'''
Usamos dicionarios e listas para armazenar os campos e valores que em seguida,
serao convertidos em JSON e enviados para nossa API
'''
inutilizacao={}
inutilizacao["cnpj"] = "CNPJ da empresa emitente"
inutilizacao["serie"] = "Serie da numeracao da NFCe que tera uma faixa de numeracao inutilizada"
inutilizacao["numero_inicial"] = "Numero inicial a ser inutilizado"
inutilizacao["numero_final"] = "Numero final a ser inutilizado"
inutilizacao["justificativa"] = "Justificativa da inutilizacao (minimo 15 caracteres)"

r = requests.post(url, data=json.dumps(inutilizacao), auth=(token,""))

# Mostra na tela o codigo HTTP da requisicao e a mensagem de retorno da API
print(r.status_code, r.text)

```

```shell
curl -u token_enviado_pelo_suporte: \
  -X POST -d '{"cnpj":"51916585009999","serie":"9","numero_inicial":"7730","numero_final":"7732","justificativa":"Teste de inutilizacao de nota"}' \
  http://homologacao.acrasnfe.acras.com.br/v2/nfce/inutilizacao
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

public class NFCe_inutilizacao {

	public static void main(String[] args) throws JSONException{

		String login = "Token_enviado_pelo_suporte";

		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
 		String server = "http://homologacao.acrasnfe.acras.com.br/";

 		String url = server.concat("v2/nfce/inutilizacao");

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

```php
<?php
/* Você deve definir isso globalmente para sua aplicação.
Para ambiente de produção utilize e a variável abaixo:
$server = "https://api.focusnfe.com.br"; */
$server = "http://homologacao.acrasnfe.acras.com.br";
$login = "token_enviado_pelo_suporte";
$password = "";
$inutiliza = array (
  "cnpj" => "51916585000125",
  "serie" => "1",
  "numero_inicial" => "107",
  "numero_final" => "109",
  "justificativa" => "Teste+de+inutilizacao+de+nota"  
);
// Inicia o processo de envio das informações usando o cURL.
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $server."/v2/nfce/inutilizacao");
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

```javascript

/*
As orientacoes a seguir foram extraidas do site do NPMJS: https://www.npmjs.com/package/xmlhttprequest
Here's how to include the module in your project and use as the browser-based XHR object.
Note: use the lowercase string "xmlhttprequest" in your require(). On case-sensitive systems (eg Linux) using uppercase letters won't work.
*/
var XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;

var request = new XMLHttpRequest();

var token = "Token_enviado_pelo_suporte";

/*
Para ambiente de producao use a URL abaixo:
"https://api.focusnfe.com.br"
*/
var url = "http://homologacao.acrasnfe.acras.com.br/v2/nfce/inutilizacao";

/*
Use o valor 'false', como terceiro parametro para que a requisicao aguarde a resposta da API
Passamos o token como quarto parametro deste metodo, como autenticador do HTTP Basic Authentication.
*/
request.open('POST', url, false, token);

var inutiliza = {
"cnpj": "51916585000125",
"serie": "1",
"numero_inicial": "700",
"numero_final": "703",
"justificativa": "Teste de inutilizacao de nota"
};

// Aqui fazermos a serializacao do JSON com os dados da nota e enviamos atraves do metodo usado.
request.send(JSON.stringify(inutiliza));

// Sua aplicacao tera que ser capaz de tratar as respostas da API.
console.log("HTTP code: " + request.status);
console.log("Corpo: " + request.responseText);

```



Em uma situação normal você não precisará informar ao SEFAZ a inutilização de um número da NFCe, pois a API controla automaticamente a numeração das notas. Porém, se por alguma situação específica for necessário a inutilização de alguma faixa de números você poderá chamar as seguintes operações:

Envio de inutilização de faixa de numeração:

`https://api.focusnfe.com.br/v2/nfce/inutilizacao`

Utilize o comando HTTP **POST** para enviar a sua inutilização para nossa API. Este método é **síncrono**, ou seja, a comunicação com a SEFAZ será feita imediatamente e devolvida a resposta na mesma requisição.

A inutilização precisa dos seguintes parâmetros obrigatórios:

* **cnpj:** CNPJ da empresa emitente
* **serie:** Série da numeração da NFCe que terá uma faixa de numeração inutilizada
* **numero_inicial:** Número inicial a ser inutilizado
* **numero_final:** Número final a ser inutilizado
* **justificativa:** Justificativa da inutilização (mínimo 15 caracteres)

A API irá enviar uma resposta com os seguintes campos:

* **status:** autorizado, se a inutilização foi aceita pela SEFAZ, ou erro_autorizacao, se houve algum erro ao inutilizar os números.
* **status_sefaz:** O status da carta de correção na SEFAZ.
* **mensagem_sefaz:** Mensagem descritiva da SEFAZ detalhando o status.
* **serie:** Série da numeração da NFCe que terá uma faixa de numeração inutilizada
* **numero_inicial:** Número inicial a ser inutilizado
* **numero_final:** Número final a ser inutilizado
* **caminho_xml:** Caminho do XML para download caso a inutilização tenha sido autorizada pela SEFAZ.

## Reenvio de e-mail
```python
# Faça o download e instalação da biblioteca requests, através do python-pip.
import json
import requests

'''
Para ambiente de produção use a variável abaixo:
url = "https://api.focusnfe.com.br"
'''
url = "http://homologacao.acrasnfe.acras.com.br/v2/nfce/"

# Substituir pela sua identificação interna da nota
ref = "12345"

token="token_enviado_pelo_suporte"

'''
Usamos um dicionario para armazenar os campos e valores que em seguida,
serao convertidos a JSON e enviados para nossa API
'''
emails = {}
email = "suporte@acras.com.br"
emails["emails"] = [email]

r = requests.delete(url+ref+"/email", data=json.dumps(emails), auth=(token,""))

# Mostra na tela o codigo HTTP da requisicao e a mensagem de retorno da API
print(r.status_code, r.text)l

```

```shell
curl -u token_enviado_pelo_suporte: \
  -X POST -d '{"emails":["alguem@example.org"]}' \
  http://homologacao.acrasnfe.acras.com.br/v2/nfce/12345/email
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

public class NFCe_envia_email {

	public static void main(String[] args) throws JSONException{

		String login = "Token_enviado_pelo_suporte";

		/* Substituir pela sua identificação interna da nota. */
		String ref = "12345";

		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
 		String server = "http://homologacao.acrasnfe.acras.com.br/";

		String url = server.concat("v2/nfce/"+ref+"/email");

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
$email = array (
  "emails" => array(
    "email@email.com"
    )
  );
// Inicia o processo de envio das informações usando o cURL.
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $server."/v2/nfce/" . $ref . "/email");
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

```javascript

/*
As orientacoes a seguir foram extraidas do site do NPMJS: https://www.npmjs.com/package/xmlhttprequest
Here's how to include the module in your project and use as the browser-based XHR object.
Note: use the lowercase string "xmlhttprequest" in your require(). On case-sensitive systems (eg Linux) using uppercase letters won't work.
*/
var XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;

var request = new XMLHttpRequest();

var token = "Token_enviado_pelo_suporte";

// Substituir pela sua identificação interna da nota.
var ref = "12345";

/*
Para ambiente de producao use a URL abaixo:
"https://api.focusnfe.com.br"
*/
var url = "http://homologacao.acrasnfe.acras.com.br/v2/nfce/" + ref + "/email";

/*
Use o valor 'false', como terceiro parametro para que a requisicao aguarde a resposta da API
Passamos o token como quarto parametro deste metodo, como autenticador do HTTP Basic Authentication.
*/
request.open('POST', url, false, token);

var email = ["email1@acras.com.br", "email2@acras.com.br", "email3@acras.com.br"];

// Aqui fazermos a serializacao do JSON com os dados da nota e enviamos atraves do metodo usado.
var json = JSON.stringify({"emails": email});

request.send(json);

// Sua aplicacao tera que ser capaz de tratar as respostas da API.
console.log("HTTP code: " + request.status);
console.log("Corpo: " + request.responseText);

```



Para cada nota autorizada, cancelada ou que tenha sido emitida uma carta de correção o destinatário da nota é notificado via email. Porém eventualmente pode ser necessário enviar a nota fiscal para outras pessoas ou mesmo reenviar o email para o mesmo destinatário.

Para enviar um ou mais emails:

`https://api.focusnfe.com.br/v2/nfce/REFERENCIA/email`

Utilize o comando HTTP **POST** para enviar os emails. Esta operação aceita apenas um parâmetro:

* **emails:** Array com uma lista de emails que deverão receber uma cópia da nota. Limitado a 10 emails por vez.

A API imediatamente devolve a requisição com a confirmação dos emails. Os emails serão enviados em segundo plano, por isso pode levar alguns minutos até que eles cheguem à caixa postal.

## Outras documentações

### Enviador de Arquivos

Para usuários de tecnologias que não permitem o acesso à API via Web Services ou que não desejam programar o acesso HTTP, disponibilizamos um comunicador que realiza toda comunicação com os Web Services de nossa API. Para utilizar o enviador de arquivos basta rodar um executável simples e salvar as notas em uma pasta específica que o enviador fará o resto.



Instalação e Configuração
O Enviador de Arquivos não possui um instalador específico, ele é apenas um executável standalone. Este executável quando é rodado irá ler as configurações de um arquivo texto chamado nfce.ini que deve estar localizado na mesma pasta em que ele está e que possui o formato a seguir:

`[nfce]`
`dir=C:\Users\acras\Desktop\nfces`
`cnpj_emitente=20220080000106`
`token=ipPjf0dTqOw66Hih1eyZjWq7IQIIFgxO`
`producao=0`

Onde:

* **dir:** Diretório base para a comunicação.
* **cnpj_emitente:** CNPJ do emitente das notas.
* **token:** Token de acesso fornecido pela nossa equipe de suporte (os tokens de homologação e produção são distintos).
* **producao:** 0=Homologação, 1=Produção.



**Diretório e nome dos arquivos**

Abaixo do diretório base os diretórios a seguir serão utilizados pelo Enviador de Arquivos:

* **envios:** Este diretório será lido pelo Enviador, que ao encontrar arquivos com extensão .nfce irá realizar o envio
* **enviados:** Este diretório irá guardar uma cópia fiel do arquivo que foi recebido com o mesmo nome ou com o nome adicionado de um _N onde N é um sequencial, no caso de reenvios.
* **processados:** Neste diretório o Enviador de Arquivos irá armazenar as respostas recebidas do servidor, ele irá adicionar a extensão .resp.raw.json e irá conter o JSON bruto recebido do servidor
* **retornos:** Nesta pasta o enviador irá gravar o retorno dos processamentos. Tanto envios (.nfce) quanto cancelamentos (.canc) serão posicionados neste diretório com o resultado da operação.

Os arquivos a serem enviados devem possuir a extensão .nfce (envios) e .canc(cancelamentos) e serem nomeados com a ref a ser utilizada para aquela nota (Veja a seção referência acima). É importante observar que o Enviador de arquivos não possui qualquer inteligência com relação à referência utilizada, de forma que ele irá apenas repassar para a API. Se uma referência já previamente usada for usada novamente você irá receber o erro de nota já autorizada.



**Cancelamentos**

Para cancelar uma NFCe basta salvar um arquivo com nome igual à ref usada no envio e a extensão .canc. O conteúdo do arquivo deverá ser a justificativa do cancelamento (que deve conter entre 15 e 200 caracteres).

Após processado o cancelamento um arquivo com o mesmo nome será gravado no diretório retornos contendo um JSON simples com o resultado da operação indicando que a NFCe foi cancelada ou se deu erro.

**Reimpressão**
Para realizar a reimpressão de determinada NFCe basta salvar um arquivo com nome igual à ref usada no envio e extensão .reimp.

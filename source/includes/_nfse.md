# NFSe

Através da API NFSe é possível:

 * Emitir NFSe para qualquer município utilizando um único modelo de dados. Este processo é **assíncrono**. Ou seja, após a emissão a nota será enfileirada para processamento.
 * Cancelar NFSe
 * Consultar NFSe’s emitidas
 * Encaminhar uma NFSe autorizada por email

## URLs

Método | URL (recurso) | Ação
-------|---------------|------
POST|/v2/nfse?ref=REFERENCIA | Cria uma nota fiscal e a envia para processamento.
GET|/v2/nfse/REFERENCIA | Consulta a nota fiscal com a referência informada e o seu status de processamento
DELETE|/v2/nfse/REFERENCIA | Cancela uma nota fiscal com a referência informada
POST|/v2/nfse/REFERENCIA/email | Envia um email com uma cópia da nota fiscal com a referência informada


## Campos

Cada prefeitura pode utilizar um formato diferente de XML, mas utilizando nossa API você utiliza
um formato único de campos para todas as prefeituras. A listagem dos campos segue abaixo.

### Geral

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

- **data_emissao**(*): Data/hora de emissão da NFSe. Alguns municípios como São Paulo não utilizam hora e ela será descartada caso seja fornecida. Formato padrão ISO, exemplo: “2016-12-25T12:00-0300”.
- **natureza_operacao**(*): Natureza da operação. Informar um dos códigos abaixo. Campo ignorado para o município de São Paulo.
  - **1**: Tributação no município;
  - **2**: Tributação fora do município;
  - **3**: Isenção;
  - **4**: Imune;
  - **5**: Exigibilidade suspensa por decisão judicial;
  - **6**: Exigibilidade suspensa por procedimento administrativo (Valor padrão: 1).
- **regime_especial_tributacao**: Informar o código de identificação do regime especial de tributação conforme abaixo. Campo ignorado para o município de São Paulo.
  - **1**: Microempresa municipal;
  - **2**: Estimativa;
  - **3**: Sociedade de profissionais;
  - **4**: Cooperativa;
  - **5**: MEI - Simples Nacional;
  - **6**: ME EPP- Simples Nacional;
* **optante_simples_nacional**(*): Informar verdadeiro ou falso se a empresa for optante pelo Simples Nacional. Campo ignorado pelo município de São Paulo.
* **incentivador_cultural**: Informe verdadeiro ou falso. Valor padrão: falso. Campo ignorado para o município de São Paulo.
- **tributacao_rps**: Usado apenas pelo município de São Paulo. Informe o tipo de tributação:
  - **T**: Operação normal (tributação conforme documento emitido);
  - **I**: Operação isenta ou não tributável, executadas no Município de São Paulo;
  - **F**: Operação isenta ou não tributável pelo Município de São Paulo, executada em outro Município;
  - **J**: ISS Suspenso por Decisão Judicial (neste caso, informar no campo Discriminação dos Serviços, o número do processo judicial na 1a. instância). (Valor padrão “T”).
* **codigo_obra**: Código da obra quando construção civil. Tamanho: 15 caracteres.
* **art**: Código ART quando construção civil. Este campo é ignorado pelo município de São Paulo. Tamanho: 15 caracteres.

### Prestador

- **prestador**:
  - **cnpj**(*): CNPJ do prestador de serviços. Caracteres não numéricos são ignorados.
  - **codigo_municipio**(*): Código IBGE do município do prestador.
  - **inscricao_municipal**(*): Inscrição municipal do prestador de serviços. Caracteres não numéricos são ignorados.

### Tomador
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

### Serviço

- **servico**:
	- **valor_servicos**(*): Valor dos serviços.
	- **valor_deducoes**: Valor das deduções.
	- **valor_pis**: Valor do PIS.
	- **valor_cofins**: Valor do COFINS.
	- **valor_inss**: Valor do INSS.
	- **valor_ir**: Valor do IRRF.
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

### Intermediário
- **intermediario** (esta seção é ignorada pelo município de São Paulo)
	- **razao_social**: Razão social do intermediário do serviço. Tamanho: 115 caracteres.
	- **cpf**: CPF do intermediário do serviço, se aplicável. Caracteres não numéricos são ignorados.
	- **cnpj**: CNPJ do intermediário do serviço, se aplicável. Caracteres não numéricos são ignorados.
	- **inscricao_municipal**: Inscrição municipal do intermediário do serviço, se aplicável. Caracteres não numéricos são ignorados.

## Envio
```python
# Faça o download e instalação da biblioteca requests, através do python-pip.
import json
import requests

'''
Para ambiente de produção use a variável abaixo:
url = "https://api.focusnfe.com.br"
'''
url = "http://homologacao.acrasnfe.acras.com.br/v2/nfse.json"

# Substituir pela sua identificação interna da nota
ref = {"ref":"12345"}

token="token_enviado_pelo_suporte"

'''
Usamos dicionarios para armazenar os campos e valores que em seguida,
serao convertidos em JSON e enviados para nossa API
'''
nfse = {}
nfse["prestador"] = {}
nfse["servico"] = {}
nfse["tomador"] = {}
nfse["tomador"]["endereco"] = {}

nfse["razao_social"] = "ACME INK"
nfse["data_emissao"] = "2018-02-26T12:00:00-03:00"
nfse["incentivador_cultural"] =  "false"
nfse["natureza_operacao"] = "1"
nfse["optante_simples_nacional"] = "true"
nfse["status"] = "1"
nfse["prestador"]["cnpj"] = "99999999999999"
nfse["prestador"]["inscricao_municipal"] = "99999999"
nfse["prestador"]["codigo_municipio"] = "9999999"
nfse["servico"]["aliquota"] = "2.92"
nfse["servico"]["base_calculo"] = "1.00"
nfse["servico"]["discriminacao"] = "SERVICOS E MAO DE OBRA"
nfse["servico"]["iss_retido"] = "0"
nfse["servico"]["item_lista_servico"] = "1412"
nfse["servico"]["valor_iss"] = "11.68"
nfse["servico"]["valor_liquido"] = "1.00"
nfse["servico"]["valor_servicos"] = "1.00"
nfse["tomador"]["cnpj"] = "99999999999999"
nfse["tomador"]["razao_social"] = "Parkinson da silva coelho JR"
nfse["tomador"]["endereco"]["bairro"] = "São Miriti"
nfse["tomador"]["endereco"]["cep"] = "31999-000"
nfse["tomador"]["endereco"]["codigo_municipio"] = "9999999"
nfse["tomador"]["endereco"]["logradouro"] = "João Batista Netos"
nfse["tomador"]["endereco"]["numero"] = "34"
nfse["tomador"]["endereco"]["uf"] = "MG"

#print (json.dumps(nfse))
r = requests.post(url, params=ref, data=json.dumps(nfse), auth=(token,""))

# Mostra na tela o codigo HTTP da requisicao e a mensagem de retorno da API
print(r.status_code, r.text)


```

```shell
# arquivo.json deve conter os dados da NFSe
curl -u token_enviado_pelo_suporte: \
  -X POST -T arquivo.json http://homologacao.acrasnfe.acras.com.br/v2/nfse
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

public class NFSeAutorizar {

	public static void main(String[] args) throws JSONException{
		
		String login = "Token_enviado_pelo_suporte";

		/* Substituir pela sua identificação interna da nota. */
		String ref = "12345";
		
		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
 		String server = "http://homologacao.acrasnfe.acras.com.br/";
 		
 		String url = server.concat("v2/nfse?ref="+ref);
 		
 		/* Configuração para realizar o HTTP BasicAuth. */
		Object config = new DefaultClientConfig();
		Client client = Client.create((ClientConfig) config);
		client.addFilter(new HTTPBasicAuthFilter(login, ""));

		/* Aqui são criados as hash's que receberão os dados da nota. */
		HashMap<String, String> nfse = new HashMap<String, String>();
		HashMap<String, String> prestador = new HashMap<String, String>();
		HashMap<String, String> tomador = new HashMap<String, String>();
		HashMap<String, String> tomadorEndereco = new HashMap<String, String>();
		HashMap<String, String> servico = new HashMap<String, String>();

		nfse.put("data_emissao", "2018-01-15T17:40:00");
		nfse.put("natureza_operacao", "1");
		prestador.put("cnpj", "51916585000125");
		prestador.put("inscricao_municipal", "123456");
		prestador.put("codigo_municipio", "4128104");
		tomador.put("cpf", "51966818092");
		tomador.put("razao_social", "ACME LTDA");
		tomador.put("email", "email-do-tomador@google.com.br");
		tomadorEndereco.put("bairro", "Jardim America");
		tomadorEndereco.put("cep", "82620150");
		tomadorEndereco.put("codigo_municipio", "4106902");
		tomadorEndereco.put("logradouro", "Rua Paulo Centrone");
		tomadorEndereco.put("numero", "168");
		tomadorEndereco.put("uf", "PR");
		servico.put("discriminacao", "Teste de servico");
		servico.put("aliquota", "3.00");
		servico.put("base_calculo", "1.0");
		servico.put("valor_iss", "0");
		servico.put("iss_retido", "false");
		servico.put("codigo_tributario_municipio", "080101");
		servico.put("item_lista_servico", "0801");
		servico.put("valor_servicos", "1.0");
		servico.put("valor_liquido", "1.0");
		
		/* Depois de fazer o input dos dados, são criados os objetos JSON já com os valores das hash's. */
		JSONObject json = new JSONObject (nfse);
		JSONObject jsonPrestador = new JSONObject (prestador);
		JSONObject jsonTomador = new JSONObject (tomador);
		JSONObject jsonTomadorEndereco = new JSONObject (tomadorEndereco);
		JSONObject jsonServico = new JSONObject (servico);
		
		/* Aqui adicionamos os objetos JSON nos campos da API como array no JSON principal. */
		json.accumulate("prestador", jsonPrestador);
		json.accumulate("tomador", jsonTomador);
		jsonTomador.accumulate("endereco", jsonTomadorEndereco);
		json.accumulate("servico", jsonServico);

		/* É recomendado verificar como os dados foram gerados em JSON e se ele está seguindo a estrutura especificada em nossa documentação.
		System.out.print(json); */
		
		WebResource request = client.resource(url);

		ClientResponse resposta = request.post(ClientResponse.class, json);

		int httpCode = resposta.getStatus(); 

		String body = resposta.getEntity(String.class);
		
		/* As três linhas a seguir exibem as informações retornadas pela nossa API. 
		 * Aqui o seu sistema deverá interpretar e lidar com o retorno. */
		System.out.print("HTTP Code: ");
		System.out.print(httpCode);
		System.out.printf(body);
	}
}
```

```ruby

# encoding: UTF-8

require "net/http"
require "net/https"
require "json"

# token enviado pelo suporte
token = "codigo_alfanumerico_token"

# referência da nota - deve ser única para cada nota enviada
ref = "id_referencia_nota"

# endereço da api que deve ser usado conforme o ambiente: produção ou homologação
servidor_producao = "https://api.focusnfe.com.br/"
servidor_homologacao = "http://homologacao.acrasnfe.acras.com.br/"

# no caso do ambiente de envio ser em produção, utilizar servidor_producao
url_envio = servidor_homologacao + "v2/nfse?ref=" + ref

# altere os campos conforme a nota que será enviada
dados_da_nota = {  
  data_emissao: "2017-09-21T22:15:00",
  prestador: {  
      cnpj: "18765499000199",
      inscricao_municipal: "12345",
      codigo_municipio: "3516200"
  },
  tomador: {  
      cnpj: "07504505000132",
      razao_social: "Acras Tecnologia da Informação LTDA",
      email: "contatoacras.com.br",
      endereco: {  
        logradouro: "Rua Dias da Rocha Filho",
        numero: "999",
        complemento: "Prédio 04 - Sala 34C",
        bairro: "Alto da XV",
        codigo_municipio: "4106902",
        uf: "PR",
        cep: "80045165"
      }
  },
  servico: {  
      aliquota: 3,
      discriminacao: "Nota fiscal referente a serviços prestados",
      iss_retido: "false",
      item_lista_servico: "0107",
      codigo_tributario_municipio: "620910000",
      valor_servicos: 1.0
  }
}

# criamos uma objeto uri para envio da nota
uri = URI(url_envio)

# também criamos um objeto da classe HTTP a partir do host da uri
http = Net::HTTP.new(uri.hostname, uri.port)

# aqui criamos um objeto da classe Post a partir da uri de requisição
requisicao = Net::HTTP::Post.new(uri.request_uri)

# adicionando o token à requisição
requisicao.basic_auth(token, '')

# convertemos os dados da nota para o formato JSON e adicionamos ao corpo da requisição
requisicao.body = dados_da_nota.to_json

# no envio de notas em produção, é necessário utilizar o protocolo ssl
# para isso, basta retirar o comentário da linha abaixo
# http.use_ssl = true

# aqui enviamos a requisição ao servidor e obtemos a resposta
resposta = http.request(requisicao)

# imprimindo o código HTTP da resposta
puts "Código retornado pela requisição: " + resposta.code

# imprimindo o corpo da resposta
puts "Corpo da resposta: " + resposta.body

```

```php
<?php
 // Você deve definir isso globalmente para sua aplicação
 // Para ambiente de produção use a variável abaixo:
 // $server = "https://api.focusnfe.com.br";
 $server = "http://homologacao.acrasnfe.acras.com.br";
 // Substituir pela sua identificação interna da nota
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
        "razao_social" => "Acras Tecnologia da Informação LTDA",
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
           "discriminacao" => "Exemplo Servi\u00e7o",
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
 //as três linhas abaixo imprimem as informações retornadas pela API, aqui o seu sistema deverá
 //interpretar e lidar com o retorno
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
var url = "http://homologacao.acrasnfe.acras.com.br/v2/nfse?ref=" + ref;

/* 
Use o valor 'false', como terceiro parametro para que a requisicao aguarde a resposta da API
Passamos o token como quarto parametro deste metodo, como autenticador do HTTP Basic Authentication.
*/
request.open('POST', url, false, token);

var nfse = {  
   "data_emissao":"2018-03-21",
   "prestador":{  
      "cnpj":"51916585000125",
      "inscricao_municipal":"12345",
      "codigo_municipio":"3518800"
   },
   "tomador":{  
      "cnpj":"07504505000132",
      "razao_social":"Acras Tecnologia da Informacao LTDA",
      "email":"contato@acras.com.br",
      "endereco":{  
         "logradouro":"Rua Filho da Rocha Bage",
         "numero":"750",
         "complemento":"Sala 07",
         "bairro":"Alto da Rua XV",
         "codigo_municipio":"4106902",
         "uf":"PR",
         "cep":"80045165"
      }
   },
   "servico":{  
      "aliquota":3,
      "discriminacao":"Nota fiscal referente a servicos prestados",
      "iss_retido":"false",
      "item_lista_servico":"1401",
      "codigo_tributario_municipio": "452000100",
      "valor_servicos":1.0
   }
};

// Aqui fazermos a serializacao do JSON com os dados da nota e enviamos atraves do metodo usado.
request.send(JSON.stringify(nfse));

// Sua aplicacao tera que ser capaz de tratar as respostas da API.
console.log("HTTP code: " + request.status);
console.log("Corpo: " + request.responseText);

```


> Resposta da API para a requisição de envio:

```json
{
  "cnpj_prestador": "CNPJ_PRESTADOR",
  "ref": "REFERENCIA",
  "status": "processando_autorizacao"
}
```

Para enviar uma NFSe utilize a URL abaixo, alterando o ambiente de produção para homologação, caso esteja emitindo notas de teste.

Envia uma NFSe para autorização:

`https://api.focusnfe.com.br/v2/nfse.json?ref=REFERENCIA`

Utilize o comando **HTTP POST** para enviar a sua nota para nossa API.

Nesta etapa, é feita uma primeira validação dos dados da nota. Caso ocorra algum problema, por exemplo, algum campo faltante, formato incorreto
ou algum problema com o prestador a nota **não será aceita para processamento** e será devolvida a mensagem de erro apropriada. Veja a seção [erros](#introducao_erros).

Caso a nota seja validada corretamente, a nota será **aceita para processamento**. Isto significa que a nota irá para uma fila de processamento
onde eventualmente será processada (processamento assíncrono). Com isto, a nota poderá ser autorizada ou ocorrer um erro na autorização de acordo com a validação da prefeitura.

Para verificar se a nota já foi autorizada, você terá que efetuar uma [consulta](#nfse_consulta) ou se utilizar de [gatilhos](#gatilhos_gatilhos).

## Consulta
```python
# Faça o download e instalação da biblioteca requests, através do python-pip.
import requests

'''
Para ambiente de produção use a variável abaixo:
url = "https://api.focusnfe.com.br"
'''
url = "http://homologacao.acrasnfe.acras.com.br/v2/nfse/"

# Substituir pela sua identificação interna da nota
ref = "12345"

token="token_enviado_pelo_suporte"

r = requests.get(url+ref+".json", params=completa, auth=(token,""))

# Mostra na tela o codigo HTTP da requisicao e a mensagem de retorno da API
print(r.status_code, r.text)


```



```shell
curl -u token_enviado_pelo_suporte: \
  http://homologacao.acrasnfe.acras.com.br/v2/nfse/12345
```

```java
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;

public class NFSeConsulta {

	public static void main(String[] args){

		String login = "Token_enviado_pelo_suporte";

		/* Substituir pela sua identificação interna da nota. */
		String ref = "12345";
		
		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
 		String server = "http://homologacao.acrasnfe.acras.com.br/";
		
 		String url = server.concat("v2/nfse/"+ref);

 		/* Configuração para realizar o HTTP BasicAuth. */
		Object config = new DefaultClientConfig();
		Client client = Client.create((ClientConfig) config);
		client.addFilter(new HTTPBasicAuthFilter(login, ""));

		WebResource request = client.resource(url);

		ClientResponse resposta = (ClientResponse) request.get(ClientResponse.class);

		int httpCode = resposta.getStatus(); 

		String body = resposta.getEntity(String.class);

		/* As três linhas abaixo imprimem as informações retornadas pela API. 
		 * Aqui o seu sistema deverá interpretar e lidar com o retorno. */
		System.out.print("HTTP Code: ");
		System.out.print(httpCode);
		System.out.printf(body);
	}
}
```

```ruby

# encoding: UTF-8

require "net/http"
require "net/https"

# token enviado pelo suporte
token = "codigo_alfanumerico_token"

# referência da nota - deve ser única para cada nota enviada
ref = "id_referencia_nota"

# endereço da api que deve ser usado conforme o ambiente: produção ou homologação
servidor_producao = "https://api.focusnfe.com.br/"
servidor_homologacao = "http://homologacao.acrasnfe.acras.com.br/"

# no caso do ambiente de envio ser em produção, utilizar servidor_producao
url_envio = servidor_homologacao + "v2/nfse/" + ref

# criamos uma objeto uri para envio da nota
uri = URI(url_envio)

# também criamos um objeto da classe HTTP a partir do host da uri
http = Net::HTTP.new(uri.hostname, uri.port)

# aqui criamos um objeto da classe Get a partir da uri de requisição
requisicao = Net::HTTP::Get.new(uri.request_uri)

# adicionando o token à requisição
requisicao.basic_auth(token, '')

# no envio de notas em produção, é necessário utilizar o protocolo ssl
# para isso, basta retirar o comentário da linha abaixo
# http.use_ssl = true

# aqui enviamos a requisição ao servidor e obtemos a resposta
resposta = http.request(requisicao)

# imprimindo o código HTTP da resposta
puts "Código retornado pela requisição: " + resposta.code

# imprimindo o corpo da resposta
puts "Corpo da resposta: " + resposta.body

```

```php
<?php
 // Você deve definir isso globalmente para sua aplicação
 //Substituir pela sua identificação interna da nota
 $ref = "12345";
 $login = "token_enviado_pelo_suporte";
 $password = "";
 // Para ambiente de produção use a variável abaixo:
 // $server = "https://api.focusnfe.com.br";
 $server = "http://homologacao.acrasnfe.acras.com.br"; // Servidor de homologação
 $ch = curl_init();
 curl_setopt($ch, CURLOPT_URL, $server."/v2/nfse/" . $ref);
 curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
 curl_setopt($ch, CURLOPT_HTTPHEADER, array());
 curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
 curl_setopt($ch, CURLOPT_USERPWD, "$login:$password");
 $body = curl_exec($ch);
 $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
 //as três linhas abaixo imprimem as informações retornadas pela API, aqui o seu sistema deverá
 //interpretar e lidar com o retorno
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
var url = "http://homologacao.acrasnfe.acras.com.br/v2/nfse/" + ref + "?completa=0";

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



> Exemplo de resposta da consulta de NFSe:

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

Após emitir uma nota, você poderá usar a operação de consulta para verificar se a nota já foi aceita para processamento, se está
ainda em processamento ou se a nota já foi processada.

Para consultar uma NFSe utilize a URL abaixo, alterando o ambiente de produção para homologação, caso esteja emitindo notas de teste.

Recupera informações sobre a NFSe:

`https://api.focusnfe.com.br/v2/nfse/REFERENCIA.json`

Utilize o comando **HTTP GET** para consultar a sua nota para nossa API.

## Cancelamento
```python
# Faça o download e instalação da biblioteca requests, através do python-pip.
import json
import requests

'''
Para ambiente de produção use a variável abaixo:
url = "https://api.focusnfe.com.br"
'''
url = "http://homologacao.acrasnfe.acras.com.br/v2/nfse/"

# Substituir pela sua identificação interna da nota
ref = "12345"

token="token_enviado_pelo_suporte"

'''
Usamos um dicionario para armazenar os campos e valores que em seguida,
serao convertidos a JSON e enviados para nossa API
'''
justificativa={}
justificativa["justificativa"] = "Sua justificativa aqui!"

r = requests.delete(url+ref+".json", data=json.dumps(justificativa), auth=(token,""))

# Mostra na tela o codigo HTTP da requisicao e a mensagem de retorno da API
print(r.status_code, r.text)


```

```shell
curl -u token_enviado_pelo_suporte: \
  -X DELETE -d '{"justificativa":"Teste de cancelamento de nota"}' \
  http://homologacao.acrasnfe.acras.com.br/v2/nfse/12345
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

public class NFSeCancelamento {

	public static void main(String[] args){
		
		String login = "Token_enviado_pelo_suporte";

		/* Substituir pela sua identificação interna da nota. */
		String ref = "12345";
		
		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
 		String server = "http://homologacao.acrasnfe.acras.com.br/";
 		
		String url = server.concat("v2/nfse/"+ref);
 		
 		/* Aqui criamos um hashmap para receber a chave "justificativa" e o valor desejado. */
		HashMap<String, String> justificativa = new HashMap<String, String>();
		justificativa.put("justificativa", "Informe aqui a sua justificativa para realizar o cancelamento da NFSe.");
		
		/* Criamos um objeto JSON para receber a hash com os dados esperado pela API. */
		JSONObject json = new JSONObject(justificativa);

		/* Configuração para realizar o HTTP BasicAuth. */
		Object config = new DefaultClientConfig();
		Client client = Client.create((ClientConfig) config);
		client.addFilter(new HTTPBasicAuthFilter(login, ""));

		WebResource request = client.resource(url);

		ClientResponse resposta = request.delete(ClientResponse.class, json);

		int httpCode = resposta.getStatus(); 

		String body = resposta.getEntity(String.class);
		
		/* As três linhas abaixo imprimem as informações retornadas pela API. 
		 * Aqui o seu sistema deverá interpretar e lidar com o retorno. */
		System.out.print("HTTP Code: ");
		System.out.print(httpCode);
		System.out.printf(body);
	}
}
```

```ruby

# encoding: UTF-8

require "net/http"
require "net/https"
require "json"

# token enviado pelo suporte
token = "codigo_alfanumerico_token"

# referência da nota - deve ser única para cada nota enviada
ref = "id_referencia_nota"

# endereço da api que deve ser usado conforme o ambiente: produção ou homologação
servidor_producao = "https://api.focusnfe.com.br/"
servidor_homologacao = "http://homologacao.acrasnfe.acras.com.br/"

# no caso do ambiente de envio ser em produção, utilizar servidor_producao
url_envio = servidor_homologacao + "v2/nfse/" + ref

# altere os campos conforme a nota que será enviada
justificativa_cancelamento = {  
  justificativa: "Informe aqui a sua justificativa para realizar o cancelamento da NFSe."
}

# criamos uma objeto uri para envio da nota
uri = URI(url_envio)

# também criamos um objeto da classe HTTP a partir do host da uri
http = Net::HTTP.new(uri.hostname, uri.port)

# aqui criamos um objeto da classe Delete a partir da uri de requisição
requisicao = Net::HTTP::Delete.new(uri.request_uri)

# adicionando o token à requisição
requisicao.basic_auth(token, '')

# convertemos a hash de justificativa do cancelamento para o formato JSON e adicionamos ao corpo da requisição
requisicao.body = justificativa_cancelamento.to_json

# no envio de notas em produção, é necessário utilizar o protocolo ssl
# para isso, basta retirar o comentário da linha abaixo
# http.use_ssl = true

# aqui enviamos a requisição ao servidor e obtemos a resposta
resposta = http.request(requisicao)

# imprimindo o código HTTP da resposta
puts "Código retornado pela requisição: " + resposta.code

# imprimindo o corpo da resposta
puts "Corpo da resposta: " + resposta.body

```

```php
<?php
 // Você deve definir isso globalmente para sua aplicação
 $ch = curl_init();
 // Substituir pela sua identificação interna da nota
 $ref   = "12345";
 // Para ambiente de produção use a variável abaixo:
 // $server = "https://api.focusnfe.com.br";
 $server = "http://homologacao.acrasnfe.acras.com.br";
 $justificativa = array ("justificativa" => "Teste de cancelamento de nota");
 $login = "token_enviado_pelo_suporte";
 $password = "";
 curl_setopt($ch, CURLOPT_URL, $server . "/v2/nfse/" . $ref);
 curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
 curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "DELETE");
 curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($justificativa));
 curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
 curl_setopt($ch, CURLOPT_USERPWD, "$login:$password");
 $body = curl_exec($ch);
 $result = curl_getinfo($ch, CURLINFO_HTTP_CODE);
 //as três linhas abaixo imprimem as informações retornadas pela API, aqui o seu sistema deverá
 //interpretar e lidar com o retorno
 print($result."\n");
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
var url = "http://homologacao.acrasnfe.acras.com.br/v2/nfse/"+ ref;

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



> Resposta da API para a requisição de cancelamento:

```json
{
  "status": "cancelado"
}
```
Para cancelar uma NFSe, basta fazer uma requisição à URL abaixo, alterando o ambiente de produção para homologação, caso esteja emitindo notas de teste.

**Cancelar uma NFSe já autorizada:**

`https://api.focusnfe.com.br/v2/nfse/REFERENCIA.json`

Utilize o comando **HTTP DELETE** para cancelar a sua nota para nossa API.
Este método é síncrono, ou seja, a comunicação com a prefeitura será feita imediatamente e devolvida a resposta na mesma requisição.

A API irá em seguida devolver os seguintes campos:

* **status**: cancelado, se a nota pode ser cancelada, ou erro_cancelamento, se houve algum erro ao cancelar a nota.
* **erros**: um array de mensagens de erro que impedem que a nota seja cancelada .

**Prazo de cancelamento**
A NFSe não possui um prazo padrão para cancelamento como vemos na NFCe, por exemplo. Outro detalhe importante é que como alguns municípios não possuem ambiente de homologação, é preciso emitir as notas de teste em produção. Sendo assim, recomendamos que sempre consulte o seu município antes de emitir uma NFSe.



## Reenvio de email
```python
# Faça o download e instalação da biblioteca requests, através do python-pip.
import json
import requests

'''
Para ambiente de produção use a variável abaixo:
url = "https://api.focusnfe.com.br"
'''
url = "http://homologacao.acrasnfe.acras.com.br/v2/nfse/"

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
print(r.status_code, r.text)


```



```shell
curl -u token_enviado_pelo_suporte: \
  -X POST -d '{"emails":["alguem@example.org"]}' \
  http://homologacao.acrasnfe.acras.com.br/v2/nfse/12345/email
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

public class NFSeEnviaEmail {

	public static void main(String[] args) throws JSONException{
		
		String login = "Token_enviado_pelo_suporte";

		/* Substituir pela sua identificação interna da nota. */
		String ref = "12345";
		
		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
 		String server = "http://homologacao.acrasnfe.acras.com.br/";

		String url = server.concat("v2/nfse/"+ref+"/email");
		
		/* Criamos o um objeto JSON que receberá um JSON Array com a lista de e-mails. */
		JSONObject json = new JSONObject ();	
		JSONArray listaEmails = new JSONArray();
		listaEmails.put("email_01@acras.com.br");
		listaEmails.put("email_02@acras.com.br");
		listaEmails.put("email_03@acras.com.br");
		json.put("emails", listaEmails);	
		
		/* Testar se o JSON gerado está dentro do formato esperado.
		System.out.print(json); */
		
		/* Configuração para realizar o HTTP BasicAuth. */
		Object config = new DefaultClientConfig();
		Client client = Client.create((ClientConfig) config);
		client.addFilter(new HTTPBasicAuthFilter(login, ""));

		WebResource request = client.resource(url);

		ClientResponse resposta = request.post(ClientResponse.class, json);

		int httpCode = resposta.getStatus(); 

		String body = resposta.getEntity(String.class);
		
		/* As três linhas abaixo imprimem as informações retornadas pela API. 
		 * Aqui o seu sistema deverá interpretar e lidar com o retorno. */
		System.out.print("HTTP Code: ");
		System.out.print(httpCode);
		System.out.printf(body); 
	}
}
```

```ruby

# encoding: UTF-8

require "net/http"
require "net/https"
require "json"

# token enviado pelo suporte
token = "codigo_alfanumerico_token"

# referência da nota - deve ser única para cada nota enviada
ref = "id_referencia_nota"

# endereço da api que deve ser usado conforme o ambiente: produção ou homologação
servidor_producao = "https://api.focusnfe.com.br/"
servidor_homologacao = "http://homologacao.acrasnfe.acras.com.br/"

# no caso do ambiente de envio ser em produção, utilizar servidor_producao
url_envio = servidor_homologacao + "v2/nfse/" + ref + "/email"

# altere os campos conforme a nota que será enviada
emails_destinatarios = {
  emails: ["email_01@acras.com.br", "email_02@acras.com.br", "email_03@acras.com.br"]
}

# criamos uma objeto uri para envio da nota
uri = URI(url_envio)

# também criamos um objeto da classe HTTP a partir do host da uri
http = Net::HTTP.new(uri.hostname, uri.port)

# aqui criamos um objeto da classe Post a partir da uri de requisição
requisicao = Net::HTTP::Post.new(uri.request_uri)

# adicionando o token à requisição
requisicao.basic_auth(token, '')

# convertemos os dados da nota para o formato JSON e adicionamos ao corpo da requisição
requisicao.body = emails_destinatarios.to_json

# no envio de notas em produção, é necessário utilizar o protocolo ssl
# para isso, basta retirar o comentário da linha abaixo
# http.use_ssl = true

# aqui enviamos a requisição ao servidor e obtemos a resposta
resposta = http.request(requisicao)

# imprimindo o código HTTP da resposta
puts "Código retornado pela requisição: " + resposta.code

# imprimindo o corpo da resposta
puts "Corpo da resposta: " + resposta.body

```

```php
<?php
 // Você deve definir isso globalmente para sua aplicação
 // Para ambiente de produção use a variável abaixo:
 // $server = "https://api.focusnfe.com.br";
 $server = "http://homologacao.acrasnfe.acras.com.br";
 // Substituir pela sua identificação interna da nota
 $ref = "12345";
 $login = "token_enviado_pelo_suporte";
 $password = "";
 $email = array (
   "emails" => array(
     "email@email.com"
     )
   );
 // Inicia o processo de envio das informações usando o cURL
 $ch = curl_init();
 curl_setopt($ch, CURLOPT_URL, $server."/v2/nfse/" . $ref . "/email");
 curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
 curl_setopt($ch, CURLOPT_POST, 1);
 curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($email));
 curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
 curl_setopt($ch, CURLOPT_USERPWD, "$login:$password");
 $body = curl_exec($ch);
 $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
 //as três linhas abaixo imprimem as informações retornadas pela API, aqui o seu sistema deverá
 //interpretar e lidar com o retorno
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
var url = "http://homologacao.acrasnfe.acras.com.br/v2/nfse/" + ref + "/email";

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

`https://api.focusnfe.com.br/v2/nfse/REFERENCIA/email`

Utilize o comando **HTTP POST** para enviar os emails. Esta operação aceita apenas um parâmetro:

* **emails**: Array com uma lista de emails que deverão receber uma cópia da nota. Limitado a 10 emails por vez.

A API imediatamente devolve a requisição com a confirmação dos emails. Os emails serão enviados em segundo plano, por isso pode levar alguns minutos até que eles cheguem à caixa postal.

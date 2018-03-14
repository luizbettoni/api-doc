# Manifestação

A API para manifestação do sistema Focus permite que você consulte todas as notas recebidas pela sua empresa e permite que você realize a manifestação frente a receita, informando se a operação descrita na nota foi realizada ou não. A API faz ainda a guarda de todos os documentos recebidos para que você consulte quando precisar.

Através desta documentação deverá ser possível fazer a integração com a API do Focus NFe, caso alguma dúvida permaneça você pode entrar em contato com o suporte especializado através do e-mail suporte@acras.com.br.

## URLs


Método | URL (recurso) | Ação
-------|---------------|------
POST|/v2/nfes_recebidas/CHAVE/manifesto|Realiza um manifesto na nota informada.
GET|/v2/nfes_recebidas?cnpj=CNPJ|Busca informações resumidas de todas as NFe’s recebidas.
GET|/v2/nfes_recebidas/CHAVE/manifesto|Consulta o último manifesto válido na nota fiscal informada.
GET|/v2/nfes_recebidas/CHAVE.json|Consulta as informações da nota fiscal em formato JSON.
GET|/v2/nfes_recebidas/CHAVE.xml|Consulta as informações da nota fiscal em formato XML.
GET|/v2/nfes_recebidas/CHAVE/cancelamento.xml|Se existir, baixa o XML de cancelamento da nota fiscal informada.
GET|/v2/nfes_recebidas/CHAVE/carta_correcao.xml|Se existir, baixa o XML da última carta de correção da nota fiscal informada.

## Manifestação

```python
# Faça o download e instalação da biblioteca requests, através do python-pip.
import json
import requests

''' 
Para ambiente de produção use a variável abaixo:
url = "https://api.focusnfe.com.br"
'''
url = "http://homologacao.acrasnfe.acras.com.br/v2/nfes_recebidas/"

token="token_enviado_pelo_suporte"

chave = "chave_da_nota_fiscal"

'''
Usamos um dicionario para armazenar os campos e valores que em seguida,
serao convertidos a JSON e enviados para nossa API
'''
manifesto = {}
manifesto["tipo"] = "ciencia"

r = requests.post(url+chave+"/manifesto", data=json.dumps(manifesto), auth=(token,""))

# Mostra na tela o codigo HTTP da requisicao e a mensagem de retorno da API
print(r.status_code, r.text)


```



```shell

# substitua CHAVE pela chave da nota
curl -u token_enviado_pelo_suporte: \
  -X POST -d '{"tipo":"confirmacao"}' \
  http://homologacao.acrasnfe.acras.com.br/v2/nfes_recebidas/CHAVE/manifesto
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

public class Manifestar {

	public static void main(String[] args) {

		String login = "Token_enviado_pelo_Suporte";
		String chave = "Chave_de_identificação_da_NFe";

		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
		String server = "http://homologacao.acrasnfe.acras.com.br/";
		String url = server.concat("v2/nfes_recebidas/"+chave+"/manifesto");

		/* Aqui criamos um hashmap para receber a chave "tipo" e o valor que pode ser: ciencia, confirmacao, desconhecimento ou nao_realizada. */		
		HashMap<String, String> TipoManifestacao = new HashMap<String, String>();
		TipoManifestacao.put("tipo", "nao_realizada");

		/* Caso escolha o tipo "nao_realizada", é preciso informar o campo/chave "justificativa".
		 * TipoManifestacao.put("justificativa", "Informe aqui a sua justificativa do motivo da não realização da operação."); */

		/* Criamos um objeto JSON para receber a hash com os dados esperado pela API. */
		JSONObject json = new JSONObject(TipoManifestacao);

		/* Configuração para realizar o HTTP BasicAuth. */
		Object config = new DefaultClientConfig();
		Client client = Client.create((ClientConfig) config);
		client.addFilter(new HTTPBasicAuthFilter(login, ""));

		WebResource request =  client.resource(url);
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
// Solicite o seu token para realizar as requisições com nossa equipe de suporte.
 $login = "Token_enviado_pelo_Suporte";
 $chave = "Chave_de_identificação_da_NFe";
/* Aqui enviamos o tipo de manifestação que desejamos realizar.
   Consulte nossa documentação, para conhecer os demais tipos possíveis: https://goo.gl/a9o7hm */
 $tipo = array("tipo" => "confirmacao");
// Para ambiente de Produção, utilize a URL: https://api.focusnfe.com.br/.  
 $server = "http://homologacao.acrasnfe.acras.com.br/";
 $ch = curl_init();
 curl_setopt($ch, CURLOPT_URL, $server."v2/nfes_recebidas/".$chave."/manifesto");
 curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
 curl_setopt($ch, CURLOPT_POST, json_encode($tipo));

/* Métodos para realizar a autenticação básica do HTTP.
   Não é necessário informar campo senha, apenas o campo login. */
 curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
 curl_setopt($ch, CURLOPT_USERPWD, "$login");
 $body = curl_exec($ch);
 $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
// Mostra na tela o HTTP Code da sua requisição.
 print($http_code);
// Mostra na tela a mensagem de retorno da API.   
 print($body);
 curl_close($ch);
?>
```

> Outro exemplo de dados enviados

```json
{
  "tipo":"nao_realizada",
  "justificativa":"Fornecedor cancelou a operação devido a falta dos produtos em estoque"
}
```

Você pode realizar as seguintes operações de manifestação em uma NFe recebida:

* **Ciência da operação**: Significa que a operação é conhecida pela empresa, mas ainda não há informações suficientes para saber se ela foi concluída ou não.
* **Desconhecimento da operação**: Significa que a empresa não reconhece a nota fiscal emitida.
* **Operação realizada**(confirmação): – Significa que a operação é conhecida e foi realizada com sucesso.
* **Operação não realizada**: Significa que a operação é conhecida e por algum motivo não foi realizada.

Para realizar a manifestação, utilize a URL:

`https://api.focusnfe.com.br/v2/nfes_recebidas/CHAVE/manifesto`

Utilize o método **HTTP POST** para enviar os parâmetros à API.

Na URL, informe em **CHAVE** a chave da nota fiscal recebida. No corpo da requisição, informe objeto JSON com os seguintes parâmetros:

* **tipo**: Tipo da manifestação podendo ser **ciencia**, **confirmacao**, **desconhecimento** ou **nao_realizada**.
* **justificativa**: Caso o tipo seja nao_realizada, você deverá informar a justificativa (mínimo de 15 caracteres e máximo de 255).

> Exemplo de dados de resposta:

```json
{
  "status_sefaz": "135",
  "mensagem_sefaz": "Evento registrado e vinculado a NF-e",
  "status": "evento_registrado",
  "protocolo": "891170005150285",
  "tipo": "nao_realizada",
  "justificativa": "Fornecedor cancelou a operação devido a falta dos produtos em estoque"
}
```

**Dados devolvidos**

A API irá devolver um objeto JSON com os seguintes parâmetros:

* **status_sefaz**:Código de status da SEFAZ.
* **mensagem_sefaz**: Mensagem da SEFAZ.
* **status**: erro se não foi possível fazer a manifestação (consulte a mensagem de erro em mensagem_sefaz) ou evento_registrado se a manifestação foi registrada com sucesso à NFe.
* **protocolo**: Protocolo do recebimento na SEFAZ.
* **tipo**: Tipo da manifestação informado.
* **justificativa**: Justificativa da manifestação informada, se existente.


É possível realizar mais de uma manifestação na nota fiscal, ficando válida apenas a última manifestação realizada com sucesso, não sendo possível repetir o tipo de manifestação já realizado. Caso queria consultar a última manifestação válida, utilize o seguinte endereço:

`https://api.focusnfe.com.br/v2/nfes_recebidas/CHAVE/manifesto`

Utilize o método **HTTP GET** para consultar os dados da nota fiscal.

Na URL, informe em **CHAVE** a chave da nota fiscal recebida. O retorno será o mesmo que a operação de manifestação.

> Exemplo de como consultar a última manifestação de uma Nota Fiscal Eletrônica.

```python
# Faça o download e instalação da biblioteca requests, através do python-pip.
import requests

''' 
Para ambiente de produção use a variável abaixo:
url = "https://api.focusnfe.com.br"
'''
url = "http://homologacao.acrasnfe.acras.com.br/v2/nfes_recebidas/"

token="token_enviado_pelo_suporte"

chave = "chave_da_nota_fiscal"

r = requests.get(url+chave+"/manifesto", auth=(token,""))

# Mostra na tela o codigo HTTP da requisicao e a mensagem de retorno da API
print(r.status_code, r.text)

```


```java
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;

public class consultar_ultima_manifestacao {

	public static void main(String[] args) {

		String login = "Token_enviado_pelo_Suporte";
		String chave = "Chave_de_identificação_da_NFe";

		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
		String server = "http://homologacao.acrasnfe.acras.com.br/";
		String url = server.concat("v2/nfes_recebidas/"+chave+"/manifesto");

		/* Configuração para realizar o HTTP BasicAuth. */
		Object config = new DefaultClientConfig();
		Client client = Client.create((ClientConfig) config);
		client.addFilter(new HTTPBasicAuthFilter(login, ""));

		WebResource request =  client.resource(url);
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
// Solicite o seu token para realizar as requisições com nossa equipe de suporte.
 $login = "Token_enviado_pelo_Suporte";
 $chave = "Chave_de_identificação_da_NFe";
// Para ambiente de Produção, utilize a URL: https://api.focusnfe.com.br/.  
 $server = "http://homologacao.acrasnfe.acras.com.br/";

 $ch = curl_init();
 curl_setopt($ch, CURLOPT_URL, $server."v2/nfes_recebidas/".$chave."/manifesto");
 curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
 curl_setopt($ch, CURLOPT_HTTPHEADER, array());
/* Métodos para realizar a autenticação básica do HTTP.
   Não é necessário informar campo senha, apenas o campo login. */
 curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
 curl_setopt($ch, CURLOPT_USERPWD, "$login");
 $body = curl_exec($ch);
 $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
// Mostra na tela o HTTP Code da sua requisição.
 print($http_code);
// Mostra na tela a mensagem de retorno da API.   
 print($body);
 curl_close($ch);
?>
```

## Consulta de NFe Recebidas

Uma nota fiscal recebida pode ter suas informações atualizadas ao longo do tempo. Quando a receita informa que uma nota fiscal foi emitida contra a empresa, recebemos apenas o “cabeçalho” da nota fiscal com os dados mais importantes. Se for manifestada ciência da operação, poderemos receber os demais dados. Da mesma forma, a receita poderá notificar quando a nota recebe uma carta de correção ou quando ela é cancelada.

Por isso as notas fiscais recebidas possuem um campo chamado “**versao**” que é único entre todos os documentos do mesmo CNPJ e que é atualizado a cada alteração nesta nota fiscal. Isto facilita a busca apenas dos documentos que seu sistema ainda não conhece, sendo necessário que você armazene apenas um número por CNPJ.

Por exemplo, se você recebe uma nota fiscal, com versao = 60, e ela posteriormente receber uma carta de correção ou for cancelada, sua versão será atualizada para algum número maior que 60.

A API busca as últimas atualizações da SEFAZ de hora em hora.

**Método de consulta**

> Exemplo de como consultar todas as notas recebidas de uma empresa.

```python
# Faça o download e instalação da biblioteca requests, através do python-pip.
import requests

''' 
Para ambiente de produção use a variável abaixo:
url = "https://api.focusnfe.com.br"
'''
url = "http://homologacao.acrasnfe.acras.com.br/v2/nfes_recebidas?cnpj="

token="token_enviado_pelo_suporte"

cnpj = "cnpj_do_destinatario_da_nota"

r = requests.get(url+cnpj, auth=(token,""))

# Mostra na tela o codigo HTTP da requisicao e a mensagem de retorno da API
print(r.status_code, r.text)

```


```shell
curl -u token_enviado_pelo_suporte: \
  "http://homologacao.acrasnfe.acras.com.br/v2/nfes_recebidas?cnpj=SEU_CNPJ"
```

```java
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;

public class consultar_todos_manifestos {

	public static void main(String[] args) {

		String login = "Token_enviado_pelo_Suporte";
		String cnpj = "CNPJ_da_sua_empresa";

		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
		String server = "http://homologacao.acrasnfe.acras.com.br/";
		String url = server.concat("v2/nfes_recebidas?cnpj="+cnpj);

		/* Configuração para realizar o HTTP BasicAuth. */
		Object config = new DefaultClientConfig();
		Client client = Client.create((ClientConfig) config);
		client.addFilter(new HTTPBasicAuthFilter(login, ""));

		WebResource request =  client.resource(url);
		ClientResponse resposta = request.get(ClientResponse.class);
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

```php
<?php
// Solicite o seu token para realizar as requisições com nossa equipe de suporte.
 $login = "Token_enviado_pelo_Suporte";
 $cnpj = "CNPJ_da_sua_empresa";
// Para ambiente de Produção, utilize a URL: https://api.focusnfe.com.br/.  
 $server = "http://homologacao.acrasnfe.acras.com.br/";

 $ch = curl_init();
   curl_setopt($ch, CURLOPT_URL, $server."v2/nfes_recebidas?cnpj=".$cnpj);
   curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
   curl_setopt($ch, CURLOPT_HTTPHEADER, array());
/* Métodos para realizar a autenticação básica do HTTP.
   Não é necessário informar campo senha, apenas o campo login. */  
   curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
   curl_setopt($ch, CURLOPT_USERPWD, "$login");

 $body = curl_exec($ch);
 $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
// Mostra na tela o HTTP Code da sua requisição.
   print($http_code);
// Mostra na tela a mensagem de retorno da API.   
   print($body);
   curl_close($ch);
?>
```

Para consultar os documentos fiscais recebidos, utilize o endereço abaixo:

`https://api.focusnfe.com.br/v2/nfe_recebidas?cnpj=CNPJ`

Utilize o método **HTTP GET** para consultar as notas. Esta requisição aceita os seguintes parâmetros que deverão ser enviados na URL:

* **cnpj**(*): CNPJ da empresa. Campo obrigatório.
* **versao**: Se informado, irá buscar apenas os documentos cuja versão seja maior que o parâmetro recebido. Utilize este parâmetro para buscar apenas as notas que seu sistema ainda não conhece.
* **pendente**: Se este parâmetro for informado, serão listadas apenas as notas que estão pendentes de manifestação.

Serão devolvidas as 100 primeiras notas encontradas. Para recuperar as demais notas você deverá fazer uma nova requisição alterando o campo versão.

> Exemplo dos dados de resposta:

```json
[
  {
    "nome_emitente": "Empresa emitente Ltda.",
    "documento_emitente": "79160190000193",
    "chave_nfe": "41171179060190000182550010000002661875685069",
    "valor_total": "24560.00",
    "data_emissao": "2017-11-07T01:00:00-02:00",
    "situacao": "autorizada",
    "manifestacao_destinatario": "ciencia",
    "nfe_completa": true,
    "tipo_nfe": "1",
    "versao": 73,
    "digest_value": "/C5IuK5fCNVQV2rbwV0d8W12zsk=",
    "numero_carta_correcao": "1",
    "carta_correcao": "Algum texto da carta de correção.",
    "data_carta_correcao": "2017-11-07T14:31:48-02:00",
    "data_cancelamento": "2017-11-07T14:45:14-02:00",
    "justificativa_cancelamento": "Nota cancelada por algum motivo"
  }
]
```

**Dados devolvidos**

A API irá devolver os seguintes cabeçalhos HTTP:

* **X-Total-Count**: O número total de registros (incluindo aqueles que não foram devolvidos pelo limite de 100 registros)
* **X-Max-Version**: Valor máximo da versão dos documentos devolvidos. Utilize este cabeçalho para utilizar na próxima busca de versão, caso seja necessário.

Os dados devolvidos no corpo da requisição serão um array de objetos em JSON no seguinte formato:

* **nome_emitente**: Nome do emitente da nota fiscal.
* **documento_emitente**: CNPJ ou CPF do emitente da nota fiscal.
* **cnpj_destinatario**: CNPJ do destinatário da nota fiscal (o CNPJ de sua empresa).
* **chave_nfe**: Chave da NFe.
* **valor_total**: Valor total da NFe.
* **data_emissao**: Data de emissão da NFe.
* **situacao**: Situação da NFe. Pode ser: autorizada, cancelada ou denegada.
- **manifestacao_destinatario**: Situação atual da manifestação, pode ser:
	- **nulo**: Se não houve manifestação ainda;
	- **ciencia**: Se foi confirmada a ciência da operação;
	- **confirmacao**: Se foi manifestado confirmação da operação;
	- **desconhecimento**: Se foi manifestado desconhecimento da operação;
	- **nao_realizada**: Se foi manifestado que operação é conhecida, porém por algum motivo não foi realizada.
* **nfe_completa**: Se verdadeiro, indica que temos o XML completo da nota, caso contrário o sistema possui apenas o cabeçalho da nota.
- **tipo_nfe**:
	- **1**: Saída;
	- **2**: Entrada.
* **versao**: Versão da nota fiscal. Este número irá mudar apenas se a nota fiscal for alterada de alguma forma.
* **digest_value**: Valor do resumo digital do XML da nota.
* **numero_carta_correcao**: Número sequencial da carta de correção, caso tenha sido emitida alguma.
* **carta_correcao**: Texto da carta de correção, caso tenha sido emitida alguma.
* **data_carta_correcao**: Data da carta de correção, caso tenha sido emitida alguma.
* **data_cancelamento**: Data de cancelamento da nota fiscal, caso ela tenha sido cancelada.
* **justificativa_cancelamento**: Justificativa de cancelamento da nota fiscal, caso ela tenha sido cancelada.

## Consulta de NFe individuais


Disponibilizamos diversos métodos para obter mais informações de uma nota fiscal recebida conforme mostramos a seguir:

**Pesquisa de uma nota fiscal por chave**

Para pesquisar as informações específicas de uma NFe, consulte:

`https://api.focusnfe.com.br/v2/nfes_recebidas/CHAVE`

Utilize o método **HTTP GET** para consultar os dados da nota fiscal.

Isto irá devolver os mesmos campos descritos no item 2.2. Você pode solicitar também os dados completos da nota informando o parâmetro **completa=1**, da seguinte forma:

`https://api.focusnfe.com.br/v2/nfes_recebidas/CHAVE?completa=1`

Utilize o método **HTTP GET** para consultar os dados da nota fiscal.

Isto irá adicionar dois novos campos:

* **requisicao_nota_fiscal**: Dados completos da nota fiscal em formato JSON.
* **protocolo_nota_fiscal**: Dados completos do retorno do SEFAZ em formato JSON.

## Download de XML

> Exemplo de como realizar o download do XML de uma Nota Fiscal Eletrônica especifica.

```python
# Faça o download e instalação da biblioteca requests, através do python-pip.
import requests

''' 
Para ambiente de produção use a variável abaixo:
url = "https://api.focusnfe.com.br"
'''
url = "http://homologacao.acrasnfe.acras.com.br/v2/nfes_recebidas/"

token="token_enviado_pelo_suporte"

chave = "chave_da_nota_fiscal"

r = requests.get(url+chave+".xml", auth=(token,""))

# Mostra na tela o codigo HTTP da requisicao e a mensagem de retorno da API
print(r.status_code, r.text)

```

```shell
curl -u token_enviado_pelo_suporte: \
  http://homologacao.acrasnfe.acras.com.br/v2/nfe_recebidas/CHAVE.xml
```

```java
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;

public class download_nota_especifica_xml {

	public static void main(String[] args) {

		String login = "Token_enviado_pelo_Suporte";
		String chave = "Chave_de_identificação_da_NFe";

		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
		String server = "http://homologacao.acrasnfe.acras.com.br/";
		String url = server.concat("v2/nfes_recebidas/"+chave+".xml");

		/* Configuração para realizar o HTTP BasicAuth. */
		Object config = new DefaultClientConfig();
		Client client = Client.create((ClientConfig) config);
		client.addFilter(new HTTPBasicAuthFilter(login, ""));

		WebResource request =  client.resource(url);
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
// Solicite o seu token para realizar as requisições com nossa equipe de suporte.
 $login = "Token_enviado_pelo_Suporte";
 $chave = "Chave_de_identificação_da_NFe";
// Para ambiente de Produção, utilize a URL: https://api.focusnfe.com.br/.  
 $server = "http://homologacao.acrasnfe.acras.com.br/";
 $ch = curl_init();
 curl_setopt($ch, CURLOPT_URL, $server."v2/nfes_recebidas/".$chave.".xml");
 curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
 curl_setopt($ch, CURLOPT_HTTPHEADER, array());
/* Métodos para realizar a autenticação básica do HTTP.
   Não é necessário informar campo senha, apenas o campo login. */  
 curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
 curl_setopt($ch, CURLOPT_USERPWD, "$login");
 $body = curl_exec($ch);
 $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
// Mostra na tela o HTTP Code da sua requisição.
 print($http_code);
// Converte os dados de XML para objeto, mostrando o retorno bruto.
 var_dump(simplexml_load_string($body));
 curl_close($ch);
?>
```

> Exemplo de como fazer o download, no formato JSON, do XML de uma Nota Fiscal Eletrônica especifica.

```python
# Faça o download e instalação da biblioteca requests, através do python-pip.
import requests

''' 
Para ambiente de produção use a variável abaixo:
url = "https://api.focusnfe.com.br"
'''
url = "http://homologacao.acrasnfe.acras.com.br/v2/nfes_recebidas/"

token="token_enviado_pelo_suporte"

chave = "chave_da_nota_fiscal"

r = requests.get(url+chave+".json?completa=1", auth=(token,""))

# Mostra na tela o codigo HTTP da requisicao e a mensagem de retorno da API
print(r.status_code, r.text)l

```



```shell
curl -u token_enviado_pelo_suporte: \
  "http://homologacao.acrasnfe.acras.com.br/v2/nfe_recebidas/CHAVE.json?completa=1"
```

```java
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;

public class download_nota_especifica {

	public static void main(String[] args) {

		String login = "Token_enviado_pelo_Suporte";
		String chave = "Chave_de_identificação_da_NFe";

		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
		String server = "http://homologacao.acrasnfe.acras.com.br/";
		String url = server.concat("v2/nfes_recebidas/"+chave+".json?completa=1");

		/* Configuração para realizar o HTTP BasicAuth. */
		Object config = new DefaultClientConfig();
		Client client = Client.create((ClientConfig) config);
		client.addFilter(new HTTPBasicAuthFilter(login, ""));

		WebResource request =  client.resource(url);
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
// Solicite o seu token para realizar as requisições com nossa equipe de suporte.
 $login = "Token_enviado_pelo_Suporte";
 $chave = "Chave_de_identificação_da_NFe";
// Para ambiente de Produção, utilize a URL: https://api.focusnfe.com.br/.  
 $server = "http://homologacao.acrasnfe.acras.com.br/";
 $ch = curl_init();
 curl_setopt($ch, CURLOPT_URL, $server."v2/nfes_recebidas/".$chave.".json?completa=1");
 curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
 curl_setopt($ch, CURLOPT_HTTPHEADER, array());
/* Métodos para realizar a autenticação básica do HTTP.
   Não é necessário informar campo senha, apenas o campo login. */
 curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
 curl_setopt($ch, CURLOPT_USERPWD, "$login");
 $body = curl_exec($ch);
 $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
// Mostra na tela o HTTP Code da sua requisição.
 print($http_code);
// Mostra na tela a mensagem de retorno da API.   
 print($body);
 curl_close($ch);
?>
```

> Exemplo de como fazer o download do XML de cancelamento de uma Nota Fiscal Eletrônica.

```python
# Faça o download e instalação da biblioteca requests, através do python-pip.
import requests

''' 
Para ambiente de produção use a variável abaixo:
url = "https://api.focusnfe.com.br"
'''
url = "http://homologacao.acrasnfe.acras.com.br/v2/nfes_recebidas/"

token="token_enviado_pelo_suporte"

chave = "chave_da_nota_fiscal"

r = requests.get(url+chave+"/cancelamento.xml", auth=(token,""))

# Mostra na tela o codigo HTTP da requisicao e a mensagem de retorno da API
print(r.status_code, r.text)

```

```shell
curl -u token_enviado_pelo_suporte: \
  http://homologacao.acrasnfe.acras.com.br/v2/nfe_recebidas/CHAVE/cancelamento.xml
```

```java
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;

public class download_cancelamento_xml {

	public static void main(String[] args) {

		String login = "Token_enviado_pelo_Suporte";
		String chave = "Chave_de_identificação_da_NFe";

		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
		String server = "http://homologacao.acrasnfe.acras.com.br/";
		String url = server.concat("v2/nfes_recebidas/"+chave+"/cancelamento.xml");

		/* Configuração para realizar o HTTP BasicAuth. */
		Object config = new DefaultClientConfig();
		Client client = Client.create((ClientConfig) config);
		client.addFilter(new HTTPBasicAuthFilter(login, ""));

		WebResource request =  client.resource(url);
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
// Solicite o seu token para realizar as requisições com nossa equipe de suporte.
 $login = "Token_enviado_pelo_Suporte";
 $chave = "Chave_de_identificação_da_NFe";
// Para ambiente de Produção, utilize a URL: https://api.focusnfe.com.br/.  
 $server = "http://homologacao.acrasnfe.acras.com.br/";
 $ch = curl_init();
 curl_setopt($ch, CURLOPT_URL, $server."v2/nfes_recebidas/".$chave."/cancelamento.xml");
 curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
 curl_setopt($ch, CURLOPT_HTTPHEADER, array());
/* Métodos para realizar a autenticação básica do HTTP.
   Não é necessário informar campo senha, apenas o campo login. */   
 curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
 curl_setopt($ch, CURLOPT_USERPWD, "$login");
 $body = curl_exec($ch);
 $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
// Mostra na tela o HTTP Code da sua requisição.
 print($http_code);
// Converte os dados de XML para objeto, mostrando o retorno bruto.
 var_dump(simplexml_load_string($body));
 curl_close($ch);
?>
```

> Exemplo de como realizar o download do XML de uma Nota Fiscal Eletrônica especifica com Carta de Correção Eletrônica.

```python
# Faça o download e instalação da biblioteca requests, através do python-pip.
import requests

''' 
Para ambiente de produção use a variável abaixo:
url = "https://api.focusnfe.com.br"
'''
url = "http://homologacao.acrasnfe.acras.com.br/v2/nfes_recebidas/"

token="token_enviado_pelo_suporte"

chave = "chave_da_nota_fiscal"

r = requests.get(url+chave+"/carta_correcao.xml", auth=(token,""))

# Mostra na tela o codigo HTTP da requisicao e a mensagem de retorno da API
print(r.status_code, r.text)

```




```shell
curl -u token_enviado_pelo_suporte: \
  http://homologacao.acrasnfe.acras.com.br/v2/nfe_recebidas/CHAVE/carta_correcao.xml
```

```java
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;

public class download_xml_cce {

	public static void main(String[] args) {

		String login = "Token_enviado_pelo_Suporte";
		String chave = "Chave_de_identificação_da_NFe";

		/* Para ambiente de produção use a variável abaixo:
		String server = "https://api.focusnfe.com.br/"; */
		String server = "http://homologacao.acrasnfe.acras.com.br/";
		String url = server.concat("v2/nfes_recebidas/"+chave+"/carta_correcao.xml");

		/* Configuração para realizar o HTTP BasicAuth. */
		Object config = new DefaultClientConfig();
		Client client = Client.create((ClientConfig) config);
		client.addFilter(new HTTPBasicAuthFilter(login, ""));

		WebResource request =  client.resource(url);
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
// Solicite o seu token para realizar as requisições com nossa equipe de suporte.
 $login = "Token_enviado_pelo_Suporte";
 $chave = "Chave_de_identificação_da_NFe";
// Para ambiente de Produção, utilize a URL: https://api.focusnfe.com.br/.  
 $server = "http://homologacao.acrasnfe.acras.com.br/";
 $ch = curl_init();
 curl_setopt($ch, CURLOPT_URL, $server."v2/nfes_recebidas/".$chave."/carta_correcao.xml");
 curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
 curl_setopt($ch, CURLOPT_HTTPHEADER, array());
// Métodos para realizar a autenticação básica do HTTP.
// Não é necessário informar campo senha, apenas o campo login.
 curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
 curl_setopt($ch, CURLOPT_USERPWD, "$login");
 $body = curl_exec($ch);
 $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
// Mostra na tela o HTTP Code da sua requisição.
 print($http_code);
// Converte os dados de XML para objeto, mostrando o retorno bruto.
 var_dump(simplexml_load_string($body));

   curl_close($ch);
?>
```

Também é possível fazer o download do XML das notas fiscais através da API, basta informar a chave de identificação da respectiva nota no parâmetro CHAVE:

**Baixar o XML de uma nota fiscal especifica:**

`https://api.focusnfe.com.br/v2/nfes_recebidas/CHAVE.xml`

Utilize o método **HTTP GET** para obter os dados das notas no formato XML.

**Baixar o XML, em formato json, de uma nota fiscal especifica:**

`https://api.focusnfe.com.br/v2/nfes_recebidas/CHAVE.json?completa=1`

Utilize o método **HTTP GET** para obter os dados das notas no formato XML.

**Baixar o XML de cancelamento de uma nota fiscal:**

`https://api.focusnfe.com.br/v2/nfes_recebidas/CHAVE/cancelamento.xml`

Utilize o método **HTTP GET** para obter os dados das notas no formato XML.

**Baixar o XML da última Carta de Correção Eletrônica de uma nota fiscal:**

`https://api.focusnfe.com.br/v2/nfes_recebidas/CHAVE/carta_correcao.xml`

Utilize o método **HTTP GET** para obter os dados das notas no formato XML.

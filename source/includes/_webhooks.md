# Gatilhos / Webhooks

## Informações gerais

Gatilhos ou "WebHooks" são eventos automaticos que são disparados a partir de mudanças especificas na nota fiscal. Quando isso ocorre, é enviado os dados da nota fiscal no formato JSON para uma URL a sua escolha, através do método POST. Cada acionamento do gatilho contém os dados de apenas uma nota. A API enviará as seguintes informações para sua URL:

> Dados enviados para sua URL:

```json
{
  "cnpj_emitente": "07504505000132",
  "ref": "teste_webhooks",
  "status": "autorizado",
  "status_sefaz": "100",
  "mensagem_sefaz": "Autorizado o uso da NF-e",
  "chave_nfe": "NFe77777075045050001329999930000002999999991249",
  "numero": "1",
  "serie": "1",
  "caminho_xml_nota_fiscal": "/arquivos_development/99999999999972/201313/XMLs/77777075045050001329999930000002999999991249-nfe.xml",
  "caminho_danfe": "/arquivos_development/99999999999972/201313/DANFEs/77777075045050001329999930000002999999991249.pdf"
}
```

Para NFe e MDe (Manifestação de Destinatário Eletrônica):

* **status**:
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

Para NFSe:

* **cnpj_prestador**: CNPJ do prestador do serviço.
* **ref**: A referência da emissão.
* **numero_rps**: Número do RPS da nota.
* **serie_rps**: Série do RPS da nota.
* **status**: 
  - **processando_autorizacao**: A nota ainda está em processamento pela API. Você deverá aguardar o processamento da Prefeitura.
  - **autorizado**: A nota foi autorizada, neste caso é fornecido os dados completos da nota como chave e arquivos para download
  - **cancelado**: O documento foi cancelado, neste caso é fornecido o caminho para download do XML de cancelamento (caminho_xml_cancelamento).
  - **erro_autorizacao**: Houve um erro de autorização por parte da Prefeitura. É possível fazer o reenvio da nota com a mesma referência se ela estiver neste estado.
* **numero**: Número da nota fiscal.
* **codigo_verificacao**: Código de verificação gerado pela Prefeitura.
* **data_emissao**: Data da emissão da nota fiscal.
* **url**: URL para visualização da nota fiscal a partir do portal da Prefeitura.
* **caminho_xml_nota_fsical**: Caminho para download do XML da nota fiscal.

A vantagem de utilizar gatilhos é que não haverá a necessidade de fazer "pulling" (realizar constantes requisições a fim de verificar o status da nota).

Na ocorrência de falha na execução do POST para a URL definida (exemplo: servidor fora do ar ou alguma resposta HTTP diferente de 20X) a API tentará um reenvio nos seguintes intervalos: 1 minuto, 30 minutos, 1 hora, 3 horas, 24 horas até o momento em que a API irá desistir de acionar o gatilho.

## Eventos

Os seguintes eventos causam o acionamento do gatilho:

* **NFe**:
  * Erro na emissão de uma nota fiscal
  * Emissão de nota fiscal realizada com sucesso
  * Cancelamento de nota fiscal efetuado pela nossa interface web
  * Carta de correção emitida pela nossa interface web
* **NFSe**:
  * Erro na emissão de uma nota fiscal
  * Emissão de nota fiscal realizada com sucesso
* **Manifestação**:
  * Recebimento de um novo documento fiscal

Os gatilhos para autorização de CTe deverão ser disponibilizados em breve.

## Criação
```python
# Faça o download e instalação da biblioteca requests, através do python-pip.
import json
import requests

'''
Para ambiente de produção use a variável abaixo:
url = "https://api.focusnfe.com.br"
'''
url = "http://homologacao.acrasnfe.acras.com.br/v2/hooks"

token="token_enviado_pelo_suporte"

'''
Usamos um dicionario para armazenar os campos e valores que em seguida,
serao convertidos a JSON e enviados para nossa API
'''
dados = {}
dados["cnpj"] = "51916585000125"
dados["event"] = "nfe"
dados["url"] = "http://minha.url/nfe"

r = requests.post(url, data=json.dumps(dados), auth=(token,""))

# Mostra na tela o codigo HTTP da requisicao e a mensagem de retorno da API
print(r.status_code, r.text)


```

```shell
curl -u token_enviado_pelo_suporte: \
  -X POST -d '{"cnpj":"51916585000125","event":"nfe","url":"http://minha.url/nfe"}' \
  http://homologacao.acrasnfe.acras.com.br/v2/hooks
```
```php
<?php
$ch = curl_init();
$server = "http://homologacao.acrasnfe.acras.com.br";
curl_setopt($ch, CURLOPT_URL, $server."/v2/hooks");
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode(array("cnpj" => "51916585000125",
	"event" => "nfe", "url" => "http://minha.url/nfe")));
curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
curl_setopt($ch, CURLOPT_USERPWD, "token_enviado_pelo_suporte:");
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

public class ExemploCriacaoHook {

    public static void main(String[] args) throws JSONException{

        String login = "Token_enviado_pelo_suporte";

        /* Para ambiente de produção use a variável abaixo:
        String server = "https://api.focusnfe.com.br/"; */
        String server = "http://homologacao.acrasnfe.acras.com.br/";

        String url = server.concat("v2/hooks");

        /* Configuração para realizar o HTTP BasicAuth. */
        Object config = new DefaultClientConfig();
        Client client = Client.create((ClientConfig) config);
        client.addFilter(new HTTPBasicAuthFilter(login, ""));

        /* Aqui são criados as hash's que receberão os dados da nota. */
        HashMap<String, String> hook = new HashMap<String, String>();

        hook.put("cnpj", "51916585000125");
        hook.put("event", "nfe");
        hook.put("url", "http://minha.url/nfe");

        JSONObject json = new JSONObject (hook);

        WebResource request = client.resource(url);

        ClientResponse resposta = request.post(ClientResponse.class, json);

        int httpCode = resposta.getStatus();

        String body = resposta.getEntity(String.class);

        System.out.print("HTTP Code: ");
        System.out.print(HttpCode);
        System.out.printf(body);
    }
}
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

var url = "http://homologacao.acrasnfe.acras.com.br/v2/hooks";

/*
Use o valor 'false', como terceiro parametro para que a requisicao aguarde a resposta da API
Passamos o token como quarto parametro deste metodo, como autenticador do HTTP Basic Authentication.
*/
request.open('POST', url, false, token);

var gatilho = {

	"cnpj":"51916585000125",
	"event":"nfe",
	"url":"http://minha.url/nfe"
};

// Aqui fazermos a serializacao do JSON com os dados da nota e enviamos atraves do metodo usado.
request.send(JSON.stringify(gatilho));

// Sua aplicacao tera que ser capaz de tratar as respostas da API.
console.log("HTTP code: " + request.status);
console.log("Corpo: " + request.responseText);

```


> Dados de resposta de gatilho criado com sucesso

```json
{
  "id": "Vj5rmkBq",
  "url": "http://minha.url/nfe",
  "authorization": null,
  "event": "nfe",
  "cnpj": "51916585000125"
}
```


Para criar um novo gatilho, utilize o endereço abaixo:

`https://api.focusnfe.com.br/v2/hooks`

Utilize o método HTTP POST para criar um novo gatilho. Esta requisição aceita os seguintes parâmetros que deverão ser enviados em formato JSON:

*  **cnpj** – CNPJ da empresa.
*  **event** – Informe qual evento que gostará de escutar: nfe, nfse ou nfe_recebida
*  **url** – URL que deverá ser chamada quando o gatilho for ativado

A API irá devolver como resposta o gatilho criado. É possível ter apenas um gatilho por evento

## Consulta
```python
# Faça o download e instalação da biblioteca requests, através do python-pip.
import requests

'''
Para ambiente de produção use a variável abaixo:
url = "https://api.focusnfe.com.br"
'''
url = "http://homologacao.acrasnfe.acras.com.br/v2/hooks/"

token="token_enviado_pelo_suporte"

hook_id = "Vj5rmkBq"

r = requests.get(url+hook_id, auth=(token,""))

# Mostra na tela o codigo HTTP da requisicao e a mensagem de retorno da API
print(r.status_code, r.text)l


```

```shell
curl -u token_enviado_pelo_suporte: \
  http://homologacao.acrasnfe.acras.com.br/v2/hooks/Vj5rmkBq
```

```php
<?php
$ch = curl_init();
$hook_id = "Vj5rmkBq"
$server = "http://homologacao.acrasnfe.acras.com.br";
curl_setopt($ch, CURLOPT_URL, $server."/v2/hooks/" . $hook_id);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_HTTPHEADER, array());
curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
curl_setopt($ch, CURLOPT_USERPWD, "token_enviado_pelo_suporte:");
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

public class ExemploConsultaHook {

    public static void main(String[] args){

        String login = "Token_enviado_pelo_suporte";

        /* Substituir pela sua identificação interna da nota. */
        String hookId = "Vj5rmkBq";

        /* Para ambiente de produção use a variável abaixo:
        String server = "https://api.focusnfe.com.br/"; */
        String server = "http://homologacao.acrasnfe.acras.com.br/";

        String url = server.concat("v2/hooks/"+hookId);

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

```javascript

/*
As orientacoes a seguir foram extraidas do site do NPMJS: https://www.npmjs.com/package/xmlhttprequest
Here's how to include the module in your project and use as the browser-based XHR object.
Note: use the lowercase string "xmlhttprequest" in your require(). On case-sensitive systems (eg Linux) using uppercase letters won't work.
*/
var XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;

var request = new XMLHttpRequest();

var token = "Token_enviado_pelo_suporte";

var hook_id = "n65g0RP1";

var url = "http://homologacao.acrasnfe.acras.com.br/v2/hooks/" + hook_id;

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


> Dados de resposta de consulta de um gatilho individual

```json
{
  "id": "Vj5rmkBq",
  "url": "http://minha.url/nfe",
  "authorization": null,
  "event": "nfe",
  "cnpj": "51916585000125"
}
```

Existem duas formas de consultar os gatilhos disponíveis, utilize o endereço abaixo:

`https://api.focusnfe.com.br/v2/hooks`

Utilize o método HTTP **GET** para consultar **todos** os gatilhos criados. Serão exibidos os gatilhos de todas as empresas que seu token possui acesso.

Para consultar apenas um gatilho individualmente, utilize a URL:

`https://api.focusnfe.com.br/v2/hooks/HOOK_ID`

Substituindo HOOK_ID pelo identificador do gatilho.

## Exclusão
```python
 Faça o download e instalação da biblioteca requests, através do python-pip.
import requests

'''
Para ambiente de produção use a variável abaixo:
url = "https://api.focusnfe.com.br"
'''
url = "http://homologacao.acrasnfe.acras.com.br/v2/hooks/"

token="token_enviado_pelo_suporte"

hook_id = "Vj5rmkBq"

r = requests.delete(url+hook_id, auth=(token,""))

# Mostra na tela o codigo HTTP da requisicao e a mensagem de retorno da API
print(r.status_code, r.text)


```


```shell
curl -u token_enviado_pelo_suporte: -X DELETE \
 http://homologacao.acrasnfe.acras.com.br/v2/hooks/Vj5rmkBq
```

```php
<?php
$ch = curl_init();
$hook_id = "Vj5rmkBq"
$server = "http://homologacao.acrasnfe.acras.com.br";
curl_setopt($ch, CURLOPT_URL, $server . "/v2/hooks/" . $hook_id);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "DELETE");
curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
curl_setopt($ch, CURLOPT_USERPWD, "token_enviado_pelo_suporte:");
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

public class ExemploExclusaoHook {

    public static void main(String[] args){

        String login = "Token_enviado_pelo_suporte";

        /* Substituir pela sua identificação interna da nota. */
        String hookId = "Vj5rmkBq";

        /* Para ambiente de produção use a variável abaixo:
        String server = "https://api.focusnfe.com.br/"; */
        String server = "http://homologacao.acrasnfe.acras.com.br/";

        String url = server.concat("v2/hooks/"+hookId);

        /* Configuração para realizar o HTTP BasicAuth. */
        Object config = new DefaultClientConfig();
        Client client = Client.create((ClientConfig) config);
        client.addFilter(new HTTPBasicAuthFilter(login, ""));

        WebResource request = client.resource(url);

        ClientResponse resposta = request.delete(ClientResponse.class);

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

```javascript

/*
As orientacoes a seguir foram extraidas do site do NPMJS: https://www.npmjs.com/package/xmlhttprequest
Here's how to include the module in your project and use as the browser-based XHR object.
Note: use the lowercase string "xmlhttprequest" in your require(). On case-sensitive systems (eg Linux) using uppercase letters won't work.
*/
var XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;

var request = new XMLHttpRequest();

var token = "Token_enviado_pelo_suporte";

var hook_id = "n65g0RP1";

var url = "http://homologacao.acrasnfe.acras.com.br/v2/hooks/" + hook_id;

/*
Use o valor 'false', como terceiro parametro para que a requisicao aguarde a resposta da API
Passamos o token como quarto parametro deste metodo, como autenticador do HTTP Basic Authentication.
*/
request.open('DELETE', url, false, token);

request.send();

// Sua aplicacao tera que ser capaz de tratar as respostas da API.
console.log("HTTP code: " + request.status);
console.log("Corpo: " + request.responseText);

```



> Dados de resposta da exclusão de um gatilho

```json
{
  "id": "Vj5rmkBq",
  "url": "http://minha.url/nfe",
  "authorization": null,
  "event": "nfe",
  "cnpj": "51916585000125",
  "deleted": true
}
```

Para excluir um gatilho, utilize a URL

`https://api.focusnfe.com.br/v2/hooks/HOOK_ID`

Utilize o método HTTP **DELETE** para excluir o gatilho. Em caso de sucesso será exibido os dados do gatilho excluído acrescentado do atributo "deleted" com o valor "true".
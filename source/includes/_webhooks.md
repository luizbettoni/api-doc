# Gatilhos

Gatilhos (ou WebHooks) são eventos que são disparados a partir de mudanças relevantes na nota fiscal. Na ocorrência deste evento é executado um POST em alguma URL definida pela sua aplicação. Este POST contém as mesmas informações que a consulta da nota fiscal. Cada acionamento do gatilho contém informações de 1 nota.

A vantagem de utilizar gatilhos é que não haverá a necessidade de fazer polling ou constantemente chamar a API para verificar por exemplo se uma nota já foi autorizada ou não.

Na ocorrência de falha na execução do POST para a URL definida (exemplo: servidor fora do ar ou alguma resposta HTTP diferente de 20X) a API tentará um reenvio nos seguintes intervalos: 1 minuto, 30 minutos, 1 hora, 3 horas, 24 horas até o momento em que a API irá desistir de acionar o gatilho.

Os seguintes eventos causam o acionamento do gatilho:

* NFe:
  * Erro na emissão de uma nota fiscal
  * Emissão de nota fiscal realizada com sucesso
  * Cancelamento de nota fiscal efetuado pela nossa interface web
  * Carta de correção emitida pela nossa interface web
* NFSe:
  * Erro na emissão de uma nota fiscal
  * Emissão de nota fiscal realizada com sucesso
* Manifestação:
  * Recebimento de um novo documento fiscal

## Criação

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

Para consultar os gatilhos disponíveis, utilize o endereço abaixo:

`https://api.focusnfe.com.br/v2/hooks`

Utilize o método HTTP **GET** para consultar os gatilhos. Serão exibidos os gatilhos de todas as empresas que seu token possui acesso.

Para consultar um gatilho individualmente, utilize a URL

`https://api.focusnfe.com.br/v2/hooks/HOOK_ID`

Substituindo HOOK_ID pelo identificador do gatilho.

## Exclusão

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

## Dados enviados pelo gatilho para sua aplicação

Os eventos serão gerados por evento, ou seja, se houver duas notas autorizadas, o gatilho será disparado duas vezes. O conteúdo do gatilho é exatamente igual a operação de consulta descrita nas seguintes seções:

* NFe: [Operação de consulta de uma NFe](#nfe_consulta)
* NFSe: [Operação de consulta de uma NFSe](#nfse_consulta)
* Manifestação: [Consulta de NFe Recebida](#manifestacao_consulta-de-nfe-recebidas)

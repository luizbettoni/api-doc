# Gatilhos
Gatilhos (ou Webhooks) são eventos que são disparados a partir de mudanças relevantes na nota fiscal. Na ocorrência deste evento é executado um POST em alguma URL definida pela sua aplicação. Este POST contém as mesmas informações que a consulta da nota fiscal. Cada acionamento do gatilho contém informações de 1 nota.

A vantagem de utilizar gatilhos é que não haverá a necessidade de fazer polling ou constantemente chamar a API para verificar por exemplo se uma nota já foi autorizada ou não.

Na ocorrência de falha na execução do POST para a URL definida (exemplo: servidor fora do ar ou alguma resposta HTTP diferente de 20X) a API tentará um reenvio nos seguintes intervalos: 1 minuto, 30 minutos, 1 hora, 3 horas, 24 horas até o momento em que a API irá desistir de acionar o gatilho.

Os seguintes eventos causam o acionamento do gatilho:

* Erro na emissão de uma nota fiscal
* Emissão de nota fiscal realizada com sucesso
* Cancelamento de nota fiscal efetuado pela nossa interface web
* Carta de correção emitida pela nossa interface web

## Criação de um novo gatilho

Para criar um novo gatilho, utilize o endereço abaixo:

`https://api.focusnfe.com.br/v2/hooks`

Utilize o método HTTP POST para criar um novo gatilho. Esta requisição aceita os seguintes parâmetros que deverão ser enviados em formato JSON:

*  **cnpj** – CNPJ da empresa.
*  **event** – Informe o valor fixo “nfe”.
*  **url** – URL que deverá ser chamada quando o gatilho for ativado

A API irá devolver como resposta o gatilho criado. É possível ter apenas um gatilho por evento

## Consulta de gatilhos

Para consultar os gatilhos disponíveis, utilize o endereço abaixo:

`https://api.focusnfe.com.br/v2/hooks`

Utilize o método HTTP **GET** para consultar os gatilhos. Serão exibidos os gatilhos de todas as empresas que seu token possui acesso.

Para consultar um gatilho individualmente, utilize a URL

`https://api.focusnfe.com.br/v2/hooks/HOOK_ID`

Substituindo HOOK_ID pelo identificador do gatilho.

## Excluindo um gatilho

Para consultar um gatilho individualmente, utilize a URL

`https://api.focusnfe.com.br/v2/hooks/HOOK_ID`

Utilize o método HTTP **DELETE** para excluir o gatilho. Em caso de sucesso será exibido apenas os dados do gatilho excluído.

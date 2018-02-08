# Backups (NFe e NFCe)

Atualmente, realizamos o backup de todos os arquivos XML’s das notas fiscais emitidas pela nossa API. Vale lembrar que o XML é um arquivo com validade legal e deve ser armazenado pelos emitentes, para fins fiscais, por no mínimo 5 anos após a emissão.

Mensalmente a API (primeira hora do primeiro dia de cada mês) gera um arquivo compactado em formato ZIP com todos os arquivos gerados de cada empresa.

A consulta dos arquivos de backup pode ser feito com a URL abaixo:

`https://api.focusnfe.com.br/backups/CNPJ.json?token=TOKEN`

Utilize o comando HTTP GET para consultar o seu backup em nossa API.

Onde CNPJ é o CNPJ da empresa a ser consultada. Está requisição irá devolver um objeto com os seguintes atributos:

* <strong>backups</strong>: Array de objetos contendo:
   * <strong>mes</strong>: Mês do backup no formato AAAAMM”, ex: “201701”
   * <strong>danfes</strong>: Caminho para baixar arquivo ZIP com as DANFEs geradas
   * <strong>xmls</strong>: Caminho para baixar arquivo ZIP com os XMLs gerados

Caso você emita também NFCe, Nota Fiscal de Consumidor Eletrônica, os XMLs estarão no mesmo arquivo ZIP. Os backups serão mantidos por 6 meses em nossos servidores.

---
title: "Porque Padronizar Logs é tão valioso"
subtitle: "Parte 1: Log como Json"
date: 2023-01-29T18:55:06-03:00
lastmod: 2023-01-29T18:55:06-03:00
draft: false
author: "Beta Brandão"
authorLink: ""
description: ""
license: ""
images: []

tags: [devops, observability, data, logs]
categories: [devops, boas práticas]

featuredImage: "/images/logs.jpeg"
featuredImagePreview: "/images/logs.jpeg"

comment:
  enable: true

---

Já um tempo queria escrever sobre logs, mas sentia um pouco de dificuldade de criar um boa razão para defender uma escrita coerente para o tema. Eis que encontrei: Dados! <!--more--> Dados é considerado o novo petróleo e então precisamos conversar um pouco mais sobre ele.

## Parte 1: Log como Json

### Conceito

 Log é um termo inglês para definir um tronco ou bloco de madeira. E por analogia, o mesmo acontece com o bloco de informações que uma aplicação ou serviço pode acumular em um arquivo de texto linha por linha, ou seja, é basicamente é uma "pilha" de linhas de textos, que podem conter informações sobre como uma determinada aplicação ou serviço está sendo executada, ou pode registrar um possível erro do serviço ou em alguma regra de negócio. 

E como estamos falando desta pilha de informações que estão sendo acumuladas em algum bloco de texto, é imprescindível que exista informações básicas para caso necessite investigar, são elas: **data, hora e a mensagem**. 

### Quem consome esta informação?

Muitas destas mensagens são geralmente reaproveitadas para identificar falhas e comportamentos que existem no desenvolvimento de software, sendo acessada pela própria pessoa desenvolvedora para debugar o código. Mas como estamos lidando muitas vezes com tecnologias em nuvem com alta complexidade de serviços acoplados em nosso aplicativo (**Cloud**), geralmente são usados agregadores de logs para facilitar a gestão e velocidade de como os logs são aproveitados, como por exemplo o ElasticSearch ou Datadog.

Por isso é muito importante entender sobre o log e tipos de erros e formatos, dentro de uma boa prática de escrita de código (Isso fica para um outro artigo), qual inclusive indico a leitura do capítulo 7 do livro [*Clean Code* de Robert C. Martin](https://www.amazon.com.br/C%C3%B3digo-limpo-Robert-C-Martin/dp/8576082675) 

### Porque Json?

O [Json](https://www.json.org/json-pt.html) é um formato semiestruturado de dados tipo `"CHAVE": "VALOR"` que é usado comumente em diversas aplicações para se comunicarem entre si via [API](https://aws.amazon.com/pt/what-is/api/). 

E em grande maioria, quando estamos em projetos no mercado que trata dados como requisito de negócio, muito importante deixar o formato de saída de log da aplicação com um bom acoplamento com as diversas ferramentas de agregação de logs existentes no mercado.

### Estruturando log como json

Bem, como expliquei anteriormente, o log é um conjunto de mensagens agrupados em um arquivo de texto. E pensando nisso, precisa-se atentar de como o log em Json irá ser agrupados no arquivo de texto. Vamos primeiro para o exemplo de uma estrutura de Log em texto:

Exemplo do arquivo de Log encontrado em `/var/log/cups/access_log` em formato texto:

{{< highlight text >}}
localhost - - [30/Jan/2023:10:33:05 -0300] "POST / HTTP/1.1" 200 349 Create-Printer-Subscriptions successful-ok
localhost - - [30/Jan/2023:10:33:05 -0300] "POST / HTTP/1.1" 200 176 Create-Printer-Subscriptions successful-ok
{{< /highlight >}}


No exemplo acima, cada mensagem do serviço CUPS foi gravada em uma linha só, então nas atuais ferramentas de Observabilidade do mercado, como o Datadog, NewRellic ou o OpenSearch, e cada linha do arquivo `acces_log` é entendida como 1 mensagem de Log. 

Agora um exemplo de duas mensagens de Log em Json gravados em **18 linhas**, ou seja, 18 mensagens de Log:

{{< highlight json>}}
 {
  "eventTime": "08:51:08",
  "source":
      {
      "file": "DataLogger",
      "line": 27
      },
  "eventType": "GPS update"
}
 {
  "eventTime": "10:00:03",
  "source":
      {
      "file": "DataLogger",
      "line": 36
      },
  "eventType": "GPS Offline"
}
{{< /highlight>}}

 O exemplo acima foi gravado no arquivo de Log da mesma forma que uma API recebe a informação. Porém para os serviços de agregação de Log, poderemos ter 18 mensagens quebradas que não são aproveitadas. O grande motivo disso é que a maioria dos agentes dos serviços de mercado de agregação de Log fica lendo o arquivo de Log constantemente e entende cada linha do arquivo como uma mensagem de Log somente.Mas temos um truque para resolver isso: compactar o Json para caber em uma linha só. Com isso os serviços de agregação de Log conseguem entender que recebeu um Json!

No exemplo abaixo, é o formato ideal, e os agregadores de mercado entenderão como duas mensagens de Log.
{{< highlight json>}}
 {"eventTime": "08:51:08","source":{"file": "DataLogger","line": 27, "eventType": "GPS update"}
 {"eventTime": "10:00:03","source":{"file": "DataLogger","line": 36, "eventType": "GPS Offline"}
{{< /highlight>}}


Na parte 2, explicarei como aplicar boas práticas na estrutura de Logs.

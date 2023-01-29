---
title: "Porque Padronizar Logs é tão valioso"
subtitle: "Porque dados sem sentido não vale nada"
date: 2023-01-29T18:55:06-03:00
lastmod: 2023-01-29T18:55:06-03:00
draft: true
author: "Beta Brandão"
authorLink: ""
description: ""
license: ""
images: []

tags: [devops, observability, data, logs]
categories: [devops, boas práticas]

featuredImage: ""
featuredImagePreview: ""

#hiddenFromHomePage: false
#hiddenFromSearch: false
#twemoji: false
#lightgallery: true
#ruby: true
#fraction: true
fontawesome: true
linkToMarkdown: true
#rssFullText: false

toc:
  enable: true
  auto: true
code:
  copy: true
  maxShownLines: 50
math:
  enable: false
  # ...
mapbox:
  # ...
share:
  enable: true
  # ...
comment:
  enable: true
  # ...
library:
  css:
    # someCSS = "some.css"
    # located in "assets/"
    # Or
    # someCSS = "https://cdn.example.com/some.css"
  js:
    # someJS = "some.js"
    # located in "assets/"
    # Or
    # someJS = "https://cdn.example.com/some.js"
seo:
  images: []
  # ...
---

Já um tempo queria escrever sobre logs, mas sentia um pouco de dificuldade de criar um boa razão para defender uma escrita coerente para o tema. Eis que encontrei: Dados! Dados é considerado o novo petróleo e então precisamos conversar um pouco mais sobre ele.

Mas antes, vou voltar um pouco para explicar alguns conceitos: Log é um termo inglês para definir troncos de madeira empilhados. E por analogia, o mesmo acontece com o conjunto de informações que uma aplicação ou serviço pode acumular em um arquivo. O log basicamente é uma "pilha" de linhas de textos, que podem conter informações sobre como uma determinada aplicação ou serviço está sendo executada, ou pode registrar um possível erro do serviço ou em alguma regra de negócio. E como estamos falando desta pilha de informações que estão sendo acumuladas em algum bloco de texto, é imprescindível que exista informações básicas para caso necessite investigar, são elas: data, hora e a mensagem; E quando estamos falando de serviços e aplicações no cenário atual, temos muita variação de formatos de logs, pois cada tipo de serviço possui suas próprias particularidades. Então, podemos afirmar que temos diversos formatos diferentes de mensagens, desde informativa a erros críticos.

Por isso é importante hoje para uma aplicação que esteja sendo desenvolvida siga alguma regra estrutural de como as informações são guardadas no arquivo de log, pelo motivo que geralmente muitas destas mensagens são geralmente reaproveitadas para identificar falhas que existem no desenvolvimento de software, sendo acessada pela própria pessoa desenvolvedora para debugar o código. Mas como estamos lidando muitas vezes com tecnologias em nuvem com alta complexidade de serivços acoplados em nosso aplicativo, geralmente são usados agregadores de logs, como por exemplo o ElasticSearch ou Datadog, para auxiliar a detecção de falhas no app ou em serviços correlatos e até a predição de um possível erro.

Por isso é muito importante entender sobre o log e tipos de erros e formatos, dentro de uma boa prática de escrita de código (Isso fica para um outro artigo), qual inclusive indico a leitura do capítulo 7 do livro [*Clean Code* de Robert C. Martin](URL) 

E o formato [Json]()? Bora explicar!!!

De forma grosseira, o Json é um fomato semi-estruturado de dados tipo CHAVE=VALOR que é usado comumente em diversas aplicações para se comunicarem entre si via [API](). E geralmente quando estamos falando mais alto nível no quesito de aproveitamento destas informações como requisito de estratégia, nada melhor do que deixar o formato de saída de log melhor acoplado com as diversas ferramentas de agregação de logs, já que a maioria dos serviços que agregam logs conversam entre si em formato Json.


<!--more-->

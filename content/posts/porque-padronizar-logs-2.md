---
title: "Padronização e enriquecimento de Dados"
subtitle: "Porque padronizar Logs Parte 2"
date: 2023-02-27T20:57:41-03:00
lastmod: 2023-02-27T20:57:41-03:00
draft: true
author: ""
authorLink: ""
description: ""

tags: []
categories: []

featuredImage: "images/logs.jpg
featuredImagePreview: ""

linkToMarkdown: true

toc:
  enable: true
  auto: true
code:
  copy: true
  maxShownLines: 50
math:
  enable: false
comment:
  enable: true
---
Enriquecer a informação do seu log pode nascer na arquitetura do seu software,<!--more--> e aplicar esta metodologia no início do projeto requer um pouco mais de disciplina. E esta definição é importante inclusive na escolha da biblioteca de geração de logs do seu projeto.

Por exemplo, em um trecho de código desenvolvido em NodeJS (javascript ou typescript), foi usado o método `console.log()`:

```javascript
console.log("Ocorreu um erro imprevisto")
```
O método `console.log()` deve-se ser desencorajado em aplicações que necessitam controles que envolvam uma categorização entre uma mensagem de erro ou de informação, pois este método imprime uma mensagem

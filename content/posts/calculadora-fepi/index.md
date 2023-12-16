---
title: "Calculadora Fepi"
subtitle: ""
date: 2023-12-15T18:57:50-03:00
lastmod: 2023-12-15T18:57:50-03:00
draft: true
author: ""
authorLink: ""
description: ""
license: ""
images: []

tags: []
categories: []

featuredImage: ""
featuredImagePreview: ""

#hiddenFromHomePage: false
#hiddenFromSearch: false
#twemoji: false
#lightgallery: true
#ruby: true
#fraction: true
linkToMarkdown: true
#rssFullText: false
math: true

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

---

Calculadora Fepi<!--more-->

{{< script >}}
console.log("teste");
//script simples para calcular media da fepi
function calculadora() {
    // variaveis recebem valores dos elementos html
    var nota1 = document.getElementById("bin1").value;
    var nota2 = document.getElementById("bin2").value;

    // calculos baseados no excel fornecido pela FEPI
    var media = ((nota2 * 3) + (nota1 * 2)) / 5;

    if (media < 70) {
        var pontos_faltantes = (250 - (3 * media) ) / 2;
        var resultado = "Nota necessaria do exame: " + pontos_faltantes.toFixed(2);
    } else {
        var resultado = "Ferias!!"
    }

    document.getElementById("resultado").innerHTML = resultado;
}

function nota2bin() {
    // variaveis recebem valores dos elementos html
    var nota1 = document.getElementById("bin1").value;

    var nota_nececessaria_2bin = ((350-2) * nota1) / 3;

}
{{< /script >}}

A fórmula usada foi inspirada no arquivo de Excel fornecido pela FEPI:

$$mediaFinal=((2bimestre*3)+(1bimestre*2))/5$$ 
$$pontosFaltantes=(250-(3*mediaFinal))/2$$

Nota do primeiro bimestre:<input type="text" value="70" id="bin1"/>
Nota do segundo bimestre:<input type="text" value="70" id="bin2"/>

<button onClick="calculadora();">Calcular!</button>
 
{{< admonition type=tip title="Fique ligado na nota!" open=true >}}
<did id="resultado"></div>
{{< /admonition >}}


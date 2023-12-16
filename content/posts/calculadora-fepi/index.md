---
title: "Calculadora Fepi"
subtitle: ""
date: 2023-12-15T18:57:50-03:00
lastmod: 2023-12-15T18:57:50-03:00
draft: false
author: ""
authorLink: ""
description: ""
license: ""
images: []

tags: []
categories: []

featuredImage: ""
featuredImagePreview: ""

hiddenFromHomePage: true
hiddenFromSearch: true
#twemoji: false
#lightgallery: true
#ruby: true
#fraction: true
linkToMarkdown: true
#rssFullText: false

toc:
  enable: true
  auto: true
code:
  copy: true
  maxShownLines: 50
math:
  enable: true
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
//script simples para calcular media da fepi
function calculadora() {
    // variaveis recebem valores dos elementos html
    var nota1 = document.getElementById("bin1").value;
    var nota2 = document.getElementById("bin2").value;

    // calculos baseados no excel fornecido pela FEPI
    var media = ((nota2 * 3) + (nota1 * 2)) / 5;
    var nota_nececessaria_2bin = (350-(2*nota1)) / 3;

    if (media < 70) {
        var pontos_faltantes = (250 - (3 * media) ) / 2;
        var resultado = "Media Final (Mf): " + media.toFixed(2); 
        resultado += "<br>Pontos Faltantes (Pfa) exame final: " + pontos_faltantes.toFixed(2);
        resultado += "<br>Precisaria em N2 " + nota_nececessaria_2bin.toFixed(2) + " pontos para aprovação!";
    } else {
        var resultado = "Ferias!! Sua média final (Mf) é:" + media.toFixed(2);
    }

    document.getElementById("resultado").innerHTML = resultado;
}

function nota2bin() {
    // variaveis recebem valores dos elementos html
    var nota1 = document.getElementById("bin1").value;

    var nota_nececessaria_2bin = (350-(2*nota1)) / 3;
    var resultado = "N2 seria: " + nota_nececessaria_2bin.toFixed(2) + " para passar direto!";

    document.getElementById("resultado").innerHTML = resultado;

}
{{< /script >}}

A fórmula usada foi inspirada no arquivo de Excel fornecido pela FEPI:

$$
\begin{align}
Mf &= \big((N1 * 2 ) + ( N2 * 3 ) \big) / 5 \\\\
Pfa &= \big( 250 - ( 3 * Mf ) ) / 2
\end{align}
$$

-------------------------------------

Nota do primeiro bimestre (N1):
<input type="text" value="70" id="bin1" onKeyUp="nota2bin();" style="border: 1px solid gray;padding: 5px!important;"/>

Nota do segundo bimestre (N2):
<input type="text" value="70" id="bin2" onKeyUp="calculadora();" style="border: 1px solid gray;padding: 5px!important;"/>

<input type="button" onClick="calculadora();" value="Calcular!" style="border: 1px solid gray;padding: 5px!important;border-radius: 5px"/>
 
{{< admonition type=tip title="Fique ligado na nota!" open=true >}}
<did id="resultado"></div>
{{< /admonition >}}


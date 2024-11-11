---
title: "Codigo de Barras"
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
  enable: false
  # ...

---

Codigo de Barras
<!--more-->
<script src="https://cdn.jsdelivr.net/npm/jsbarcode@3.11.0/dist/JsBarcode.all.min.js"></script>

{{< script >}}
//script simples para mostrar codigo de barras

if (getCookie("matricula") == "") {
    barcode(123456);
} else {
    barcode(getCookie("matricula"));
    document.getElementById("matricula").value = getCookie("matricula");
}

function barcode(value) {
    JsBarcode("#barcode", value, {format: "itf", width: 5, height: 250});
    setCookie("matricula", value, 200);
}

function setCookie(cname, cvalue, exdays) {
  const d = new Date();
  d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
  let expires = "expires="+d.toUTCString();
  document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/;SameSite=Strict";
}

function getCookie(cname) {
  let name = cname + "=";
  let ca = document.cookie.split(';');
  for(let i = 0; i < ca.length; i++) {
    let c = ca[i];
    while (c.charAt(0) == ' ') {
      c = c.substring(1);
    }
    if (c.indexOf(name) == 0) {
      return c.substring(name.length, c.length);
    }
  }
  return "";
}
{{< /script >}}

-------------------------------------

### Coloque sua Matricula com 6 digitos
<center><input type="text" value="00000" id="matricula" onKeyUp="barcode(this.value);" style="border: 1px solid gray;padding: 5px!important;"/>
<hr>

<img id="barcode" width="80%"/></center>

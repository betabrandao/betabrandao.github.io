---
layout: post
title: "Criando um mini chat com o NetCat"
date: 2018-04-06 03:03:09
description: "Para conversar com sua mina no terminal ou trocar variáveis em VMs"
tags: linux, terminal, netcat
categories: linux
comments: true
twitter_text: "Criando um mini chat com NetCat"
introduction: "Sem rodeios, vamos pro code"
---

Netcat é uma espécie de "telnet" para o linux, mas conhecido como o *canivete suíço* pela sua versatilidade, é usado para criar proxys, até testes de intrusão... Geralmente vem no pacote do linux pelo comando `nc`, mas se acaso esteja em um **Linux subsystem for Windows**, é necessário instalar usando o comando: `sudo apt-get install netcat -y` (para sistemas em ubuntu, debian) ou `yum install netcat -y` (CentOS) ou `dnf install netcat -y` (Fedora e RedHat).

Sem rodeios, vamos para o code:

1. No seu terminal do "servidor" faça:

```bash
$ nc -l -p 1025
```
O comando `-l` é para habilitar o listen (modo escuta) e o `-p` é a porta que será escutada. Lembrando que deve-se usar portas acima de 1024, pois estas são usadas somente pelo root.

2. No outro terminal "cliente", execute:

```bash
$ nc <IP do Servidor> <PORTA>
```
> É possível usar o telnet.exe do windows para conectar no "servidor", basta usar a mesma sintaxe `telnet.exe <IP do Servidor> <PORTA>`, mas não recomendo muito para chats pois não funciona muito bem.
> Esta dica é super válida quando está em um servidor em um Hyper-V e precisa-se passar valores de texto da sua estação de trabalho para a máquina virtual.

Pronto! Agora é só bater um papo com sua mina (ou mano) que curte as tecnologias. Ou trocar mensagens entre máquinas onde o *copy* e *paste* é impraticável.

Este é o primeiro post no blog, espero terem gostado! 
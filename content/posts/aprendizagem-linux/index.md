---
title: "Curadoria de Aprendizagem Linux"
subtitle: ""
date: 2024-03-16T21:40:46-03:00
lastmod: 2024-03-16T21:40:46-03:00
draft: false
authors: ['Beta Brandao']
description: ""

tags: [linux, devops, gpt, aprendizagem]
categories: [devops]
series: []

hiddenFromHomePage: false
hiddenFromSearch: false

featuredImage: "nationalgeographic2723148-copia.jpg"
featuredImagePreview: ""

toc:
  enable: true
math:
  enable: false
lightgallery: false
license: ""
---
Este é um guia inicial para quem deseja começar a estudar Linux.<!--more--> E pra quem está começando no mundo de DevOps e Infra de datacenter, conhecimento e prática são primordiais. Mas não se assuste com o volume de conteúdo, pois este é um guia de estudos.

> **Pinguim-rei** (Aptenodytes patagonicus), uma das 18 espécies existentes do animal. Foto de [Thomas P. Peschak - NatGeo](https://www.nationalgeographicbrasil.com/fotografo/thomas-p-peschak-0)


**Dica de Ouro**: Recomendo o site do [Guia Foca](https://guiafoca.org/guiaonline/), que possui materiais separados por níveis iniciante, intermediário e avançado, em texto ou PDF para download. É meu guia no linux desde sempre.

## Dicas de Como estudar:
- Instale um linux no seu [computador preferencialmente](https://www.youtube.com/watch?v=wdMi0UbGGxM), ou use uma [Máquina virtual](https://www.youtube.com/watch?v=XxZ8BTCBDis);
- Dê preferência ao [Ubuntu](http://www.ubuntu.com/), pois é uma distribuição Linux bem conhecida;
- Exercite usar mais o teclado que o mouse para edição de texto, como a navegação e seleção de texto;
- Há itens da lista ainda não possuem referências de pesquisa, mas é possível buscar no Google sobre o tema; 

### Sobre o conteúdo:
Além dos tópicos abaixo, separaremos os temas entre **base**, **importante** e **extra**, para organizar os estudos:

- **base**: tópico com mais prioridade alta no tempo para aprendizagem e reforço de treino;
- **importante**: tópico com média prioridade no tempo de aprendizagem;
- **extra**: tópico extra, que geralmente depende do material de **base** e **importante**;

## 1. Introdução ao Linux 
- História do Linux e do movimento de código aberto: (**importante**)
  - História do Linux:
    - [Guia Foca](https://guiafoca.org/guiaonline/iniciante/ch01s04.html)
    - [Wikipedia](https://pt.wikipedia.org/wiki/Hist%C3%B3ria_do_Linux)  
  - O que é software Livre ou código aberto? 
    - [Guia Foca](https://guiafoca.org/guiaonline/iniciante/ch01s06.html) 
- Princípios básicos do sistema operacional Linux: (**base**)
  - [youtube](https://www.youtube.com/watch?v=BBr12sZ5li)

## 2. Fundamentos do Sistema
- Estrutura do sistema de arquivos Linux (**base**)
- Comandos básicos do Linux (ls, cd, cp, mv, rm, mkdir, etc.) (**base**)
- Trabalhando com permissões de arquivos e diretórios (**base**)
- Utilização do terminal (bash) (**base**)

## 3. Administração de Sistemas Linux
- Gerenciamento de usuários e grupos (**base**)
- Configuração de ambientes de trabalho (**importante**)
- Configuração de rede (IP, DNS, Gateway, etc.) (**base**)
- Gerenciamento de processos (ps, top, kill, etc.) (**base**)
- Instalação e atualização de software (apt, yum, etc.) (**base**)

## 4. Tarefas Administrativas Básicas
- Gerenciamento de impressoras (**importante**)
- Backup e restauração de dados (**base**)
- Agendamento de tarefas (cron) (**importante**)

## 5. Segurança
- Conceitos básicos de segurança de sistemas (**importante**)
- Configuração de firewall (iptables) (**base**)
- Implementação de medidas de segurança básicas (**base**)

## 6. Resolução de Problemas
- Identificação e resolução de problemas de inicialização (**importante**)
- Resolução de problemas de rede (**importante**)
- Resolução de problemas de disco (**importante**)

# Nível 2 - Certificação LPIC-2 (Administração de Serviços):

## 1. Capacidades Avançadas de Administração de Sistemas Linux
- Configuração avançada de rede (VPN, DHCP, DNS, etc.) (**importante**)
- Gerenciamento avançado de armazenamento (RAID, LVM, etc.) (**importante**)
- Configuração de serviços de diretório (LDAP, Active Directory) (**extra**)

## 2. Segurança de Redes Linux
- Configuração de VPNs (**importante**)
- Implementação de medidas avançadas de segurança (**extra**)
- Monitoramento de segurança (**extra**)

## 3. Virtualização e Contêineres
- Virtualização com KVM ou VirtualBox (**importante**)
- Conceito de isolamento de processos com container (**base**)
  - Leia meu artigo sobre [container](/posts/docker-na-pratica/).
- Contêineres com LXC (**base**):
- Contêineres com Docker (**importante**)
- Orquestração de contêineres com Docker Compose (**extra**)
- Orquestração de contêineres com Kubernetes (**extra**)

## 4. Administração de Servidores Web
- Configuração de servidores web (Apache, Nginx) (**extra**)
- Gerenciamento de sites e domínios (**extra**)
- Configuração de segurança para servidores web (**extra**)

## 5. Automação e Scripting
- Automação de tarefas com scripts: (**importante**)
- - bash (**importante**)
- - python (**extra**)
- Configuração de agendamento de tarefas automáticas (cron, systemd) (**importante**)

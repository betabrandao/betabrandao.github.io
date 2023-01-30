---
title: "Configurando a APN no roteador chinês usb 4G/LTE"
date: 2023-01-15T21:11:12-03:00
draft: true
categories: ["personal"]
---

Antes de iniciar, tenha em mãos:

1. Chip da sua operadora já ativado e funcionando preferencialmente em seu celular;
2. Um cartão MicroSD de até 32Gb para o modem usar. Sem o cartão MicroSD, o aparelho [reinicia continuamente sem explicação lógica](https://www.linux.org.ru/tag/modem?section=2). Recomendo algum cartão microSD dedicado para roteador de 2Gb.

# Configuração das APNs

Acredito que por padrão, o aparelho virá com configuração da china, apague-a, pois ela vem com o número **CIMI** de alguma operadora chinesa.

O número **CIMI** é composto inicialmente por três dígitos do **MCC** (Mobile Country Code), que no Brasil é 724; e por dois ou três dígitos do **MSC** (Mobile Network Code) que varia para cada operadora. 

Abaixo segue uma tabela de dados de **APNs** de operadoras. Caso não funcione, sugiro copiar os dados da APN do celular que você ativou o chip, conforme explicado neste [link](https://tecnoblog.net/231819/configurar-apn-claro-android-galaxy/).

| Operadora | MCC | MSC | CIMI | APN | Username | Password |
| --- | --- | --- | --- | --- |  --- | --- |
| Claro | 724 | 05 | 72405 | claro.com.br | claro | claro |
| Vivo | 724 | 23 | 72423 | zap.vivo.com.br | vivo | vivo |
| Tim | 724 | 03 | 72403 | timbrasil.br | tim | tim |
| Oi | 724 | 31 | 72431 | gprs.oi.com.br | oi | oi |
| Algar | 724 | 34 | 72434 | algar.br | algar | 1212 |
| Correios Celular | 724 | 17 | 72417 | internet.br | deixar em branco | deixar em branco |
| Sercomtel | 724 | 15 | 72415 | sercomtel.com.br | sercomtel | sercomtel |
| Nextel | 724 | 39 | 72439 | wap.nextel3g.net.br | deixar em branco | deixar em branco |

No painel de configuração da APN em seu roteador, existe os campos:

- **Network Provider:** Neste campo, insira algum nome que identifique)
- **CIMI:** Neste campo você insere os dados **CIMI** da sua operadora.
- **Dial Number**: *99# 
- **Username:** Neste campo o username, geralmente é o nome da operadora
- **Password:** a mesma informação de username, geralmente também é o nome da operadora
- **Authentication:** PAP
- **APN:** Insira aqui o endereço da APN

Salve e reinicie o modem.


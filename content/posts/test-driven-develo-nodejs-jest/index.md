---
title: "Test Driven Development com Nodejs e Jest"
subtitle: ""
date: 2023-08-22T22:18:19-03:00
lastmod: 2023-08-22T22:18:19-03:00
draft: false
author: "Beta brandao"
authorLink: ""
description: ""
license: ""
images: []

tags: [apps, nodejs, javascript]
categories: [desenvolvimento]

featuredImage: "image.jpg"
featuredImagePreview: "image.jpg"

#hiddenFromHomePage: false
#hiddenFromSearch: false
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

## Conceito e Processo
O TDD segue um ciclo de três etapas: Red-Green-Refactor.

**Red (Vermelho)**: Comece escrevendo um teste automatizado que inicialmente falhará. Isso define o comportamento desejado do código que você ainda não implementou.

**Green (Verde)**: Escreva o código mínimo necessário para que o teste passe. O objetivo é fazer o teste passar o mais rápido possível.

**Refactor (Refatorar)**: Agora que o teste passa, você pode refatorar o código para melhorar sua estrutura, clareza e eficiência, sempre garantindo que os testes continuem passando.

## Exemplo de TDD com Node.js e Jest
Vamos considerar um cenário simples: você deseja implementar uma função de soma em um módulo Node.js e deseja aplicar TDD a essa implementação usando o framework de teste Jest.

### Configuração

Certifique-se de ter Node.js instalado e, em seguida, crie um diretório para o projeto e execute:

```sh
npm init -y
npm install --save-dev jest
```

### Escrever o Primeiro Teste

Crie um arquivo chamado sum.test.js na pasta do seu projeto:

```javascript
// sum.test.js
const sum = require('./sum');

test('adds 1 + 2 to equal 3', () => {
  expect(sum(1, 2)).toBe(3);
});
```

Neste ponto, você não tem a função sum implementada ainda, mas

### Implementar o Código

Crie um arquivo chamado sum.js na mesma pasta e escreva a função sum:

```javascript
// sum.js
function sum(a, b) {
  return a + b;
}
```

module.exports = sum;
Agora a implementação básica da função sum está completa.

### Executar os Testes

Execute os testes usando o Jest:

```sh
npx jest
```

Se tudo estiver correto, o teste que você escreveu no arquivo sum.test.js deve passar.

### Refatoração (Opcional)

Neste exemplo simples, a função sum é tão direta que a refatoração pode não ser necessária. Mas em cenários mais complexos, a refatoração é onde você pode melhorar a estrutura do código e garantir que os testes continuem passando.

## Mocking e Stubs
Use ferramentas para simular partes do sistema que não estão sendo testadas. Aqui está um exemplo de como fazer mocking e stubs usando o Jest em um cenário de teste de uma função que faz uma requisição HTTP utilizando o módulo `axios`.

Suponhamos que temos uma função `fetchData` que faz uma requisição *HTTP* e retorna os dados obtidos:

```javascript
// fetchData.js
const axios = require('axios');

async function fetchData(url) {
  try {
    const response = await axios.get(url);
    return response.data;
  } catch (error) {
    throw new Error('Erro na requisição');
  }
}

module.exports = fetchData;
```

Agora, vamos escrever testes para essa função, usando mocking para simular a requisição HTTP.

### Instalação das Dependências

Certifique-se de ter o Jest instalado no seu projeto:

```sh
npm install --save-dev jest
```

### Escrevendo o Teste com Mocking

Aqui está um exemplo de teste usando mocking para simular a requisição HTTP usando o módulo axios:

``` javascript
// fetchData.test.js
const axios = require('axios');
const fetchData = require('./fetchData');

jest.mock('axios');

test('fetchData should fetch successfully data from an API', async () => {
  const data = { data: 'data' };
  axios.get.mockResolvedValue(data);

  await expect(fetchData('https://example.com')).resolves.toEqual(data);
});

test('fetchData should throw an error if request fails', async () => {
  axios.get.mockRejectedValue(new Error('Network Error'));

  await expect(fetchData('https://example.com')).rejects.toThrow('Erro na requisição');
});
```

Nesse exemplo, estamos usando `jest.mock('axios')` para criar um *mock* do módulo *axios*. Em seguida, estamos usando `axios.get.mockResolvedValue` para simular uma resposta bem-sucedida e `axios.get.mockRejectedValue` para simular um erro na requisição.

### Executando os Testes

Execute os testes usando o Jest:

```sh
npx jest
```

Se tudo estiver configurado corretamente, os testes usando mocking devem passar.

## Testes de Regressão
Ao corrigir um bug, adicione um teste para prevenir regressões. (Pauta para um novo artigo, aguarde <3)

## Testes Exploratórios
Além de testes automatizados, realize testes manuais exploratórios para encontrar cenários não cobertos. (Pauta para um novo artigo, aguarde <3)

## Code Coverage
Utilize ferramentas para avaliar a cobertura de código por testes. Isso ajuda a identificar partes não testadas. O SonarQube é uma ferramenta popular de análise estática de código que ajuda a manter a qualidade do código, identificando problemas de código, vulnerabilidades e fornecendo insights sobre as boas práticas. Vou mostrar como integrar o exemplo de *Test-Driven Development (TDD)* que mencionamos anteriormente com o SonarQube para melhorar ainda mais a qualidade do código.

### Escrevendo Testes Usando o Jest e o SonarQube
Vamos começar definindo um cenário de teste mais abrangente para a função sum e depois veremos como integrar o SonarQube para analisar a qualidade do código.

#### Escrever um Teste Mais Abrangente

Vamos escrever um teste que verifica o comportamento da função sum para números positivos, negativos e zero:

```javascript
// sum.test.js
const sum = require('./sum');

test('adds 1 + 2 to equal 3', () => {
  expect(sum(1, 2)).toBe(3);
});

test('adds -1 + 2 to equal 1', () => {
  expect(sum(-1, 2)).toBe(1);
});

test('adds 0 + 0 to equal 0', () => {
  expect(sum(0, 0)).toBe(0);
});
```

#### Configurar o SonarQube para Testes Jest

Para permitir que o SonarQube analise os resultados dos testes, é importante configurar o caminho dos relatórios dos testes. No seu arquivo `sonar-project.properties`, você já definiu `sonar.javascript.jstest.reportsPath=test`.

#### Executar os Testes e Analisar com o SonarQube

Agora você pode executar os testes e analisar o código usando o SonarQube. Certifique-se de ter o ambiente do SonarQube configurado e acessível.

Execute os testes e gere os relatórios no formato esperado pelo SonarQube:

```sh
npm run test:sonar
```

Execute a análise do SonarQube para seu projeto:
```sh
sonar-scanner
```
Acesse a interface do SonarQube para ver os resultados da análise. Lá, você poderá ver as métricas de qualidade do código, incluindo a cobertura de testes.

Lembre-se de que a adaptação dessas práticas às necessidades específicas do seu projeto é essencial. A medida que você se familiariza com essas práticas, estará bem equipado para criar software de alta qualidade e confiabilidade.

---
<3

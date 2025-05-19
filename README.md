# betabrandao.github.io

Este repositório contém o código-fonte do site pessoal gerado com [Hugo](https://gohugo.io/), um gerador de sites estáticos rápido e moderno, com o tema [hugo-coder](https://github.com/luizdepra/hugo-coder).

## 📦 Requisitos

Antes de começar, você precisa ter instalado:

- [Git](https://git-scm.com/)
- [Hugo](https://gohugo.io/getting-started/installing/) (versão recomendada: igual ou superior a 0.92.0)

Para verificar se o Hugo está instalado corretamente:

```bash
hugo version
```

## 🚀 Rodando localmente

Na raiz do repositório, há um script chamado `run.sh` que automatiza a execução do servidor local de desenvolvimento.

### Usando o script `run.sh`

O script compila o site e inicia o servidor local em `http://localhost:1313`.

```bash
./run.sh  [new|n] 'article title name' #To create new article
./run.sh [local|l]  # To start server to ip bind"
./run.sh [serve|s]  IP_BIND # To start server and bind to ip
```

Isso garante que o conteúdo será renderizado completamente, mesmo após alterações recentes nos arquivos.

## 🛠 Estrutura do repositório

- `config.toml`: configurações principais do site
- `content/`: arquivos de conteúdo (posts, páginas, etc.)
- `static/`: arquivos estáticos (imagens, CSS customizado, etc.)
- `themes/`: tema utilizado (hugo-DoIt)
- `run.sh`: script para rodar o servidor local

## 💾 Como fazer commits corretamente

Para manter o repositório organizado e garantir que o site funcione corretamente após cada alteração, siga os passos abaixo:

1. **Crie uma branch (opcional, mas recomendado):**

```bash
git checkout -b minha-publicacao
```

2. **Faça alterações no conteúdo ou na configuração.**

3. **Adicione os arquivos alterados:**

```bash
git add .
```

4. **Faça um commit descritivo:**

```bash
git commit -m "feat: adiciona novo artigo"
```

5. **Envie para o GitHub:**

```bash
git push origin minha-publicacao
```

6. **Abra um Pull Request**, ou se estiver na branch `main`, apenas faça push direto após o commit.

## 📤 Publicação

O site é publicado automaticamente via GitHub Pages, usando o conteúdo gerado na branch `main`.

Para gerar os arquivos estáticos localmente (caso deseje fazer deploy manual):

```bash
hugo
```

O conteúdo será gerado na pasta `public/`.

---

## 📚 Recursos úteis

- [Documentação do Hugo](https://gohugo.io/documentation/)
- [Tema Hugo Coder](https://github.com/luizdepra/hugo-coder)
- [GitHub Pages com Hugo](https://gohugo.io/hosting-and-deployment/hosting-on-github/)

---

## 🧑‍💻 Autor

Desenvolvido por [@betabrandao](https://github.com/betabrandao)

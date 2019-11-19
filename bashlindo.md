---
layout: page
title: Bash Lindo
permalink: /bashlindo/
category: "bash"
---

```
 ___ _   _             _ _         _                 _
|_ _| |_( )___    __ _| | |   __ _| |__   ___  _   _| |_
 | || __|// __|  / _` | | |  / _` | '_ \ / _ \| | | | __|
 | || |_  \__ \ | (_| | | | | (_| | |_) | (_) | |_| | |_
|___|\__| |___/  \__,_|_|_|  \__,_|_.__/ \___/ \__,_|\__|

                               _   _
 _ __   ___ _ __ ___ ___ _ __ | |_(_) ___  _ __
| '_ \ / _ \ '__/ __/ _ \ '_ \| __| |/ _ \| '_ \
| |_) |  __/ | | (_|  __/ |_) | |_| | (_) | | | |
| .__/ \___|_|  \___\___| .__/ \__|_|\___/|_| |_|
|_|                     |_|

```
 Meu gist: https://gist.robertabrandao.com.br
```bash
$ figlet "It's all about perception"
```

### [Git Alias](https://gist.robertabrandao.com.br/49557a6a2e0acde683dc3d3b908ea341)
Pra deixar o git mais lindo no bash (**e sim, eu comi o gost-script**) inclua no arquivo .bashrc no linux (ou WSL, ou Git Terminal) em seu diretório raíz as linhas abaixo:

No link do Gist do GitHub tem a versão completona com [comandos lindo](https://gist.robertabrandao.com.br/49557a6a2e0acde683dc3d3b908ea341),e aqui deixo os que mais uso:

```bash
# Aliases
alias gcl='git clone'
alias ga='git add'
alias grm='git rm'
alias gall='git add ./'
alias gfv='git fetch --all --prune --verbose'
alias gus='git reset HEAD'
alias gm="git merge"
alias g='git'
alias gs='git status'
alias gl='git pull'
alias gpr='git pull --rebase'
alias gpp='git pull && git push'
alias gup='git fetch && git rebase'
alias gp='git push'
alias gcm='git commit -v -m'
alias gbm='git branch -m'
alias gbD='git branch -D'
alias gcom='git checkout master'
alias gcod='git checkout develop'
alias gcb='git checkout -b'
alias gdel='git branch -D'
alias gg="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
alias ggs="gg --stat"
alias gstb="git stash branch"
alias gstd="git stash drop"
alias gstl="git stash list"
alias gstp="git stash pop"
alias gh='cd "$(git rev-parse --show-toplevel)"'
alias gu='git ls-files . --exclude-standard --others'
```


### ~~Onde eu pego meus livros que não tenho grana pra pagar~~: [Zlibrary Book](https://b-ok.cc/)

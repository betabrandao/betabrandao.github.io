---
layout: page
title: Bash Lindo
permalink: /bashlindo/
category: "bash"
---

## Mais Produtividade
Update: 2022

Quando tive oportunidade de trabalhar com ZSH no MacOs, curti muito a comodidade de trabalho com o [OMZ - Oh My Zsh](https://ohmyz.sh/) no Unix, Linuxlike e WSL. Recomendo.

Explore os [Plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins) para autocomplete.

Conheça o [ASDF-VM](https://asdf-vm.com/) Runtime, que gerencia várias versões de runtime no mesmo ambiente. Vale a pena.

Meu setup no VIM 8.0

```vim
" Vim-Plug
call plug#begin()
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'majutsushi/tagbar'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  "to highlight files in nerdtree
Plug 'townk/vim-autoclose'
Plug 'vim-syntastic/syntastic'
Plug 'joereynolds/vim-minisnip'
Plug 'ryanoasis/vim-devicons'

Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax
call plug#end()

set laststatus=2
set showtabline=2
set encoding=UTF-8

" enable syntax highlighting
syntax enable
colo darkblue

set number
set ts=4
set autoindent
set expandtab
set shiftwidth=4
set cursorline
set showmatch
let python_highlight_all = 1

" NerdTree autopen
autocmd vimenter * NERDTree
" NerdTree closeall
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowHidden=1

" Syntastic Config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_php_checkers = ['phpcs']

"g:syntastic_javascript_checkers = ['<checker-name>']

" Use Python test
autocmd Filetype python nnoremap <F9> :!claear;python3 "%"<cr>

" Use PHP test
autocmd Filetype php nnoremap <F9> :!clear;php "%"<CR>

"Use NodeJS test
autocmd Filetype javascript nnoremap <F9> :!clear;node "%" <CR>
let g:pymode_rope = 0 " " "" " " " " " " " "" } "
```


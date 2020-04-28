" Spacing
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab

" Numbers
setlocal number
setlocal relativenumber

"set UTF-8 encoding
setlocal enc=utf-8
setlocal fenc=utf-8
setlocal termencoding=utf-8

" Indentation
filetype indent on
setlocal autoindent " use indentation of previous line
setlocal smartindent " use intelligent indentation for programming

" Enable syntax
syntax on
syntax enable

" highlight matching braces
setlocal showmatch

" Set formatter
setlocal formatprg=prettier\ --parser\ typescript

" ##### Plugins ######
" Vim typescript
let g:typescript_indent_disable = 1

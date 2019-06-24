filetype indent on

setlocal ruler         " show the cursor position all the time
setlocal sw=4
setlocal ts=4
setlocal sts=4
setlocal expandtab

setlocal textwidth=100
setlocal colorcolumn=+1

setlocal fo-=t

" Numbers
setlocal number
setlocal relativenumber
" set numberwidth=5

" filetype plugin indent on
"set UTF-8 encoding
setlocal enc=utf-8
setlocal fenc=utf-8
setlocal termencoding=utf-8

" use indentation of previous line
" setlocal autoindent
" use intelligent indentation for programming
setlocal smartindent

" turn syntax highlighting on
" set t_Co=256 " Comentado para testar em uma maquina decente
syntax on
syntax enable

" highlight matching braces
setlocal showmatch

" Deoplete -----------------------------

" Use deoplete.

let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'

" When writing a buffer (no delay).
" call neomake#configure#automake('w')
" When writing a buffer (no delay), and on normal mode changes (after 750ms).
" call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing (no delay).
call neomake#configure#automake('rw', 1000)
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
" call neomake#configure#automake('nrwi', 500)

" needed so deoplete can auto select the first suggestion
setlocal completeopt+=noinsert

" comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
setlocal completeopt-=preview

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
" set wildmode=list:longest

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" Jedi-vim ------------------------------
"
" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0

" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command = ',d'
" Find ocurrences
let g:jedi#usages_command = ',o'
" Find assignments
let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
nmap ,D :tab split<CR>:call jedi#goto()<CR>

let g:jedi#goto_assignments_command = ",g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = ",k"
let g:jedi#usages_command = ",n"
" let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = ",r"

" Comments
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/'  }  }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1


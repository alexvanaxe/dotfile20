filetype indent on

let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" let g:nvim_typescript#default_mappings = 1

setlocal ruler         " show the cursor position all the time
setlocal sw=2
setlocal ts=2
setlocal sts=2
setlocal expandtab
" Make it obvious where 80 characters is
setlocal textwidth=80
setlocal colorcolumn=+1

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
setlocal autoindent
" use intelligent indentation for programming
setlocal smartindent

" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
setlocal textwidth=120
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
call neomake#configure#automake('w')
" When writing a buffer (no delay), and on normal mode changes (after 750ms).
" call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing (no delay).
" call neomake#configure#automake('rw', 1000)
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
" call neomake#configure#automake('nrwi', 500)

" needed so deoplete can auto select the first suggestion
" setlocal completeopt+=noinsert

" comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
setlocal completeopt-=preview

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
" set wildmode=list:longest
"

" Comments
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_typescript = 1

" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/'  }  }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1


" Refresh settings as saving the configs
" autocmd! bufwritepost ~/.config/nvim/init.vim source %
filetype on
filetype plugin on
syntax on

set undofile " Maintain undo history between sessions not so eternally!
set undodir=$HOME/.config/nvim/history

" disable vi compatibility (emulation of old bugs)
set nocompatible

let g:python_host_prog = $HOME . '/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = $HOME . '/.pyenv/versions/neovim3/bin/python'

set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set showcmd       " display incomplete commands
" highlight matching braces
set showmatch
" set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
" set autowrite     " Automatically :write before running commands

" Numbers
" set autowrite     " Automatically :write before running commands
"
" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
set shell=/bin/zsh

" Bookmark: To auto read the annotations from .vim-bookmarks
let g:bookmark_save_per_working_dir = 1
"let g:bookmark_auto_save = 1

" let g:deoplete#enable_at_startup=1
" AutoSelect the first element
" let g:deoplete#disable_auto_complete = 1

" inoremap <silent><expr> <c-space>
" \ pumvisible() ? "\<C-n>" :
" \ <SID>check_back_space() ? "\<c-space>" :
" \ deoplete#mappings#manual_complete()
" function! s:check_back_space() abort "{{{
" let col = col('.') - 1
" return !col || getline('.')[col - 1]  =~ '\s'
" endfunction"}}}

"inoremap <expr><c-space> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()

" set completeopt+=noinsert
set timeout!

" let g:deoplete#enable_debug = 1
" let g:deoplete#enable_profile = 1
" call deoplete#enable_logging('DEBUG', '/home/alexvanaxe/.config/nvim/personal/deoplete.log')

"if has("autocmd") && exists("+omnifunc")
"autocmd Filetype *
"    \	if &omnifunc == "" |
"    \		setlocal omnifunc=syntaxcomplete#Complete |
"    \	endif
"endif

" Window Chooser ------------------------------

" mapping
nmap  <leader>c  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1

" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" let g:vimspectrMuteLineNr = 'on'
" let g:vimspectrItalicComment = 'on'
" let g:vimspectrMuteStatusLine = 'on'

" Config for the ident guides
let g:indentLine_char = '.'

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


" make test commands execute using dispatch.vim
let test#strategy = "dispatch"

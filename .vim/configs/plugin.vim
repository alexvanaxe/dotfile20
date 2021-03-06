
if has('nvim')
	call plug#begin('~/.config/nvim/plugins')
else
	call plug#begin('~/.vim/plugged')
endif
" #### Helpers
Plug 'gantheory/vim-easymotion'
Plug 'tpope/vim-speeddating'
Plug 'arielrossanigo/dir-configs-override.vim'
Plug 'junegunn/goyo.vim'
Plug 'wesQ3/vim-windowswap'
Plug 'freitass/todo.txt-vim'

" #### IDE
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'janko-m/vim-test'
if !has('nvim')
    Plug 'tpope/vim-dispatch'
endif
Plug 'scrooloose/nerdcommenter', {'for': ['python', 'html', 'typescript', 'sh']}
Plug 'Yggdroot/indentLine' " Ident guides
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'sk1418/QFGrep'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'dense-analysis/ale' " Linting
Plug 'prettier/vim-prettier' " Formatting

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Quramy/tsuquyomi'
endif

" Javascript/Typescript
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'

" html
Plug 'mattn/emmet-vim' " Generate code html

" Python
Plug 'davidhalter/jedi-vim'
Plug 'Vimjas/vim-python-pep8-indent'

" General writing
Plug 'reedes/vim-pencil', { 'for': ['text', 'notes', 'markdown', 'mkd'] }
Plug 'junegunn/limelight.vim'

" #### EYECANDY
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'guns/xterm-color-table.vim'

"Colorschemes
Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'morhetz/gruvbox'
Plug 'Dave-Elec/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
Plug 'endel/vim-github-colorscheme'
Plug 'jaredgorski/fogbell.vim'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'lifepillar/vim-solarized8'
Plug 'chriskempson/base16-vim'
Plug 'fenetikm/falcon'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'fneu/breezy'
Plug 'whatyouhide/vim-gotham'
Plug 'arcticicestudio/nord-vim'
Plug 'Ardakilic/vim-tomorrow-night-theme'
Plug 'danilo-augusto/vim-afterglow'
Plug 'ayu-theme/ayu-vim'
Plug 'Arkham/vim-tango'
Plug 'effkay/argonaut.vim'
Plug 'artanikin/vim-synthwave84'
Plug 'sainnhe/gruvbox-material'
Plug 'atelierbram/vim-colors_atelier-schemes'
Plug 'fxn/vim-monochrome'
Plug 'mhartington/oceanic-next'
Plug 'andreasvc/vim-256noir'
Plug 'wadackel/vim-dogrun'
Plug 'arzg/vim-corvine'
Plug 'zanglg/nova.vim'
Plug 'reedes/vim-colors-pencil'

"Vimwiki
Plug 'vimwiki/vimwiki'

call plug#end()

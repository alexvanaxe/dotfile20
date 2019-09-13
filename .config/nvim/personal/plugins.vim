" Specify a directory for plugins
" " - For Neovim: ~/.local/share/nvim/plugged
" " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

Plug 'smancill/conky-syntax.vim'

"Plug 'gantheory/vim-easymotion'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-speeddating'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'

" ## IDE Plugins
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'arielrossanigo/dir-configs-override.vim'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'MattesGroeger/vim-bookmarks'
"Neovim Uncoment when running in neovim #TODO Detectar automaticamente
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/context_filetype.vim'
" Better language packs
Plug 'sheerun/vim-polyglot'
" Ident guides
Plug 'Yggdroot/indentLine'
" Tests made right?
Plug 'janko-m/vim-test'
Plug 'tpope/vim-dispatch'
Plug 'scrooloose/nerdcommenter', {'for': ['python', 'html', 'typescript', 'sh']}
Plug 'mkitt/tabline.vim'

" ## Facilitadores
" Plug 'easymotion/vim-easymotion'
Plug 'gantheory/vim-easymotion'
" Override configs by directory
Plug 'arielrossanigo/dir-configs-override.vim'
Plug 'vim-scripts/taglist.vim'
Plug 'tpope/vim-surround'
" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'
" Troca janelas de posicao
Plug 'wesQ3/vim-windowswap'
Plug 'tpope/vim-unimpaired'
" Icones
" Plug 'ryanoasis/vim-devicons'

" Permite fazer um grep do resultado do grep no quickfix window
Plug 'sk1418/QFGrep'
" Facilita criar tabulacoes
Plug 'godlygeek/tabular'
" Navegacao facilitada entre tmux e vim nos splits.
Plug 'christoomey/vim-tmux-navigator'
" Syntax completion baseada no syntax highlight
Plug 'vim-scripts/SyntaxComplete'
Plug 'othree/javascript-libraries-syntax.vim'

"## Programming plugins
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Check the syntax of the code
Plug 'vim-syntastic/syntastic'
" Automatically close parenthesis, etc
Plug 'jiangmiao/auto-pairs'

"## Themes Plugins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'haishanh/night-owl.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
" ColorSchemes
Plug 'NLKNguyen/papercolor-theme'
Plug 'rakr/vim-one'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'cormacrelf/vim-colors-github'
Plug 'fenetikm/falcon'
Plug 'ayu-theme/ayu-vim'
Plug 'TroyFletcher/vim-colors-synthwave'

" Window chooser
Plug 't9md/vim-choosewin'
" Collection of schemes
" Plug 'flazz/vim-colorschemes'
Plug 'vim-scripts/mayansmoke'
Plug 'jakwings/vim-colors'
Plug 'morhetz/gruvbox'
Plug 'nightsense/seabird'
Plug 'altercation/vim-colors-solarized'

" ## Angular Plugins
" Plug 'Shougo/vimproc.vim'
" Generate html in a simple way
Plug 'mattn/emmet-vim'
" Highlight matching html tags
Plug 'valloric/MatchTagAlways'
Plug 'leafgarland/typescript-vim'
Plug 'bdauria/angular-cli.vim'
Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
" Plug 'Quramy/tsuquyomi'
Plug 'othree/javascript-libraries-syntax.vim'

" ## Python Plugins
" Autocomplete
Plug 'davidhalter/jedi-vim'
" Automatically sort python imports
Plug 'fisadev/vim-isort' "<C-i> to use it in visual mode
" Linters
Plug 'neomake/neomake'
" Django
Plug 'jmcomets/vim-pony'
Plug 'tweekmonster/django-plus.vim'
" Folding
Plug 'tmhedberg/SimpylFold'

" # TMUX
Plug 'tmux-plugins/vim-tmux'
" C PLUGINS
" Plug 'mojodna/vim-conque'
" Plug 'vim-scripts/a.vim'
" Plug 'vim-scripts/OmniCppComplete'

call plug#end()

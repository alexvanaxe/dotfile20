:let mapleader = ","

ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>

" To go to normal mode without scracth
:inoremap jk <esc>

" Break line
nnoremap <leader>b i<CR><ESC>
nnoremap <leader>o o<ESC>
nnoremap <leader>O O<ESC>

nnoremap - ddp
nnoremap + ddkkp

nnoremap <F4> :Files<CR>
nnoremap <F5> :Buffers<CR>
nnoremap <F6> :Tags<CR>
nnoremap <F7> :Snippets<CR>
nnoremap <F8> :History:<CR>
nnoremap <F11> :Colors<CR>

nmap <F12> :TagbarToggle<CR>
nmap <F3> :NERDTreeToggle<CR>
map <leader><F3> :NERDTreeFind<CR>
" recreate tags file with F5
nnoremap <leader>rt :!ctags -R --sort=1 <CR>

nnoremap <leader>rc :!find . -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" > cscope.files; cscope -q -R -b -i cscope.files<CR><ESC>:cs add cscope.out<CR>
nnoremap <leader><F6> :set foldmethod=indent<cr>
nnoremap <leader><F7> :set foldmethod=syntax<cr>
nnoremap <leader><F8> :set foldmethod=manual<cr>zE

" HL search toggle
nnoremap <F10> :set hlsearch!<CR>
nmap <leader>ms :BookmarkSave .vim-bookmarks

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap <leader>f <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap <leader>2 <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Map the windows funcions
nnoremap <leader>% :vsplit<CR>
nnoremap <leader>" :split<CR>

" Move to another tab
nnoremap t1 :tabn 1<CR>
nnoremap t2 :tabn 2<CR>
nnoremap t3 :tabn 3<CR>
nnoremap t4 :tabn 4<CR>
nnoremap t5 :tabn 5<CR>
nnoremap t6 :tabn 6<CR>
nnoremap t7 :tabn 7<CR>
nnoremap t8 :tabn 8<CR>
nnoremap t9 :tabn 9<CR>

nnoremap tt :tabnew<CR>
nnoremap tc :tabclose<CR>

nnoremap <silent> tn :tabnext<CR>
nnoremap <silent> tp :tabprevious<CR>

nnoremap <silent> cd :cclose<CR>
nnoremap <silent> co :copen<CR>

nnoremap <silent> <leader>ld :lclose<CR>
nnoremap <silent> <leader>lo :lopen<CR>

nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tl :TestLast<CR>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

map <C-left> <C-w>H
map <C-down> <C-w>J
map <C-up> <C-w>K
map <C-right> <C-w>L

nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>

nmap <leader>ç :hi Normal guibg=NONE ctermbg=NONE<CR>

" Remove trailing spaces
nnoremap <leader>w :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" Map the fzf commands
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-i': 'vsplit' }

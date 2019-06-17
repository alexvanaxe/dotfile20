
" Config to work at work

let g:airline_powerline_fonts = 0

" Theming
let g:gruvbox_contrast_light="hard"
let g:solarized_termcolors=256

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

set t_Co=256
"let base16colorspace=256  " Access colors present in 256 colorspace

colorscheme github
"let g:airline_theme='gruvbox'

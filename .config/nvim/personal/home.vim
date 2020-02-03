" Config to work at home

let g:airline_powerline_fonts = 1

" Theming
"let g:gruvbox_italic=1
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

set termguicolors
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'transparent_background': 1
  \     }
  \   }
  \ }

colorscheme one

let g:airline_theme="one"

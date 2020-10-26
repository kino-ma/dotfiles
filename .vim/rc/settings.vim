set langmenu=en_US
let LANG='en_US'
let VIMRUNTIME='$HOME/'

let g:term_height = 12

source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set number                          " display line number"
set title                           " set title on termianl"

set tabstop=4                       " number of space inserted on TAB"
set shiftwidth=4                    " set auto-insert tab to space"
set softtabstop=4                   " number of spaces treat as tabs on BS or whatever
set expandtab                       " insert TAB eith space"
set smarttab                        " smart tab
set shiftround                      " round indent to multiple of 'shiftwidth'

set smartindent                     " autoindent on return"
set list                            " visiblize space"
set virtualedit=block               " enable moving to position where is empty"
set backspace=indent,eol,start      " enable using backspace key
set splitright                      " split right when opening new window
set hls                             " set highlight

set ignorecase                      " ignore cases when only lowercases
set smartcase                       " ignore cases when only lowercases 
set incsearch                       " highlights on typing when search
set wrapscan                        " searches wrap around the end of the file

set scrolloff=8                     " the least scroll row count

set splitbelow

hi MatchParen ctermfg=Black ctermbg=Brown

"dein Scripts-----------------------------
" Required:
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim/dein')
  call dein#begin('~/.vim/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  "call dein#add('')
  "call dein#add("cohama/lexima.vim")            " auto close parenthess
  call dein#add('elmcast/elm-vim')              " elm syntax
  call dein#add('rust-lang/rust.vim')           " rust syntax
  call dein#add('keith/swift.vim')              " swift syntax
  call dein#add('fatih/vim-go')                 " go syntax and other features
  call dein#add('maxmellon/vim-jsx-pretty')     " jsx (React) hightlight
  call dein#add('yuezk/vim-js')                 " js syntax
  call dein#add('HerringtonDarkholme/yats.vim') " typescript syntax
  call dein#add('pangloss/vim-javascript')
  call dein#add('rhysd/vim-wasm')
  call dein#add('bkad/CamelCaseMotion')         " 
  call dein#add('preservim/nerdtree')           " File explorer with tree view
  call dein#add('LnL7/vim-nix')                 " Nix expression language
  "call dein#add('jistr/vim-nerdtree-tabs')      " Sync NERDTree for all tabs

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

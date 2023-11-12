"dein Scripts-----------------------------

" Ward off unexpected things that your distro might have made, as
" well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Set dein base path (required)
let s:dein_base = '~/.cache/dein/'

" Set dein source path (required)
let s:dein_src = '~/.cache/dein/repos/github.com/Shougo/dein.vim'

" Set dein runtime path (required)
execute 'set runtimepath+=' .. s:dein_src

" Call dein initialization (required)
call dein#begin(s:dein_base)

call dein#add(s:dein_src)

" Your plugins go here:
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

" Finish dein initialization (required)
call dein#end()

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
if has('syntax')
  syntax on
endif

" Install not-installed plugins on startup.
if dein#check_install()
 call dein#install()
endif


"End dein Scripts-------------------------

" copy buffer into clipboard
command! CP %y+

" disable <Space> key on normal/visual mode
nnoremap <Space> <Nop>
vnoremap <Space> <Nop>

" set <Leader> key to <Space>
let mapleader = "\<Space>"

" Dvorak mapping
noremap d h
noremap h j
noremap t k
noremap n l

noremap k d
noremap l n
noremap j t    " j is used by ]b (*Backward to the end of camel word*)

" emacs keybind on insert mode
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-h> <BS>
inoremap <C-d> <Del>

" completion
inoremap <C-]> <C-n>

cnoremap <silent> <C-p> <Up>
cnoremap <silent> <C-n> <Down>
cnoremap <silent> <C-f> <Right>
cnoremap <silent> <C-b> <Left>
cnoremap <silent> <C-a> <Home>
cnoremap <silent> <C-e> <End>
cnoremap <silent> <C-d> <Del>

noremap - ^
noremap _ $


" treating with clipboard
nnoremap <Leader>y "+y
nnoremap <Leader>p "+p
vnoremap <Leader>y "+y
vnoremap <Leader>p "+p

" clear highlight and redraw
nnoremap <silent> <Leader>l :<C-u>nohlsearch<CR><C-l>

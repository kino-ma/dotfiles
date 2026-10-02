" copy buffer into clipboard
command! CP %y+

" disable <Space> key on normal/visual mode
nnoremap <Space> <Nop>
vnoremap <Space> <Nop>

" Dvorak mapping
noremap d h
noremap h gj
noremap t gk
noremap n l

noremap k d
noremap l n
noremap j t

" emacs keybind on insert mode
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-a> <ESC>I
inoremap <C-e> <ESC>A
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

" shortcuts
noremap - ^
noremap _ $

nnoremap <silent> <C-p> <C-u>
nnoremap <silent> <C-u> <C-d>

" useful shortcuts
nnoremap <silent> <C-w> :w<CR>

" treating with clipboard
nnoremap <Leader>y "+y
nnoremap <Leader>x "+x
nnoremap <Leader>p "+p
vnoremap <Leader>y "+y
vnoremap <Leader>x "+x
vnoremap <Leader>p "+p

" clear highlight and redraw
nnoremap <silent> <Leader>l :<C-u>nohlsearch<CR><C-l>

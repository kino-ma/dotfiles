" copy buffer into clipboard
command! CP %y+

" disable <Space> key on normal/visual mode
nnoremap <Space> <Nop>
vnoremap <Space> <Nop>

" set <Leader> key to <Space>
let mapleader = "\<Space>"


" Dvorak mapping
noremap d h
noremap h gj
noremap t gk
noremap n l

" emacs keybind on insert mode
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-a> <ESC>I
inoremap <C-e> <ESC>A
inoremap <C-h> <BS>
inoremap <C-d> <Del>

cnoremap <silent> <C-p> <Up>
cnoremap <silent> <C-n> <Down>
cnoremap <silent> <C-f> <Right>
cnoremap <silent> <C-b> <Left>
cnoremap <silent> <C-a> <Home>
cnoremap <silent> <C-e> <End>
cnoremap <silent> <C-d> <Del>


noremap k d
noremap l n
noremap j t

" shortcuts
noremap - ^
noremap _ $


" manipulating tabs
" next tab
function! g:NextTab()
    :bnext
    "if &buftype ==# 'terminal'
    "    call g:NextWindow()
    "endif
endfunction

" previous tab
function! g:PreviousTab()
    :bprev
    "if &buftype ==# 'terminal'
    "    call g:PreviousWindow()
    "endif
endfunction


" manipulating windows
" next window
function! g:NextWindow()
    wincmd w
    if &buftype ==# 'terminal'
        call g:NextWindow()
    endif
endfunction


" previous window
function! g:PreviousWindow()
    wincmd W
    if &buftype ==# 'terminal'
        call g:PreviousWindow()
    endif
endfunction


nnoremap <silent> <C-d> :call g:PreviousWindow()<CR>
nnoremap <silent> <C-h> :call g:PreviousTab()<CR>
nnoremap <silent> <C-t> :call g:NextTab()<CR>
nnoremap <silent> <C-n> :call g:NextWindow()<CR>

nnoremap <silent> <C-p> <C-u>
nnoremap <silent> <C-u> <C-d>


" useful shortcuts
nnoremap <silent> <C-w> :w<CR>
nnoremap q :q
nnoremap <Leader>q :q!
nnoremap <silent> <Leader>Q :w<CR>:bd<CR>


" input CR
nnoremap <silent>  o<ESC><UP>
nnoremap <silent> <Leader><CR> O<ESC>

" escape from input mode
inoremap <silent> jj <ESC>

" delete left character
nnoremap <silent> <BS> hx

" treating with clipboard
nnoremap <Leader>y "+y
nnoremap <Leader>p "+p
vnoremap <Leader>y "+y
vnoremap <Leader>p "+p

" prefix to move windows
nnoremap <Leader>w <C-w>

" split commands
nnoremap <silent> <Leader>v :vsplit<CR>
nnoremap <silent> <Leader>n :vnew<CR>

nnoremap <silent> <Leader>s :split<CR>
nnoremap <silent> <Leader>hn :new<CR>


" open terminal
nnoremap <silent> <Leader>t :call SwitchToTerm()<CR>
nnoremap <silent> <Leader>T :call OpenTermVert()<CR>



" clear highlight and redraw
nnoremap <silent> <Leader>l :<C-u>nohlsearch<CR><C-l>

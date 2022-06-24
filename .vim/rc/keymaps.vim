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

noremap k d
noremap l n
noremap j t
noremap t k

" Map t to UP, not Open In New Tab, in netrw & nerdtree mode
augroup netrw_mapping
    autocmd!
    autocmd filetype nerdtree call NetrwMapping()
    autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
    noremap <buffer> t k
    noremap <buffer> k t
endfunction

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


" manipulating tabs
" next tab
function! g:NextTab()
    :tabn
endfunction

" previous tab
function! g:PreviousTab()
    :tabN
endfunction


" manipulating windows
" next window
function! g:NextWindow()
    wincmd w
    if &buftype ==# 'terminal' || &buftype ==# 'nofile'
        call g:NextWindow()
    endif
endfunction


" previous window
function! g:PreviousWindow()
    wincmd W
    if &buftype ==# 'terminal' || &buftype ==# 'nofile'
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

" insert CR
nnoremap <silent> <Leader><CR> o<ESC><UP>

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

nnoremap <silent> <Leader>e :NERDTreeFocus<CR>


" open terminal
nnoremap <silent> <Leader>t :call SwitchToTerm()<CR>
nnoremap <silent> <Leader>T :call OpenTermVert()<CR>



" clear highlight and redraw
nnoremap <silent> <Leader>l :<C-u>nohlsearch<CR><C-l>

" move with CamelCaseMotion for the default
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

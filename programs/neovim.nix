{ enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;
  extraConfig = ''
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
  '';
}

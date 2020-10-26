tnoremap <ESC> <Nop>
tnoremap <silent> <ESC> <C-\><C-n>
tnoremap <C-l> <C-\><C-n>:q!


function! g:SwitchToTerm()
    let term_bufs = GetTermBufs()
    if empty(term_bufs)
        call OpenTerm()
    else
        let current_buf = bufnr('%')
        let idx = index(term_bufs, current_buf)
        if idx == -1
            let term_idx = 0
        else
            let term_idx = (idx + 1) % len(term_bufs)
        endif
        let term_buf = term_bufs[term_idx]
        let term_win = win_findbuf(term_buf)[0]
        call win_gotoid(term_win)
        call feedkeys("i")
    endif
endfunction


function! g:OpenTerm()
    if has('nvim')
        exec g:term_height . 'new | terminal'
    else
        exec "terminal ++rows=" . g:term_height
    endif
    startinsert!
endfunction

function! g:OpenTermVert()
    if has('nvim')
        :vs | terminal
    else
        :vert term
    endif
    startinsert!
endfunction

function! GetTermBufs()
    if has('nvim')
        let bufs = range(1, bufnr('$'))
        let term_bufs = filter(bufs, "bufname(v:val) =~# '^term'")
    else
        let term_bufs = term_list()
    endif
    return term_bufs
endfunction



" switch to insert mode if entered window is terminal
" if has('nvim')
"   " Neovim 用
"   autocmd WinEnter * if &buftype ==# 'terminal' | startinsert! | endif
" else
"   " Vim 用
"   autocmd WinEnter * if &buftype ==# 'terminal' | normal i | endif
" endif

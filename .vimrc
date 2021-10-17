" load default file on `vim`
if v:progname ==? "vim"
    " Get the defaults that most users want.
    source $VIMRUNTIME/defaults.vim
endif


if &compatible
    set nocompatible
endif

" if &t_Co > 2 || has("gui_running")
"     " Switch on highlighting the last used search pattern.
"     set hlsearch
" endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
    au!
    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78
augroup END

if has('syntax') && has('eval')
    packadd! matchit
endif


" Required:
filetype plugin indent on



if has("vms")
    set nobackup        " do not keep a backup file, use versions instead
else

    set backup          " keep a backup file (restore to previous version)
    if has('persistent_undo')
        set undofile    " keep an undo file (undo changes after closing)
    endif

    if has ("nvim")
        let g:vim_home = expand('~/.nvim')
        let g:init_rc = expand('/.config/nvim/init.vim')
    else
        let g:vim_home = expand('~/.vim')
        let g:init_rc = expand(vim_home . '/.vimrc')
    endif

    let g:rc_dir = expand('~/.vim/rc')

    " where to generate backup / undo file
    execute 'set' 'backupdir=' . g:vim_home . '/tmp'
    execute 'set' 'undodir='   . g:vim_home . '/tmp'

endif


" load source
function! s:source_rc(rc_file_name)
    let rc_file = expand(g:rc_dir . '/' . a:rc_file_name)
    if filereadable(rc_file)
        execute 'source ' . rc_file
    endif
endfunction

" exec init script
function! Reload()
    if filereadable(g:init_rc)
        execute 'source' g:init_rc
    endif
endfunction

command! Reload call Reload()

let s:scripts = ['settings.vim', 'keymaps.vim', 'terminal.vim', 'binary.vim', 'plugin.vim', 'syntax.vim', 'local'vim']

" load script files
for s in s:scripts
    call s:source_rc(s)
endfor

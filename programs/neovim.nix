{ pkgs }:

{
  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;

  plugins = with pkgs.vimPlugins; [
    elm-vim
    rust-vim
    camelcasemotion
    nerdtree
    vim-nix
  ];

  extraConfig = ''
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


    " Automatically open NERDTree for all tabs
    autocmd VimEnter * NERDTree | wincmd w
    autocmd BufWinEnter * NERDTreeMirror
    let NERDTreeMapOpenInTab='<ENTER>'



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

    source ${../.vim/rc/keymaps.vim}
    source ${../.vim/rc/settings.vim}
    source ${../.vim/rc/syntax.vim}
    source ${../.vim/rc/terminal.vim}
  '';
}

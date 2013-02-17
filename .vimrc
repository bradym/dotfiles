" Setup Pathogen {
    source ~/.vim/bundle/pathogen/autoload/pathogen.vim
    call pathogen#runtime_append_all_bundles()
    call pathogen#helptags()
" }

" Basic settings {
    filetype plugin indent on               " load filetype plugins/indent settings
    let mapleader=','                       " set value for <Leader>

    set autoread                            " watch for file changes
    set backspace=indent,eol,start          " make backspace more flexible
    set clipboard+=unnamed                  " share system clipboard
    set directory=/tmp                      " where to put swap files
    set encoding=utf-8                      " set encoding to utf-8
    set fileencoding=utf-8                  " set encoding to utf-8
    set fileencodings=utf-8                 " set encoding to utf-8
    set fileformat=unix                     " use unix linebreaks
    set hidden                              " allow switching between buffers without saving
    set iskeyword+=_,$,@,%,#                " none of these are word dividers
    set nobackup                            " don't make backup files
    set nocompatible                        " get out of vi-compatible mode
    set noerrorbells                        " don't make noise
    set ttyfast                             " we have a fast terminal
    set undolevels=1000                     " 1000 undos
    set updatecount=100                     " switch every 100 chars
    set visualbell t_vb=
    set whichwrap=b,s,<,>,[,],h,l           " allow commands to wrap
    set wildignore+=*.o,*~,.lo              " ignore object files
    set wildmenu                            " menu has tab completion
    set wildmode=longest:full               " completion mode for wildmenu, complete till longest common string and start wildmenu
" } 

" Spell check settings {
    if v:version >= 700
        setlocal spelllang=en_us            " Set spelling language
        nmap <Leader>ss :set spell!<CR>     " toggle spell check
    endif
" }

" UI settings {
    syntax on                               " enable syntax highlighting

    set cmdheight=2                         " command line two lines high
    set cursorline                          " highlight current line
    set laststatus=2                        " always show status line
    set lazyredraw                          " don't redraw when don't have to
    set linebreak                           " smarter wordwrap
    set more                                " listings pause when the whole screen is filled
    set number                              " turn on line numbers
    set report=0                            " always report changes
    set ruler                               " always show current position in file
    set scrolloff=10                        " always keep 10 lines above and below cursor
    set showcmd                             " show partial command in the last line of the screen
    set showfulltag                         " show full completion tags
    set showmode                            " show mode on last line of the screen
    set showtabline=0                       " don't use tabs
    set sidescrolloff=10                    " always keep 10 lines to the left and right of cursor

    if has("gui_running")
        set gfn=Monaco                      " what font to use
        set guioptions=mre                  " show menubar, right scrollbar and tabline
        set tabline=1                       " show tabline only when there are at least 2 tabs open
        colorscheme vilight                 " set colorscheme
    else
        colorscheme koehler                 " set colorscheme
    endif
" }

" Tab settings {
    set expandtab                           " expand tabs to spaces
    set shiftwidth=4                        " number of spaces to use with autoindent
    set smarttab                            " tab and backspace are smart
    set softtabstop=4                       " number of spaces used by expandtab
    set tabstop=4                           " size of a real tab character
" }

" Search options {
    set ignorecase                          " case insensitve searching by default
    set smartcase                           " do case sensitive searches when caps are present
" }

" Text formatting {
    set autoindent                          " copy indent from current line when starting a new line
    set infercase                           " infer case when doing keyword completion
    set shiftround                          " when at 3 spaces, and I hit > ... go to 4, not 5
    set smartindent                         " smart autoindenting for c-like languages
" }

" Fold settings {
    set foldcolumn=0                        " hide fold column
    set foldenable                          " turn on folding
    set foldmethod=syntax                   " fold on syntax automagically, always
" }

" Custom file type mappings {
    au BufNewFile,BufRead capfile setf ruby " Setup capfile as ruby file
" }

" Custom key mappings {
    map <Leader>ww :set wrap!<CR>                                           " Toggle wordwrap
    map <Leader>dcd :DiffChangesDiffToggle<CR>                              " Show changes in current file
    map <Leader>p :let @x = substitute(@*, '\n', '','g')<CR>"xgp `[         " Strip newlines before pasting
    nnoremap ; :
    nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>             " Delete blank line below current line
    nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>             " Delete blank line above current line

    " On mac, use command key instead of alt
    if has("macunix")
        nnoremap <silent><D-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>     " Insert blank line below current line
        nnoremap <silent><D-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>     " Insert blank line above current line
    else
        nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>     " Insert blank line below current line
        nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>     " Insert blank line above current line
    endif

    map <MouseMiddle> <esc>"*p                                              " Make middle mouse button paste text without formatting it

    map <F3> :NERDTreeToggle<CR>                                            " Toggle NERDTree
    map <F4> :TlistToggle<CR>                                               " Toggle Tag List
    map <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>       " Strip all trailing whitespace in file 
    map <F7> :TaskList<CR>                                                  " Toggle Task List
    map <F8> :Scratch<CR>                                                   " Open scratch buffer
    map <F9> :Sscratch<CR>                                                  " Open scratch buffer and split window horizontally
" }

" Plugin Settings {

    "NERDTree Settings {
        let NERDChristmasTree = 1
        let NERDTreeShowFiles = 1
        let NERDTreeShowBookmarks = 1
    " }

    " Taglist settings {
        let Tlist_Exit_OnlyWindow = 1                   " if taglist is the last window open, close vim
        let Tlist_GainFocus_On_ToggleOpen = 1           " immediately give focus to taglist when opened
        let Tlist_Show_Menu = 1                         " show taglist menu
        let Tlist_Show_One_File = 1                     " only show tags from current file
        let Tlist_Sort_Type = "name"                    " order by
        let Tlist_Show_Menu = 1                         " show tags menu

        if has("macunix")
            let Tlist_Ctags_Cmd='/usr/local/bin/ctags'  " where is ctags binary located
        endif
    " }

    " Tasklist settings {
        let g:tlWindowPosition = 1
    " }

    " Snipmate settings {
        let g:snips_trigger_key='<c-space>'
    " }
    
    " Syntastic settings {
        let g:syntastic_check_on_open = 1
        let g:syntastic_auto_loc_list=1
        let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
    " }
" }

" Win32 Settings {
    if has("win32") || has("win64")
        source $VIMRUNTIME/mswin.vim
        set keymodel = ""               " Disable select mode
        set selectmode = ""             " Disable select mode
        set directory=$TMP              " Put swap files in windows temp directory
    endif
" }

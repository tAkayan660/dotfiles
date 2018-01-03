""""""""""""""""""""""""""""
" dein.vim
""""""""""""""""""""""""""""
if &compatible
    set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.vim/dein')
    call dein#begin('~/.vim/dein')

    let g:rc_dir    = expand('~/.vim/dein')
    let s:toml      = g:rc_dir . '/dein.toml'
    let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#add('Shougo/dein.vim')
    "call dein#add('Shougo/deoplete.nvim')
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif

    call dein#add('Shougo/neocomplete')
    call dein#add('Shougo/neosnippet')
    call dein#add('Shougo/neosnippet-snippets')
    call dein#add('nathanaelkane/vim-indent-guides')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('w0ng/vim-hybrid')
    call dein#add('scrooloose/nerdtree')
    call dein#add('scrooloose/nerdcommenter')
    call dein#add('vim-syntastic/syntastic.git')
    call dein#add('majutsushi/tagbar')
    call dein#add('airblade/vim-gitgutter')
    call dein#add('honza/vim-snippets')
    call dein#add('terryma/vim-multiple-cursors')
    call dein#add('tpope/vim-fugitive')
    call dein#add('zebult/auto-gtags.vim')

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
    call dein#install()
endif

""""""""""""""""""""""""""""

set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
set tags=./tags,tags,tags;/
set fileformats=unix,dos,mac

set autoindent
set modeline

set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" 行表示
set number
set cursorline

" 表示画面幅を超える行を折り返して表示しない
"set nowrap

" 検索の時、大文字小文字を区別しない
set ic

" 検索ハイライト
set hlsearch
" 消す
nnoremap <ESC><ESC> :noh<CR>

"""""""""""""""""""""""""""""
" バックアップ先
"""""""""""""""""""""""""""""
set directory=~/.vim/tmp
set backupdir=~/.vim/backups/

"""""""""""""""""""""""""""""
" 補完
"""""""""""""""""""""""""""""
" neocomplete
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
"let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" http://inari.hatenablog.com/entry/2014/05/05/231307

"""""""""""""""""""""""""""""
" 全角スペースの表示
"""""""""""""""""""""""""""""
function! ZenkakuSpace()        
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray 
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif

""""""""""""""""""""""""""""""
" 自動的に閉じ括弧を入力
""""""""""""""""""""""""""""""
"imap { {}<LEFT>
"imap [ []<LEFT>
"imap ( ()<LEFT>

""""""""""""""""""""""""""""""
" vim-airline
""""""""""""""""""""""""""""""
set t_Co=256
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let b:airline_whitespace_disabled = 1

""""""""""""""""""""""""""""""
" hybrid
""""""""""""""""""""""""""""""
let g:hybrid_use_iTerm_colors = 1
set background=dark
colorscheme hybrid
syntax on

""""""""""""""""""""""""""""""
" gtags
""""""""""""""""""""""""""""""
map <C-g> :Gtags -g
map <C-h> :Gtags -f %<CR>
map <C-j> :GtagsCursor<CR>
map <C-n> :cn<CR>
map <C-p> :cp<CR>

" tagFileの指定
if has('path_extra')
    set tags+=tags;/home/$HOME
endif

""""""""""""""""""""""""""""""
" 自動コメントアウト無効化
""""""""""""""""""""""""""""""
augroup auto_comment_off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
augroup END

""""""""""""""""""""""""""""""
" tagbar
""""""""""""""""""""""""""""""
nmap <F8> :TagbarToggle<CR>

""""""""""""""""""""""""""""""
" auto-gtags.vim
""""""""""""""""""""""""""""""
let g:auto_gtags = 1

""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""
nnoremap <silent><C-e> :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""
" vim-indent-guides
""""""""""""""""""""""""""""""
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guides_size = 1

""""""""""""""""""""""""""""""
" neosnippet
""""""""""""""""""""""""""""""
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

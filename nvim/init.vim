"----------------------------------------------------------------
" dein.vim
"----------------------------------------------------------------
let g:python3_host_prog	= '/usr/bin/python3'
let g:python_host_prog	= '/usr/bin/python'

let $DEIN_CACHE_DIR		= expand('$XDG_CACHE_HOME/dein')
let $DEIN_CONFIG_DIR	= expand('$XDG_CONFIG_HOME/nvim')
let $DEIN_REPOS_DIR		= expand('$DEIN_CACHE_DIR/repos/github.com/Shougo/dein.vim')

let $TOML		= expand('$DEIN_CONFIG_DIR/dein.toml')
let $TOML_LAZY	= expand('$DEIN_CONFIG_DIR/dein_lazy.toml')

if &compatible
	set nocompatible
endif

set runtimepath^=$DEIN_REPOS_DIR

if dein#load_state($DEIN_CACHE_DIR)
	call dein#begin($DEIN_CACHE_DIR)

	call dein#add($DEIN_REPOS_DIR)

	call dein#load_toml($TOML,      {'lazy': 0})
	call dein#load_toml($TOML_LAZY, {'lazy': 1})

	call dein#end()
	call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
	call dein#install()
endif

"----------------------------------------------------------------

set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
set tags=./tags,tags,tags;/
set fileformats=unix,dos,mac

set autoindent
set modeline

set tabstop=4 shiftwidth=4 softtabstop=4 "expandtab
set wrapscan

" 行表示
set number
set cursorline

" 検索の時、大文字小文字を区別しない
"set ic

" 検索ハイライト
set hlsearch
" 消す
nnoremap <ESC><ESC> :noh<CR>

"----------------------------------------------------------------
" 全角スペースの表示
"----------------------------------------------------------------
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

"----------------------------------------------------------------
" jellybeans
"----------------------------------------------------------------
set background=dark
colorscheme jellybeans

"----------------------------------------------------------------
" airline
"----------------------------------------------------------------
set t_Co=256
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let b:airline_whitespace_disabled = 1

"----------------------------------------------------------------
" gtags
"----------------------------------------------------------------
map <C-g> :Gtags -g
map <C-h> :Gtags -f %<CR>
map <C-j> :GtagsCursor<CR>
map <C-n> :cn<CR>
map <C-p> :cp<CR>

" tagFileの指定
if has('path_extra')
	set tags+=tags;/home/$HOME
endif

"----------------------------------------------------------------
" 自動コメントアウト無効化
"----------------------------------------------------------------
"augroup auto_comment_off
"    autocmd!
"    autocmd BufEnter * setlocal formatoptions-=r
"    autocmd BufEnter * setlocal formatoptions-=o
"augroup END

"----------------------------------------------------------------
" vim-indent-guides
"----------------------------------------------------------------
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_guides_size = 1
"let g:indent_guides_start_level = 2

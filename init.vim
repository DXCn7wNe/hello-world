if &compatible
  set nocompatible " Be iMproved
endif

" === dein
set runtimepath+=/home/chicken/.config/nvim/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('/home/chicken/.config/nvim/dein')
  call dein#begin('/home/chicken/.config/nvim/dein')
  " ---
  call dein#load_toml('/home/chicken/.config/nvim/dein.toml', {'lazy': 0})
  call dein#load_toml('/home/chicken/.config/nvim/dein_lazy.toml', {'lazy': 1})
  " ---
  call dein#end()
  call dein#save_state()
endif
filetype plugin indent on
syntax enable

if dein#check_install()
    call dein#install()
endif

" === uninstall plugins
function! Uninstall_dein_plugins()
  call map(dein#check_clean(), "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endfunction

" === keymap (.vimrc)
let mapleader = "\<Space>"
nnoremap <Esc><Esc> :noh<CR>h "ハイライト表示を消す。
" sudo権限で保存する。(sudoのパスワード入力ができないためにエラーが発生する。)
" cnoremap w!! w !sudo tee > /dev/null %
cnoremap w!! SudoWrite %

" === path (.vimrc)
" set directory = "" "swapファイル(swp/一時保存ファイル/クラッシュ時の復元用)の保存場所の指定
" set undodir = "" "undoファイル(un~/undo情報)の保存場所の指定
" set backupdir = "" "backupファイル(~/1世代前のファイル)の保存場所の指定

" === behavior (.vimrc)
set backspace=indent,eol,start
set infercase "補完時に大文字小文字を区別しない。
set clipboard+=unnamedplus "標準のクリップボードバッファを+にする。
" unnamed(*)は選択したものが入るバッファ(PRIMARY)で、unnamedplus(+)はコピーしたものが入るバッファ(CLIPBOARD)。
" +=は現在の変数の後ろに挿入する。^=は現在の変数の前に挿入する。
"クリップボードにxselを用いる。(システム全体でクリップボードを共通化)
let g:clipboard = {
    \ 'name': 'cb', 
    \ 'copy': {'+': 'xsel -ib'}, 
    \ 'paste': {'+': 'xsel -ob'}, 
    \ 'cache_enabled': 1} 

" === format (.vimrc)
set number "行番号を表示する。
set nowrap "長い行の折り返しをしない。
" ---
set tabstop=4
set softtabstop=4 "Tabキーの移動量を設定する。
set expandtab
set smarttab "行頭でTabキーを押すとshiftwidth分、その他はtabstop分だけ空白を挿入する。
set shiftwidth=4 "smarttabが有効な場合に、行頭のインデント量を設定する。
set shiftround "tab時の空白幅をtabstopの整数倍に丸める。
" set smartindent "上行末尾を見て必要な場合に自動でインデントする。
" set autoindent "改行時に上行と同じ量だけインデントする。
" ---
" set list "不可視文字を表示する。
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
" ---
set nrformats-=octal "0で始まる数字を8進数扱いしない。

" === search (.vimrc)
set ignorecase "検索時に大文字小文字を区別しない。
set smartcase "検索文字列に大文字がない場合、大文字小文字を区別しないで検索する。
" ---
set incsearch
set hlsearch "検索結果をハイライトする。
set wildmode=longest,full
" ---
set showmatch

function! s:SelectColorScheme()
  let files = sort(map(split(globpath(&rtp, 'colors/*.vim'), "\n"), 'fnamemodify(v:val, ":t:r")'))
  silent 15vnew
  call setline(1, files)
  silent file `="SelectColorScheme"`
  setlocal bufhidden=wipe buftype=nofile nonu nomodifiable cursorline
  nnoremap <buffer>  <silent> j  j:<c-u>exe 'color' getline('.')<cr>
  nnoremap <buffer>  <silent> k  k:<c-u>exe 'color' getline('.')<cr>
  nnoremap <buffer>  <silent> q  :<c-u>close<cr>
endfunction

command! SelectColorScheme call s:SelectColorScheme()

" === completion (.vimrc)


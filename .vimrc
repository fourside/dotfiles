set nocompatible
set belloff=all
set directory=$HOME/tmp
set backup
set backupdir=$HOME/tmp
if has('path_extra')
    set tags+=.tags;
endif
if has('persistent_undo')
    set undodir=$HOME/.vimundo
    set undofile
endif
set path+=;

augroup My
au!
augroup END
"================================================================================
set number
set showmatch
set title
set incsearch
set ignorecase
set smartcase
set showcmd
set list
set display=uhex
set wrapscan
set nohlsearch
set t_Co=256
colorscheme wombat

" ステータスラインを常に表示
set laststatus=2

" ステータスラインに各種情報の表示
function! Fstat()
    return strftime('%y/%m/%d %H:%M:%S', getftime(expand('%')))
endfunction
set statusline=%F%m%r%h%w\ [%{&fenc!=''?&fenc:&enc}][%{&ff}][%Y]\ [%04l,%04v][%p%%][%Ll][%{Fstat()}]
hi StatusLine term=bold cterm=NONE ctermfg=black ctermbg=white

setlocal encoding=utf-8
setlocal fileencoding=utf-8

syntax on
filetype plugin on

set ruler
set showmode
set scrolloff=5
set history=50
"================================================================================
" indent, tab
set autoindent
set smartindent
set cindent
" see also http://peace-pipe.blogspot.com/2006/05/vimrc-vim.html
" タブ文字の幅
set tabstop=4
" vimが挿入するインデント幅
set shiftwidth=4
" tabキー押下時に挿入される幅
" 0のとき、tabstopの分だけ挿入される
set softtabstop=0
set expandtab

" share clipboard with other applications
set clipboard=unnamed

" let backspace delete LF, tab, space
set backspace=2
" コマンドライン補間をシェルっぽく
set wildmode=list:longest
" 辞書補完
set complete+=k

" バッファが編集中でもその他のファイルを開けるように
set hidden
" 外部のエディタで編集中のファイルが変更されたら自動で読み直す
set autoread
set cursorline

" 補完候補の色づけ for vim7
hi Pmenu ctermbg=Black
hi PmenuSel ctermbg=Gray
hi PmenuSel ctermfg=Black
hi PmenuSbar ctermbg=Black

" その他
set nrformats=hex,alpha     " 8進数をインクリメントしない。
set textwidth=0             " テキストの自動改行を抑える
"================================================================================
" key mappings

let g:mapleader=",""<Leader>
" jkを物理的行移動に。
nnoremap j gj
nnoremap k gk

" insertmodeでのカーソル移動
imap <C-l> <Right>
imap <C-f> <Right>
imap <C-b> <Left>
imap <C-j> <Down>
imap <C-k> <Up>

imap <C-a> <HOME>
"imap <C-e> <END>
imap <C-f> <Right>
imap <C-b> <Left>

" command mode 時 tcsh風のキーバインドに
cmap <C-A> <Home>
cmap <C-F> <Right>
cmap <C-B> <Left>
cmap <C-D> <Delete>
cmap <Esc>b <S-Left>
cmap <Esc>f <S-Right>

" buffer移動
nnoremap <C-l> :bn<CR>
nnoremap <C-h> :bp<CR>
nnoremap <C-j> <C-^>

nnoremap bd :bd<CR>
nnoremap <S-b><S-d> :bd!<CR>
" :ls
nnoremap <C-d> :ls<CR>

" 括弧、クォートの自動補完
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V{<C-R>z}<ESC>
vnoremap ( "zdi^V{<C-R>z}<ESC>
vnoremap " "zdi^V{<C-R>z}<ESC>
vnoremap ' "zdi^V{<C-R>z}<ESC>

" 現在のカーソル位置から次の閉じ括弧まで
onoremap ) t)
onoremap ( t(
vnoremap ) t)
vnoremap ( t(

" append line of =/-
nnoremap ,= 80i=<ESC>
nnoremap ,- 80i-<ESC>

"hlsearchのトグル
noremap <ESC><ESC> :<C-u>set nohlsearch!<CR>

" .vimrcの編集
nnoremap <Leader>e :<C-u>edit $MYVIMRC<CR>
" .vimrcの読み込み
nnoremap <Leader>s :<C-u>source $MYVIMRC<CR>
augroup My
    autocmd BufWritePost <buffer> silent source %
augroup END

"help
set keywordprg=:help

" スペースを含むファイル名を正しく取得する
"set isfname+=32

augroup My
" タブ幅2
    autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=0
    autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=0
    autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=0
"testファイルの場合filetype変更
    autocmd BufWinEnter,BufNewFile *Test.php setlocal filetype=php.unit
    autocmd BufWinEnter,BufNewFile test_*.rb setlocal filetype=ruby.unit
    autocmd BufWinEnter,BufNewFile *spec.rb setlocal filetype=ruby.rspec

" quickfixを自動で開く
" http://webtech-walker.com/archive/2009/09/29213156.html
    autocmd QuickFixCmdPost grep,grepadd,vimgrep if len(getqflist()) != 0 | copen | endif

" gitのcommit時、urlではないとき
" bufferの場所にカレントディレクトリを合わせる
    autocmd BufEnter * 
    \ if bufname("") !~? "^\.git/COMMIT_EDITMSG$" && bufname("") !~? "^\[A-Za-z0-9\]*://" |
    \   lcd %:p:h |
    \ endif

" htmlをブラウザで開く
    autocmd FileType html,xhtml nnoremap <buffer><Leader>W :silent ! start firefox %<CR>
    autocmd FileType html,xhtml :compiler tidy
    autocmd FileType html,xhtml :setlocal makeprg=tidy\ -raw\ -quiet\ -errors\ --gnu-emacs\ yes\ \"%\"

" 構文チェック
    autocmd FileType ruby silent compiler ruby | setlocal makeprg=ruby\ -cw\ %
    autocmd FileType php  silent compiler php  | setlocal makeprg=php\ -l\ %
    autocmd FileType php setlocal errorformat=%-E,%m\ in\ %f\ on\ line\ %l,%ZErrors\ parsing\ %f
    autocmd BufWritePost *.php,*.rb silent make
    autocmd QuickFixCmdPost make cw 3
augroup END

"================================================================================
" plugins

" NERD_commenter {{{
"コメントのトグル
nmap <Leader>d ,c<Space>
vmap <Leader>d ,c<Space>
"未対応ファイルタイプのエラーメッセージを表示しない
let NERDShutUp=1
"}}}
" for fugitive {{{
nnoremap <Space>gd :<C-u>Gdiff<Enter>
nnoremap <Space>gs :<C-u>Gstatus<Enter>
nnoremap <Space>gl :<C-u>Glog<Enter>
nnoremap <Space>ga :<C-u>Gwrite<Enter>
nnoremap <Space>gc :<C-u>Gcommit -v<Enter>
nnoremap <Space>gC :<C-u>Git commit --amend<Enter>
nnoremap <Space>gb :<C-u>Gblame<Enter>
" }}}
" quickrun {{{
let g:quickrun_config = {}
let g:quickrun_config['ruby.test'] = {'command': "rake"}
let g:quickrun_config['ruby.rspec'] = {'command': "rspec", 'cmdopt': '-fs --color'}
let g:quickrun_config['php.unit'] = {'command': "phpunit"}
"}}}
" errormarker {{{
let g:errormarker_errortext   = '!!'
let g:errormarker_warningtext = '??'
let g:errormarker_errorgroup  = 'my_error'
let g:errormarker_warninggroup= 'my_warning'
highlight my_error guifg=#FFFFFF guibg=#FF1100
highlight my_warning guifg=#000000 guibg=#FAFF11
"}}}
" MRU.vim {{{
cnoreabbrev m MRU<CR>
"}}}
"================================================================================
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

" 前回のカーソル位置を記憶"
if has("autocmd")
    augroup My
        autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif
    augroup END 
endif

" 日毎のメモ作成
function! s:OpenTodayLog()
    let l:dir =  expand('~/log')
    if !isdirectory(l:dir)
        call mkdir(l:dir)
    endif
    execute ':edit ' . l:dir . '/' . strftime('%Y%m%d') . '.txt'
endfunction
nnoremap <silent> <Leader>l :call <SID>OpenTodayLog()<CR>


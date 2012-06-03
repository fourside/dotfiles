"================================================================================
set nocompatible    "vim
call pathogen#runtime_append_all_bundles()
"================================================================================
" パス
" .swpファイルの場所
set directory=$HOME/tmp
set backupdir=$HOME/tmp
set tags=$HOME/.tags,./.tags

if has('persistent_undo')
    set undodir=$HOME/.vimundo
    set undofile
endif

" autocmd初期化
augroup My
au!
augroup END
"================================================================================
" 表示
set number
set showmatch   "対括弧の強調
set title       "編集中ファイル名の表示
set incsearch   "インクリメンタルサーチ
set ignorecase
set smartcase   "検索文字にひとつでも大文字があればイグノアしない
set showcmd     "コマンドをステータス行に表示
set list        "不可視文字表示
set display=uhex    "印刷不可の文字を16進表示
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" タブの左側にカーソル表示
"set listchars=tab:\\ 
" 検索結果文字列のハイライトを有効にしない
set nohlsearch
set t_Co=256

colorscheme wombat256mod

" ステータスラインを常に表示
set laststatus=2
" ステータスラインに各種情報の表示
"set statusline=%F%m%r%h%w\ [FENC=%{&fenc!=''?&fenc:&enc}]\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set statusline=%F%m%r%h%w\ [%{&fenc!=''?&fenc:&enc}][%{&ff}][%Y]\ [%04l,%04v][%p%%][%Ll]
hi StatusLine term=bold cterm=NONE ctermfg=black ctermbg=white

setlocal encoding=utf-8
setlocal fileencoding=utf-8

syntax on
filetype plugin on      "オムニ補完

set ruler   "ルーラー表示
set showmode    "モード表示
set scrolloff=5 "スクロール時の余白確保
set history=50

let g:mapleader="," "<Leader>
" 表示をツリー状に
let g:netrw_liststyle=3

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
set expandtab   "タブをスペースに変換

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

" set cursorline
highlight CursorLine ctermbg=Black
highlight CursorLine ctermfg=Blue

" 補完候補の色づけ for vim7
hi Pmenu ctermbg=Black
hi PmenuSel ctermbg=Gray
hi PmenuSel ctermfg=Black
hi PmenuSbar ctermbg=Black

" 全角スペースの視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guifg=#226666
match ZenkakuSpace /　/

"================================================================================
" key mappings

" jkを物理的行移動に。
nnoremap j gj
nnoremap k gk

" insertmodeでのカーソル移動
imap <C-l> <Right>
"imap <M-h> <Left>
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
" bufferdelete, update
nnoremap bd :bd<CR>
"nnoremap up :up<CR>
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

"inoremap <ESC> <ESC>:setlocal imdisable<CR>
"
"hlsearchのトグル
noremap <ESC><ESC> :<C-u>set nohlsearch!<CR>

" .vimrcの編集
nnoremap <Leader>e :<C-u>edit $MYVIMRC<CR>
" .vimrcの読み込み
nnoremap <Leader>s :<C-u>source $MYVIMRC<CR>
augroup My
    autocmd BufWritePost <buffer> silent source %
augroup END

",e でそのコマンドを実行
"nnoremap mx :execute '!' &ft ' %'<CR>

" sudo で保存する
cnoreabbrev sudow w !sudo tee %

" perl/rubyの構文チェックと実行
augroup My
    autocmd FileType perl :nnoremap <C-n> <ESC>:!perl -cw %<CR>
    autocmd FileType ruby :nnoremap <C-n> <ESC>:!ruby -cW %<CR>
    autocmd FileType php  :nnoremap <C-n> <ESC>:!php  -l  %<CR>
    autocmd FileType ruby :nnoremap <C-m> <ESC>:!ruby -Ku %<CR>
augroup END

" yeでそのカーソル位置にある単語をレジスタに追加
nmap ye :let @"=expand("<cword>")<CR>

"help
nnoremap <C-u> :<C-u>help<Space>
nnoremap <C-u><C-u> :<C-u>help<Space><C-r><C-w><Enter>

" utf-8で開き直す
nnoremap <Leader>u :<C-u>e ++enc=utf-8<CR>
" カーソル位置の単語でヘルプを引く
nnoremap <Space>h :<C-u>execute "h" expand("<cword>")<CR>
" スペースを含むファイル名を正しく取得する
"set isfname+=32

augroup My
" rubyはタブ幅2
    autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=0
    autocmd FileType ruby nnoremap i# encoding : utf-8<Esc>
" rails
    autocmd BufNewFile,BufRead app/**/*.rhtml setlocal fenc=utf-8
    autocmd BufNewFile,BufRead app/**/*.rb setlocal fenc=utf-8
"testファイルの場合filetype変更
    autocmd BufWinEnter,BufNewFile *_spec.rb setlocal filetype=ruby.rspec
    autocmd BufWinEnter,BufNewFile test_*.rb setlocal filetype=ruby.test
    autocmd BufWinEnter,BufNewFile *Test.php setlocal filetype=php.unit
" quickfixを自動で開く
" http://webtech-walker.com/archive/2009/09/29213156.html
    autocmd QuickFixCmdPost grep,grepadd,vimgrep if len(getqflist()) != 0 | copen | endif
" bufferの場所にカレントディレクトリを合わせる
    autocmd BufEnter * 
    \ if bufname("") !~? "^\.git/COMMIT_EDITMSG$" && bufname("") !~? "^\[A-Za-z0-9\]*://" |
    \   lcd %:p:h |
    \ endif

    if has('gui')
        autocmd FocusGained * set transparency=220
        autocmd FocusLost   * set transparency=100
        nnoremap <silent> <C-q> :call <SID>ToggleTransparency()<CR>
        function! s:ToggleTransparency()
            let &transparency = &transparency > 80 ? 80 : 220
        endfunction
    endif
" htmlをブラウザで開く
    autocmd FileType html,xhtml nnoremap <Leader>W :silent ! start firefox %<CR>
augroup END

"================================================================================
" plugins

" zencoding.vim
" きかない
"inoremap <Leader>i <C-y>,

" YankRing.vim
nmap <Leader>y :YRShow<CR>

" NERD_commenter
"コメントのトグル
nmap <Leader>d ,c<Space>
vmap <Leader>d ,c<Space>
"未対応ファイルタイプのエラーメッセージを表示しない
let NERDShutUp=1

" smartchr.vim
"inoremap <expr> = smartchr#one_of(' = ', ' == ', ' === ', '=')
inoremap <expr> & smartchr#one_of('&', ' & ', ' && ')
"inoremap <expr> | smartchr#one_of('|', ' | ', ' || ')
inoremap <expr> , smartchr#one_of(', ', ',')
inoremap <expr> ? smartchr#one_of('?', '? ')
inoremap <expr> { smartchr#loop('{', '#{', '{{{')

" ref.vim
let g:ref_open = 'split'
"let g:ref_cache_dir  =  s:plugin_info . 'ref'
"let g:ref_phpmanual_path  =  $HOME . '/share/doc/php'
let g:ref_alc_start_linenumber  =  37
let g:ref_alc_cmd = 'w3m -dump %s'
nmap <Leader>a :<C-u>execute "Ref alc" expand("<cword>")<CR>
nmap <Leader>A :<C-u>Ref alc 
let g:ref_refe_cmd = 'refe2'
nmap <Leader>R :<C-u>Ref refe 

" git-vim
let g:git_no_map_default = 1
let g:git_command_edit = 'rightbelow vnew'
nnoremap <Space>ga :<C-u>GitAdd<Enter>
nnoremap <Space>gA :<C-u>GitAdd <cfile><Enter>
nnoremap <Space>gc :<C-u>GitCommit -v<Enter>
nnoremap <Space>gC :<C-u>GitCommit --amend<Enter>
nnoremap <Space>gd :<C-u>GitDiff --cached<Enter>
nnoremap <Space>gD :<C-u>GitDiff<Enter>
nnoremap <Space>gs :<C-u>GitStatus<Enter>
nnoremap <Space>gl :<C-u>GitLog<Enter>
nnoremap <Space>gL :<C-u>GitLog -u \| head -10000<Enter>
nnoremap <Space>gp :<C-u>Git push
nnoremap <Space>gu :<C-u>Git unstage


let g:quickrun_config = {}
let g:quickrun_config['ruby.test'] = {'command': "rake"}
let g:quickrun_config['ruby.rspec'] = {'command': "rspec", 'cmdopt': '-fs --color'}
let g:quickrun_config['markdown'] = {'command': "bluecloth", 'exec': '%c %s'}
""================================================================================
" neocomplcache.vim
" 
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''}

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-g> <Plug>(neocomplcache_snippets_expand)
smap <C-g> <Plug>(neocomplcache_snippets_expand)

" gist.vim
source $HOME/.gist.vim
""================================================================================
" functions

" html escape function
function! HtmlEscape() 
    silent s/&/\&amp;/eg 
    silent s/</\&lt;/eg 
    silent s/>/\&gt;/eg 
endfunction 

function! HtmlUnEscape() 
    silent s/&lt;/</eg 
    silent s/&gt;/>/eg 
    silent s/&amp;/\&/eg 
endfunction 

function! RTrim()
    let s:cursor = getpos(".")
    %s/\s\+$//e
    call setpos(".", s:cursor)
endfunction
augroup My
    autocmd BufWritePre *.php,*.rb,*.js,*.bat call RTrim()
augroup END
"================================================================================
" 文字コード

" from ずんWiki http://www.kawaz.jp/pukiwiki/?vim#content_1_7
if &encoding !=# 'utf-8'
  set encoding=japan
endif
"set fileencoding=japan
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがJISX0213に対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^euc-\%(jp\|jisx0213\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      let &encoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
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

" タスクのマークトグル
function! s:ToggleDone()
    let l:line = getline('.')
    if l:line =~ ' \+=> done$'
        call setline('.', substitute(l:line, ' \+=> done$', '', ''))
    else
        execute "normal A\<C-i>=> done"
    endif
endfunction
nnoremap <silent> <Leader><S-d> :call <SID>ToggleDone()<CR>

" mysql csv dumpファイルをオートインクリメントする
function! s:Increment() range
    let l:num = 1
    for n in range(a:firstline, a:lastline)
        if getline(n) =~ '^\\N'
            call setline(n, substitute(getline(n), '^\\N', l:num, ''))
            let l:num += 1
        endif
    endfor
endfunction
nnoremap <silent> <Leader>i :%call <SID>Increment()<CR>

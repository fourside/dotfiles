"================================================================================
set nocompatible	"vim
"================================================================================
" パス
".swpファイルの場所指定
""set directory & directory+=$HOME/.vim/tmp
set directory & directory+=$VIM/tmp
"================================================================================
" 表示
set number
set showmatch	"対括弧の強調
set title		"編集中ファイル名の表示
set incsearch	"インクリメンタルサーチ
set ignorecase
set smartcase	"検索文字にひとつでも大文字があればイグノアしない
set showcmd		"コマンドをステータス行に表示
set list		"不可視文字表示
set display=uhex	"印刷不可の文字を16進表示
"検索時に最後まで行ったら最初に戻る
set wrapscan
"タブの左側にカーソル表示
"set listchars=tab:\\ 
set nolist
"検索結果文字列のハイライトを有効にしない
set nohlsearch
"ステータスラインを常に表示
set laststatus=2
"ステータスラインに各種情報の表示
set statusline=%F%m%r%h%w\ [FENC=%{&fenc!=''?&fenc:&enc}]\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
hi Statusline term=NONE cterm=NONE ctermfg=black ctermbg=lightgrey

syntax on
filetype plugin on		"オムニ補完
setlocal encoding=utf-8
setlocal fileencoding=utf-8

set ruler	"ルーラー表示
set showmode	"モード表示
set scrolloff=5	"スクロール時の余白確保
let g:mapleader=","	"<Leader>

augroup My
au!
augroup END

"================================================================================
" indent
set autoindent
set smartindent
set cindent
" see also http://peace-pipe.blogspot.com/2006/05/vimrc-vim.html
"タブ文字の幅
set tabstop=4
"vimが挿入するインデント幅
set shiftwidth=4
"tabキー押下時に挿入される幅
"0のとき、tabstopの分だけ挿入される
set softtabstop=0
set noexpandtab	"タブをスペースに変換しない
"rubyのとき狭くする
augroup My
	autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=0
augroup END

" share clipboard with other applications
set clipboard=unnamed

" let backspace delete LF, tab, space
set backspace=2
" コマンドライン補間をシェルっぽく
set wildmode=list:longest
"辞書補完
set complete+=k

" バッファが編集中でもその他のファイルを開けるように
set hidden
" 外部のエディタで編集中のファイルが変更されたら自動で読み直す
set autoread

" highlight current line
"set cursorline
highlight CursorLine ctermbg=Black
highlight CursorLine ctermfg=Blue

" 全角スペースの視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guifg=#226666
match ZenkakuSpace /　/

"================================================================================
"key mappings

" jkを物理的行移動に。
nnoremap j gj
nnoremap k gk

" insertmodeでのカーソル移動
imap <C-l> <Right>
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>

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
" bufferdelete
nnoremap ,bd :bd<CR>

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

inoremap <ESC> <ESC>:setlocal imdisable<CR>
" .vimrcの編集
nnoremap <Leader>e :<C-u>edit $MYVIMRC<CR>
" .vimrcの読み込み
nnoremap <Leader>s :<C-u>source $MYVIMRC<CR>

",e でそのコマンドを実行
nnoremap mx :execute '!' &ft ' %'<CR>

" yeでそのカーソル位置にある単語をレジスタに追加
nmap ye :let @"=expand("<cword>")<CR>

" 補完候補の色づけ for vim7
hi Pmenu ctermbg=Black
hi PmenuSel ctermbg=Gray
hi PmenuSel ctermfg=Black
hi PmenuSbar ctermbg=Black

"exコマンド用 for qwerty
"慣れないのでコメントアウト
"noremap ; :
"noremap : ;

"入力補完
"omni completion
"inoremap <C-f> <C-x><C-o>
" utf-8で開き直す
nnoremap ,u :<C-u>e ++enc=utf-8<CR>
"================================================================================
"plugins

"let g:netrw_http_cmd = 'wget'

" closetag.vimの自動読み込み
augroup My
	autocmd FileType html,xml,xsl,jsp,erb source ~/.vim/macros/closetag.vim
augroup END

" zencoding.vim
" きかない…
"noremap <C-y> <C-y>,

" YankRing.vim
" yank履歴の表示
nmap ,y :YRShow<CR>

" CD.vim example:// は適用しない
" bufferの場所にカレントディレクトリを合わせる
aug My
	autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
aug END

"qbuf.vim
"bufferリスト
nmap ,b <F4>
"let g:qb_hotkey="<space><space>"

"NERD_commenter.vim
"コメントのトグル
map ,d ,c<Space>
"未対応ファイルタイプのエラーメッセージを表示しない
let NERDShutUp=1

"fuf.vim
"nnoremap <unique> <silent> <C-S> :FufBuffer!<CR>
"nnoremap <unique> <silent> ef :FufFile!<CR>
"nnoremap <silent> eff :FufFile!<CR>
nnoremap <silent> fb :FufBuffer!<CR>
nnoremap <silent> ff :FufFile!<CR>
nnoremap <silent> gb :FufFile **/<CR>
nnoremap <silent> mf :FufMruFile!<CR>
augroup My
	autocmd FileType fuf nmap <C-c> <ESC>
augroup END
let g:fuf_splitPathMatching = ' '
let g:fuf_patternSeparator = ' '
let g:fuf_modesDisable = ['mrucmd']
let g:fuf_mrufile_exclude = '\v\~$|\.bak$|\.swp|\.howm$'
let g:fuf_mrufile_maxItem = 10000
let g:fuf_enumeratingLimit = 20

"css_color.vim
"cssカラーコードの背景色にその色
"aug CSS_COLOR
"autocmd!
"autocmd FileType css,html source '$HOME/.vim/ftplugin/css.vim'
"aug END
":message <SNR>49_ScanWholeBuffer 未知の関数　

"smartchr.vim
"イコールを入力すると前後に空白を挿入
"連続して入力する
"inoremap <expr> = smartchr#one_of(' = ', ' == ', ' === ', '=')
inoremap <expr> & smartchr#one_of('&', ' & ', ' && ')
"inoremap <expr> | smartchr#one_of('|', ' | ', ' || ')
inoremap <expr> , smartchr#one_of(', ', ',')
inoremap <expr> ? smartchr#one_of('?', '? ')

"surround.vim

"ref.vim
let g:ref_open  =  'split'
"let g:ref_cache_dir  =  s:plugin_info . 'ref'
"let g:ref_phpmanual_path  =  $HOME . '/share/doc/php'
let g:ref_alc_start_linenumber  =  37
nmap ,a :<C-u>execute "Ref alc" expand("<cword>")<CR>
""================================================================================
"neocomplcache
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
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()
"" Recommended key-mappings.
"" <CR>: close popup and save indent.
"inoremap <expr><CR>  (pumvisible() ? "\<C-y>":'') . "\<C-f>\<CR>X\<BS>"
"" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> pumvisible() ? neocomplcache#close_popup()."\<C-h>" : "\<C-h>"
"inoremap <expr><BS> pumvisible() ? neocomplcache#close_popup()."\<C-h>" : "\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1
"inoremap <expr><CR>  (pumvisible() ? "\<C-e>":'') . (&indentexpr != '' ? "\<C-f>\<CR>X\<BS>":"\<CR>")
"inoremap <expr><C-h> pumvisible() ? neocomplcache#cancel_popup()."\<C-h>" : "\<C-h>"
"inoremap <expr><BS> pumvisible() ? neocomplcache#cancel_popup()."\<C-h>" : "\<C-h>"

""================================================================================
"functions

" html escape function
:function! HtmlEscape() 
silent s/&/\&amp;/eg 
silent s/</\&lt;/eg 
silent s/>/\&gt;/eg 
:endfunction 

:function! HtmlUnEscape() 
silent s/&lt;/</eg 
silent s/&gt;/>/eg 
silent s/&amp;/\&/eg 
:endfunction 


" {{{}}}Autocompletion using the TAB key
" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
" see also http://blog.blueblack.net/item_164
"function! InsertTabWrapper()
        "let col = col('.') - 1
        "if !col || getline('.')[col - 1] !~ '\k'
                "return "\<TAB>"
        "else
                "if pumvisible()
                        "return "\<C-N>"
                "else
                       "return "\<C-N>\<C-P>"
                "end
        "endif
"endfunction
" Remap the tab key to select action with InsertTabWrapper
"inoremap <TAB> <c-r>=InsertTabWrapper()<cr>

"================================================================================
"文字コード

" from ずんWiki http://www.kawaz.jp/pukiwiki/?vim#content_1_7
if &encoding !=# 'utf-8'
  set encoding=japan
endif
set fileencoding=japan
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

"rails
augroup My
	au BufNewFile,BufRead app/**/*.rhtml set fenc=utf-8
	au BufNewFile,BufRead app/**/*.rb set fenc=utf-8
augroup END



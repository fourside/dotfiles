" 以下vimrcのコピペ
"================================================================================
" plugins下のディレクトリをruntimepathへ追加する。
for path in split(glob($VIM.'/plugins/*'), '\n')
  if isdirectory(path) | let &runtimepath = &runtimepath.','.path | end
endfor
"---------------------------------------------------------------------------
" 日本語対応のための設定:
"
" ファイルを読込む時にトライする文字エンコードの順序を確定する。漢字コード自
" 動判別機能を利用する場合には別途iconv.dllが必要。iconv.dllについては
" README_w32j.txtを参照。ユーティリティスクリプトを読み込むことで設定される。
source $VIM/plugins/kaoriya/encode_japan.vim
"================================================================================

" $VIM/vimrcで設定を上書きしない
let g:vimrc_local_finish = 1

let $MYVIMRC = "C:/Users/adrock/Dropbox/My\ Dropbox/dotfiles/.vimrc"
source $MYVIMRC


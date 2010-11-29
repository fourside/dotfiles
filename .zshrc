alias s='screen'
alias sr='screen -r'
alias sx='screen -x'
alias diff='diff -u'

alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias l.='ls -a --color=auto'
alias ll.='ls -al --color=auto'

alias -g G='|grep '
alias -g L='|less '
alias -g T='|tee tee.log |less'
alias -g W='|wc'
alias -g V='| vim -'
alias rm='mv -f --backup=numbered --target-directory=~/.Trash'

export EDITOR='vim'
export PAGER='less'
export PATH=$PATH:"$HOME/bin"
if [[ -s $HOME/.rvm/scripts/rvm ]]; then source $HOME/.rvm/scripts/rvm ; fi

autoload -U compinit
compinit

# auto change directory
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd

# command correct edition before each completion attempt
#setopt correct

# compacked complete list display
setopt list_packed

# no beep sound when complete list displayed
setopt nolistbeep

autoload -Uz colors
colors

#autoload predict-on
#predict-on

## Environment variable configuration
# LANG
#
export LANG=ja_JP.UTF-8

## Default shell configuration
# set prompt
#
case ${UID} in
0)
	PROMPT="%B%{[31m%}%n#%{[m%}%b "
    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT="%{[31m%}%n%#%{[m%} "
    PROMPT2="%{[31m%}%_%%%{[m%} "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
esac
RPROMPT="%{$fg_bold[white]%}[%{$reset_color%}%{$fg[red]%}%/%{$reset_color%}%{$fg_bold[white]%}]%{$reset_color%}"

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac 

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data 


## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes 
#   to end of it)
#
bindkey -e
 
# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

#--prefix=の後のパス名を補完
#
setopt magic_equal_subst

#URLのコピペ時にエスケープする
#
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

#bindkey "^[^[[C" forward-word
#bindkey "^[^[[D" backward-word 

#pidを得る
# see http://memo.officebrook.net/20100123.html
zstyle ':completion:*:processes' command 'ps x -o pidsargs'

#mysqlのプロンプト
#http://subtech.g.hatena.ne.jp/secondlife/20100427/1272350109
export MYSQL_PS1='([32m\u[00m@[33m\h[00m) [34m[\d][00m > '

#http://d.hatena.ne.jp/mollifier/20100906/p1
#gitのブランチ名を表示
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

autoload -Uz is-at-least
if is-at-least 4.3.10; then
# この check-for-changes が今回の設定するところ
	zstyle ':vcs_info:git:*' check-for-changes true
	zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
	zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
	zstyle ':vcs_info:git:*' formats '[%b]%c%u'
	zstyle ':vcs_info:git:*' actionformats '[%b|%a]%c%u'
fi

function _update_vcs_info_msg() {
	psvar=()
	LANG=en_US.UTF-8 vcs_info
	[[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg

#http://subtech.g.hatena.ne.jp/cho45/20080617/1213629154
#gitのキャレットをzshに解釈させない
typeset -A abbreviations
abbreviations=(
		"HEAD^"     "HEAD\\^"
		"HEAD^^"    "HEAD\\^\\^"
		"HEAD^^^"   "HEAD\\^\\^\\^"
		"HEAD^^^^"  "HEAD\\^\\^\\^\\^\\^"
		"HEAD^^^^^" "HEAD\\^\\^\\^\\^\\^"
		)
magic-abbrev-expand () {
	local MATCH
	LBUFFER=${LBUFFER%%(#m)[-_a-zA-Z0-9^]#}
	LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
}

magic-abbrev-expand-and-insert () {
	magic-abbrev-expand
	zle self-insert
}

magic-abbrev-expand-and-accept () {
	magic-abbrev-expand
	zle accept-line
}

no-magic-abbrev-expand () {
	LBUFFER+=' '
}
zle -N magic-abbrev-expand
zle -N magic-abbrev-expand-and-insert
zle -N magic-abbrev-expand-and-accept
zle -N no-magic-abbrev-expand
bindkey "\r"  magic-abbrev-expand-and-accept # M-x RET はできなくなる
bindkey "^J"  accept-line # no magic
bindkey " "   magic-abbrev-expand-and-insert
bindkey "."   magic-abbrev-expand-and-insert
bindkey "^x " no-magic-abbrev-expand
RPROMPT+="%1(v|%F{green}%1v%f|)"
